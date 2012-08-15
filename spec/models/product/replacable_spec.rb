require 'spec_helper'

describe Product::Replacable do
  # Associations
  it { should belong_to(:product) }
  it { should belong_to(:replacement) }
end