# encoding: UTF-8
require 'spec_helper'

describe NewsItem do
  # Associations
  it { should belong_to(:shop) }

  # Validations
  # Title
  it { should validate_presence_of(:title) }
  it { should ensure_length_of(:title).is_at_most(100) }

  # Content
  it { should validate_presence_of(:content) }

  # Link
  it { should ensure_length_of(:link).is_at_most(250) }
end