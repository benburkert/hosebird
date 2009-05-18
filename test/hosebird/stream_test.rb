require File.join(File.dirname(__FILE__), '..', 'test_helper')

module Hosebird
  class StreamTest < Test::Unit::TestCase

    before do
      @stream = Hosebird::Stream('/example.json', :GET).allocate
      @stream.twitter = twitter_connection
    end

    context "#basic_auth" do
      test "should start with 'Authorization: Basic'" do
        assert_match(/\AAuthorization:\sBasic/, @stream.basic_auth)
      end
    end

    context "#request" do
      test "should conform with RFC2616" do
        assert_match(/\AGET\s\/example\.json\sHTTP\/1\.1\r\n/m, @stream.request)
        assert_match(/[\r][\n][\r][\n]\Z/, @stream.request)
      end

      test "should include the basic auth header" do
        assert @stream.request[@stream.basic_auth]
      end
    end
  end
end