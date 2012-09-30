class ActiveRecord::Base
  include Extensions::Global

  def self.acts_as_purchasable
    include Purchasable::Interface
  end
end
