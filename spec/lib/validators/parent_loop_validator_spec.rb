require "active_model"

describe ParentLoopValidator do
  let(:validator) { ProductLoopValidator.new }
  let(:record) { double("record", id: 123, parent_id: 123) }

  it "checks the record's id" do
    record.should_receive(:id)
    validator.validate_each
  end
end