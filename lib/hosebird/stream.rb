module Hosebird
  class Stream

    class_inheritable_accessor :url, :method

    attr_accessor :client

    def self.basic_auth(username, password)
      new(Twitter::Base.new(Twitter::HTTPAuth.new(username, password)))
    end

    def initialize(client)
      @client = client
    end

    class Connection < EM::Protocols::HttpClient2
    end
  end

  def self.Stream(url, method = :get)
    klass = Class.new(Stream) do
      self.url = url
      self.method = method
    end

    klass
  end
end