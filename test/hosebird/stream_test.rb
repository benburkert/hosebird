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

    context "#extract_json" do
      test "should ignore any lines that do not start or end with curly braces" do
        assert_equal(1, @stream.extract_json(<<-JSON.split(Stream::NEWLINE)).size)
"missing": "braces"
{"valid":"json"}
"missing": "lcb"}
{"missing": "rcb"
JSON
      end
    end

    context "#receive_data" do
      test "should empty the buffer if the data ends with a CRLF" do
        @stream.buffer = ''
        @stream.receive_data <<-JSON.gsub(Stream::NEWLINE, "\r\n")
{"a": 1}
{"b": 2}
{"c": 3}
JSON

        assert(@stream.buffer.empty?)
      end

      test "should not be empty if the buffer does not end with a CRLF" do
        @stream.buffer = ''
        @stream.receive_data <<-JSON
{"a": 1}\r
{"b":
JSON

        assert(!@stream.buffer.empty?)
      end
    end
  end
end