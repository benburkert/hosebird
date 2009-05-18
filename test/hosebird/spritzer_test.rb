require File.join(File.dirname(__FILE__), '..', 'test_helper')

module Hosebird
  class SpritzerTest < Test::Unit::TestCase
    test ".url is '/spritzer.json'" do
      assert_equal '/spritzer.json', Spritzer.url
    end

    test ".verb is :get" do
      assert_equal :get, Spritzer.verb
    end
  end
end