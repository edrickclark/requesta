# requesta_spec.rb

require_relative '../lib/requesta'

RSpec.describe Requesta do

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

  describe "#set_header" do
    
    it "seta a header entry in @headers hash" do
      requesta = Requesta.new
      requesta.set_header(:foo,:bar)
      expect(requesta.headers).to have_key(:foo)
    end

  end

end