require 'active_model'
require './lib/it_tax_code_validator'
require './lib/it_tax_code'

describe ItTaxCodeValidator do
  class Model
    include ActiveModel::Validations
    attr_accessor :code
    validates :code, :it_tax_code => true
  end


  before do
    @model = Model.new
    @model.code = 'thecode'
  end
  it "should pass the given attribute to the validating algorithm" do
    ItTaxCode.should_receive(:errors_for).with("thecode") { [] }
    @model.valid?
  end

  context "code has no errors" do
    subject { Model.new }
    before do
      ItTaxCode.stub(:errors_for) { [] }
    end
    it { should be_valid }
  end

  context "code has errors" do
    subject { Model.new }
    before do
      ItTaxCode.stub(:errors_for) { ["error 1"] }
    end
    it { should_not be_valid }
  end

end
