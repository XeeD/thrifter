# encoding: UTF-8
require 'spec_helper'

describe Categorization do
  # Associations
  it { should belong_to(:category) }
  it { should belong_to(:product) }
end
