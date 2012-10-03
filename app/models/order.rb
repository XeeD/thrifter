class Order < ActiveRecord::Base

  has_many :order_items, autosave: true, dependent: :destroy
  has_many :purchasables, through: :order_items

  has_one :shipment
  has_one :shipping_method, through: :shipment
  has_one :company, through: :customer

  belongs_to :customer

  after_initialize :set_defaults

  before_create :generate_order_token#, :generate_order_number
  #after_create :create_shipment, :create_payment

  before_save :update_order
  #after_save :update_shipment, :update_payment

  validates :token,
            length: {maximum: 60},
            uniqueness: true

  validates :number,
            length: {maximum: 20},
            uniqueness: true

  validates :state,
            inclusion: %w(in_progress completed confirmed canceled resumed returned sent)

  validates :customer_type,
            presence: true,
            inclusion: %w(company individual)

  #validates :company,
  #          presence: true,

  #with_options unless: :in_progress? do |v|
  #  v.validates :total,
  #              presence: true,
  #              numericality: {only_integer: true}
  #
  #  v.validates :item_total,
  #              presence: true,
  #              numericality: {only_integer: true}
  #
  #  v.validates :number,
  #              presence: true
  #end

  with_options if: :use_billing_address do |v|
    v.validates :company,
                presence: true
  end

  attr_protected :item_total, :total, :token, :number
  attr_accessor  :customer_type, :newsletter, :use_billing_address

  accepts_nested_attributes_for :order_items
  accepts_nested_attributes_for :customer
  accepts_nested_attributes_for :company, reject_if: :all_blank, allow_destroy: true

  delegate :name,
           :ico,
           :dic,

           to: :company, prefix: true

  delegate :whole_name,
           :first_name,
           :last_name,
           :email,
           :phone,

           to: :customer, prefix: true

  state_machine :state, initial: :in_progress do

    event :complete do
      transition :in_progress => :completed
    end

    event :confirm do
      transition :completed => :confirmed
    end

    event :cancel do
      transition [:resumed, :completed, :confirmed] => :canceled
    end

    event :resume do
      transition :canceled => :resumed
    end

    event :send do
      transition [:resumed, :confirmed] => :sent
    end

    event :return do
      transition :sent => :returned
    end
  end

  def complete
    self.completed_at = Time.now
    self.save
  end

  def completed?
    !! completed_at
  end

  def contains_goods?(goods_id, goods_type)
    order_items.select {|order_item|
      order_item.purchasable.id == goods_id && order_item.purchasable.goods_type === goods_type
    }.first
  end

  def add_goods(purchasable, quantity = 1)
    order_item = contains_goods?(purchasable.goods_id, purchasable.goods_type)

    if order_item
      if quantity > 1
        order_item.quantity += quantity
      else
        order_item.quantity += 1
      end
    else
      new_order_item = OrderItem.new({
                                       quantity: quantity,
                                       price: purchasable.default_price,
                                       recycling_fee: purchasable.recycling_fee,
                                       purchasable_id: purchasable.id
                                     })

      order_items << new_order_item
    end
  end

  def update_line_items
    # delete products with 0 quantity
  end

  def update_order
    # update order items cost
    self.item_total = order_items.collect(&:cost).sum
    self.total = item_total
  end

  def update_order!
    update_order
    save!
  end

  def item_count
    order_items.sum(:quantity)
  end

  #alias customer_new customer
  #def customer
  #  customer_new || build_customer
  #end

  private

  def generate_order_number
    #after order is completed
  end

  def generate_order_token
    while (self.token = generate_token)
      break unless Order.find_by_token(self.token)
    end
  end

  def generate_token
    (0...60).map{65.+(rand(25)).chr}.join
  end

  def set_defaults
    self.customer_type ||= "individual"
    self.newsletter    ||= "yes"
    self.use_billing_address ||= false
  end
end