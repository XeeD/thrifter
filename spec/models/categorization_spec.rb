require 'spec_helper'

describe Categorization do
  it { should belong_to(:category) }
  it { should belong_to(:product) }
end
