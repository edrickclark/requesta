require_relative '../lib/requesta/custom_error'

RSpec.describe CustomError do

  it "is of type 'CustomError' A" do
    expect{
      raise CustomError, "Test error"
    }.to raise_error CustomError
  end

  it "is of type 'CustomError' B" do
    begin
      raise CustomError, "Test error"
    rescue Exception => error
      expect(error).to be_a(CustomError) 
    end
  end

  describe "#formatted" do
    it "returns a string" do
      begin
        raise CustomError, "Test error"
      rescue Exception => error
        expect(error.report).to be_a(String) 
      end
    end
  end

end