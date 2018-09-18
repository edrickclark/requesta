require_relative '../lib/requesta'

RSpec.describe Requesta do

  describe "#href_scheme_https?" do

    requesta = Requesta.new

    it "returns true if a href scheme is 'https'" do
      href = 'https://example.com'
      expect(requesta.href_scheme_https?(href)).to be true
    end

    it "returns false if a href scheme is not 'https'" do
      href = 'http://example.com'
      expect(requesta.href_scheme_https?(href)).to be false
    end
  
  end

  describe "#uri_scheme_https?" do

    requesta = Requesta.new

    it "returns true if a uri scheme is 'https'" do
      uri = URI('https://example.com')
      expect(requesta.uri_scheme_https?(uri)).to be true
    end

    it "returns false if a uri scheme is not 'https'" do
      uri = URI('http://example.com')
      expect(requesta.uri_scheme_https?(uri)).to be false
    end
  
  end

  describe "attributes" do

    context "reading" do

      requesta = Requesta.new
      
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

      requesta = Requesta.new

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

  context 'headers' do

    describe "#set_header" do
      it "sets a header entry in @headers hash" do
        requesta = Requesta.new
        expect{
          requesta.set_header(:foo,:bar)
        }.to change{
          requesta.headers
        }.from({}).to({foo: :bar})
      end
    end

    describe "#set_headers" do
      it "sets header entries in @headers hash" do
        requesta = Requesta.new
        expect{
          requesta.set_headers({foo: :bar, bar: :baz})
        }.to change{
          requesta.headers
        }.from({}).to({foo: :bar, bar: :baz})
      end
    end

    describe "#clear_header" do
      it "clears a header entry in @headers hash" do
        requesta = Requesta.new
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
        requesta = Requesta.new
        requesta.set_headers({foo: :bar, bar: :baz})
        expect{
          requesta.clear_headers
        }.to change{
          requesta.headers
        }.from({foo: :bar, bar: :baz}).to({})
      end
    end

  end

end