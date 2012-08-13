require 'spec_helper'

describe Article do
  # Associations
  it { should have_and_belong_to_many(:categories) }
  it { should have_many(:shops) }

  # Validations
  # name
  it { validates_presence_of(:name) }
  it { ensures_length_of(:name).is_at_most(100) }

  # url
  it { validates_presence_of(:url) }
  it { ensures_length_of(url).is_at_most(100) }

  # title
  it { validates_presence_of(:title) }
  it { ensures_length_of(:title).is_at_most(250) }

  # summary
  it { validates_presence_of(:summary) }

  # content
  it { validates_presence_of(:content) }

  # categories
  it { validates_presence_of(:categories) }
end