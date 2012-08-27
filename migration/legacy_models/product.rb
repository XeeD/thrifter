module LegacyModels
  class Product < Base
    self.table_name = "product"
    self.primary_key = "pr_id"

    belongs_to :brand, foreign_key: :br_id
    has_one :recommended_price, class_name: "Price", foreign_key: :pr_id, conditions: {is_current: true, type: "rec"}

    scope :migration, -> { where(ready_to_submit: true) }
  end
end
