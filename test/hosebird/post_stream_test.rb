require File.join(File.dirname(__FILE__), '..', 'test_helper')

module Hosebird
  class PostStreamTest < Test::Unit::TestCase

    before do
      @stream = Hosebird::Stream('/example.json', :POST).allocate
      @stream.twitter = twitter_connection
      @stream.follow  = [12, 13, 15, 16, 20, 87]
    end

    context "#post_params" do
      test "should start with 'follow='" do
        assert_match(/\Afollow=/, @stream.post_params)
      end

      test "should be a set of integers seperated by spaces" do
        assert_match(/(\d+\s)+\d+/, @stream.post_params)
      end
    end

    context "#request" do
      test "should conform with RFC2616" do
        assert_match(/\APOST\s\/example\.json\sHTTP\/1\.1\r\n/, @stream.request)
      end

      test "should include the host header" do
        assert @stream.request["Host: #{Stream::HOST}"]
      end

      test "should include the basic auth header" do
        assert @stream.request[@stream.basic_auth]
      end

      test "should include the content type header as form data" do
        assert @stream.request["Content-Type: application/x-www-form-urlencoded"]
      end

      test "should include the content length header" do
        assert_match(/^Content-Length:\s\d+\r$/, @stream.request)
      end

      test "should include the post params body" do
        assert @stream.request[@stream.post_params]
      end
    end
  end
end