# encoding: UTF-8
require 'spec_helper'

describe Parametrization do
  # Associations
  it { should belong_to(:product) }
  it { should belong_to(:param_item) }
  it { should belong_to(:param_value) }
end