require "active_model"
#require "lib/validators/parent_loop_validator"

describe ParentLoopValidator do
  let(:validator) { ParentLoopValidator.new(attributes: {}) }
  let(:errors) { Array.new }
  let(:record) { double("record", id: 123, errors: errors) }

  def validate_record(options = {parent_id: 123})
    validator.validate_each(record, :parent_id, options[:parent_id])
  end

  before do
    errors.stub(add: true)
  end

  it "checks the record's id" do
    record.should_receive(:id)
    validate_record
  end

  context "with 'parent loop' (parent_id == id)" do
    it "adds validation error" do
      errors.should_receive(:add)
      validate_record
    end

    it "adds error that can be translated as parent_loop" do
      errors.should_receive(:add).with(:parent_id, :parent_loop)
      validate_record
    end
  end

  context "without 'parent loop' (parent_id != id)" do
    it "does' add any errors" do
      errors.should_not_receive(:add)
      validate_record(parent_id: 124)
    end
  end
end