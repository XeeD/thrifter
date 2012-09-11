# encoding: UTF-8
require 'spec_helper'

describe Order do
  # Associations
  it { should have_many(:order_items) }

  # Validations
  # number
  it { should ensure_length_of(:number).is_at_most(20) }

  # token
  it { should ensure_length_of(:token).is_at_most(30) }

  # total
  it { should validate_numericality_of(:total) }

  # item_total
  it { should validate_numericality_of(:item_total) }
end