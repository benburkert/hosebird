require File.join(File.dirname(__FILE__), '..', 'test_helper')

module Hosebird
  class SpritzerTest < Test::Unit::TestCase
    test "should use the '/spritzer.json' url" do
      assert_equal '/spritzer.json', Spritzer.url
    end

    test "should make a GET request method" do
      assert_equal :get, Spritzer.method
    end
  end
end