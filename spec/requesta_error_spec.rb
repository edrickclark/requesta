# FILE: spec/requesta_error_spec.rb

require_relative '../lib/requesta'
require_relative '../lib/requesta/errors'

RSpec.describe RequestaError do

  let(:requesta) { Requesta.new }

  context 'custom error classes are able to be raised' do
    it "raises RequestaError::MethodError" do
      expect{
        raise RequestaError::MethodError, "Test error"
      }.to raise_error RequestaError::MethodError
    end

    it "raises RequestaError::RequestError" do
      expect{
        raise RequestaError::RequestError, "Test error"
      }.to raise_error RequestaError::RequestError
    end

    it "raises RequestaError::RequestHeaderError" do
      expect{
        raise RequestaError::RequestHeaderError, "Test error"
      }.to raise_error RequestaError::RequestHeaderError
    end
  end

  context 'passing incorrect values to header methods, raises an error' do

    describe "#set_header" do
      
      it "raises error when 'key' parameter is not of type 'String' or 'Symbol'" do
        expect{
          requesta.set_header(0,:bar)
        }.to raise_error do |error|
          expect( error ).to be_a RequestaError::RequestHeaderError
          expect( error.message ).to eq "set_header(): 'key' parameter must be of type Symbol or String"
        end
      end
      
      it "raises error when 'value' parameter is not of type 'String' or 'Symbol'" do
        expect{
          requesta.set_header(:foo,0)
        }.to raise_error do |error|
          expect( error ).to be_a RequestaError::RequestHeaderError
          expect( error.message ).to eq "set_header(): 'value' parameter must be of type Symbol or String"
        end
      end

    end

    describe "#set_headers" do
      
      it "raises error when 'headers' parameter is not of type 'Hash'" do
        expect{
          requesta.set_headers([:foo,:bar])
        }.to raise_error do |error|
          expect( error ).to be_a RequestaError::RequestHeaderError
          expect( error.message ).to eq "set_headers(): 'headers' parameter must be of type 'Hash'"
        end
      end
      
    end

    describe "#clear_header" do
      
      it "raises error when 'key' parameter is not of type 'String' or 'Symbol'" do
        expect{
          requesta.clear_header(0)
        }.to raise_error do |error|
          expect( error ).to be_a RequestaError::RequestHeaderError
          expect( error.message ).to eq "clear_header(): 'key' must be of type Symbol or String"
        end
      end

    end

  end

  it "raises error if 'uri' parameter is not of type 'URI'" do
    
    expect{
      requesta.request(nil)
    }.to raise_error do |error|
      expect( error ).to be_a RequestaError::RequestError
      expect( error.message ).to eq "request(): 'uri' parameter must be of type 'URI'"
    end

    expect{
      requesta.request('string')
    }.to raise_error do |error|
      expect( error ).to be_a RequestaError::RequestError
      expect( error.message ).to eq "request(): 'uri' parameter must be of type 'URI'"
    end

    expect{
      requesta.request({ foo: :bar })
    }.to raise_error do |error|
      expect( error ).to be_a RequestaError::RequestError
      expect( error.message ).to eq "request(): 'uri' parameter must be of type 'URI'"
    end

    expect{
      requesta.request([:bar])
    }.to raise_error do |error|
      expect( error ).to be_a RequestaError::RequestError
      expect( error.message ).to eq "request(): 'uri' parameter must be of type 'URI'"
    end
  end

end