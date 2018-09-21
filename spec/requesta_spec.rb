# FILE: spec/requesta_spec.rb

require_relative '../lib/requesta'

RSpec.describe Requesta do

  let(:requesta) { Requesta.new }

  context "attributes" do

    context "reading" do
      
      it "allows reading for @body" do
        expect(requesta).to respond_to(:body)
      end
      
      it "allows reading for @post" do
        expect(requesta).to respond_to(:post)
      end
      
      it "allows reading for @verbose" do
        expect(requesta).to respond_to(:verbose)
      end
      
      it "allows reading for @body" do
        expect(requesta).to respond_to(:body)
      end

      it "disallows reading for @username" do
        expect(requesta).to_not respond_to(:username)
      end
      
      it "disallows reading for @password" do
        expect(requesta).to_not respond_to(:password)
      end
      
      it "allows reading for @headers" do
        expect(requesta).to respond_to(:headers)
      end

    end

    context "writing" do

      it "allows writing for @ssl" do
        requesta.ssl = 'ssl'
        expect(requesta.ssl).to eq('ssl')
      end

      it "allows writing for @post" do
        requesta.post = 'post'
        expect(requesta.post).to eq('post')
      end

      it "allows writing for @verbose" do
        requesta.verbose = 'verbose'
        expect(requesta.verbose).to eq('verbose')
      end

      it "allows writing for @body" do
        requesta.body = 'body'
        expect(requesta.body).to eq('body')
      end

      it "allows writing for @username" do
        expect(requesta).to respond_to(:username=)
      end
      
      it "allows writing for @password" do
        expect(requesta).to respond_to(:password=)
      end
      
      it "disallows writing for @headers" do
        expect(requesta).to_not respond_to(:headers=)
      end

    end

  end

  context 'methods' do

    context 'headers' do

      describe "#set_header" do
        it "sets a header entry in @headers hash" do

            expect{
              requesta.set_header(:foo,:bar)
            }.to change{
              requesta.headers
            }.from({}).to({foo: :bar})

            expect{
              requesta.set_header('bar','baz')
            }.to change{
              requesta.headers
            }.from({foo: :bar}).to({foo: :bar, 'bar' => 'baz'})

        end
      end

      describe "#set_headers" do
        it "sets header entries in @headers hash" do
          
          expect{
            requesta.set_headers({foo: :bar, bar: :baz})
          }.to change{
            requesta.headers
          }.from({}).to({foo: :bar, bar: :baz})
        end
      end

      describe "#clear_header" do
        it "clears a header entry in @headers hash" do
          
          requesta.set_header(:foo,:bar)
          expect{
            requesta.clear_header(:foo)
          }.to change{
            requesta.headers
          }.from({foo: :bar}).to({})
        end
      end

      describe "#clear_headers" do
        it "clears header entries in @headers hash" do
          
          requesta.set_headers({foo: :bar, bar: :baz})
          expect{
            requesta.clear_headers
          }.to change{
            requesta.headers
          }.from({foo: :bar, bar: :baz}).to({})
        end
      end

    end

    describe "#href_scheme_https?" do

      it "returns true if a href scheme is 'https'" do
        href = 'https://example.com'
        expect(requesta.send(:href_scheme_https?,href)).to be true
      end

      it "returns false if a href scheme is not 'https'" do
        href = 'http://example.com'
        expect(requesta.send(:href_scheme_https?,href)).to be false
      end
    
    end

    describe "#uri_scheme_https?" do

      it "returns true if a uri scheme is 'https'" do
        uri = URI('https://example.com')
        expect(requesta.send(:uri_scheme_https?,uri)).to be true
      end

      it "returns false if a uri scheme is not 'https'" do
        uri = URI('http://example.com')
        expect(requesta.send(:uri_scheme_https?,uri)).to be false
      end
    
    end

    describe "#request" do

      it "successfully makes 'get' requests" do
        uri = URI('https://postman-echo.com/get')
        
        response = requesta.request(uri)
        
        expect(response.code).to eq '200'
      end

      it "successfully makes 'post' requests" do
        uri = URI('https://postman-echo.com/post')
        
        requesta.post = true
        response = requesta.request(uri)
        
        expect(response.code).to eq '200'
      end

      it "successfully makes basic auth requests" do
        uri = URI('https://postman-echo.com/basic-auth')
        
        requesta.username = 'postman'
        requesta.password = 'password'
        response = requesta.request(uri)
        
        expect(response.code).to eq '200'
      end

      it "returns 401 when basic auth credentials are incorrect" do
        uri = URI('https://postman-echo.com/basic-auth')
        
        requesta.username = 'user'
        requesta.password = 'pass'
        response = requesta.request(uri)
        
        expect(response.code).to eq '401'
      end

      it "returns a properly formatted IP Address from 'ipinfo.io/ip' web service" do
        uri = URI('https://ipinfo.io/ip')
        
        response = requesta.request(uri)
        
        rgx_ip_addr = /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/
        expect(response.body.strip).to match rgx_ip_addr
      end
    
    end
  
  end

end