require File.join(File.dirname(__FILE__), '..', 'test_helper')

module Hosebird
  class GetStreamTest < Test::Unit::TestCase

    before do
      @stream = Hosebird::Stream('/example.json', :GET).allocate
      @stream.twitter = twitter_connection
    end

    context "#request" do
      test "should conform with RFC2616" do
        assert_match(/\AGET\s\/example\.json\sHTTP\/1\.1\r\n/, @stream.request)
        assert_match(/[\r][\n][\r][\n]\Z/, @stream.request)
      end

      test "should include the host header" do
        assert @stream.request["Host: #{Stream::HOST}"]
      end

      test "should include the basic auth header" do
        assert @stream.request[@stream.basic_auth]
      end
    end
  end
end