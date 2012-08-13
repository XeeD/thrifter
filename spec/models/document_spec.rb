require 'spec_helper'

describe Document do
  # Associations
  it { should have_and_belong_to_many(:shops) }

  # Validations
  # name
  it { should validate_presence_of(:name) }
  it { should ensure_length_of(:name).is_at_most(70) }
  it {
    Document.create(valid_document_attributes)
    should validate_uniqueness_of(:name)
  }

  # url
  it { should validate_presence_of(:url) }
  it { should ensure_length_of(:url).is_at_most(70) }
  it {
    Document.create(valid_document_attributes)
    should validate_uniqueness_of(:url)
  }

  # title
  it { should validate_presence_of(:title) }
  it { should ensure_length_of(:title).is_at_most(250) }

  # content
  it { should validate_presence_of(:content) }

  describe "integrity constraints" do
    fixtures :documents

    let(:payment) { documents(:payment) }
    let(:contact) { documents(:contact) }

    it "sets new contact_link and deletes the old one" do
      contact.contact_link.should be true

      payment.update_attribute(:contact_link, true)

      payment.contact_link.should be true
      contact.reload.contact_link.should be false
    end
  end
end