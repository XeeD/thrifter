class Customer < ActiveRecord::Base
  has_one :order
  has_one :company

  validates :first_name,
            presence: true,
            length: {maximum: 40}

  validates :last_name,
            presence: true,
            length: {maximum: 60}

  validates :email,
            presence: true,
            length: {maximum: 60}
            #format: {with: /[a-z]/}

  validates :phone,
            presence: true,
            length: {maximum: 20}

  delegate :name,
           :ico,
           :dic,

           to: :company, prefix: true

  def full_name
    first_name + ' ' + last_name
  end

  #alias company_new company
  #def company
  #  company_new || build_company
  #end
end