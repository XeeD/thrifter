require 'spec_helper'

describe Article do
  # Associations
  it { should have_and_belong_to_many(:categories) }
  it { should have_many(:shops) }

  # Validations
  # name
  it { should validate_presence_of(:name) }
  it { should ensure_length_of(:name).is_at_most(100) }

  # url
  it { should validate_presence_of(:url) }
  it { should ensure_length_of(:url).is_at_most(100) }

  # title
  it { should validate_presence_of(:title) }
  it { should ensure_length_of(:title).is_at_most(250) }

  # summary
  it { should validate_presence_of(:summary) }

  # content
  it { should validate_presence_of(:content) }

  # categories
  it { should validate_presence_of(:categories) }
end