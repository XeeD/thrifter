# encoding: UTF-8
require 'spec_helper'

describe OrderItem do
  # Associations
  it { should belong_to(:order) }
  it { should belong_to(:product) }

  # Validations
  # Quantity
  it { should validate_numericality_of(:quantity) }

  # Price
  it { should validate_numericality_of(:price) }

  # Waste
  it { should validate_numericality_of(:waste) }
end