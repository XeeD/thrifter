require 'spec_helper'

describe Product::Replacable do
  # Associations
  it { should belong_to(:original) }
  it { should belong_to(:replacement) }
end