require 'spec_helper'

describe Product::ReplacingProduct do
  # Associations
  it { should belong_to(:product) }
  it { should belong_to(:replacement) }
end