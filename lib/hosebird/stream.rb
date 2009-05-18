module Hosebird
  class Stream < EM::Connection
    extend Forwardable

    HOST = 'stream.twitter.com'
    PORT = 80

    class_inheritable_accessor :url, :verb

    attr_accessor :client

    def self.basic_auth(username, password)
      connect(Twitter::Base.new(Twitter::HTTPAuth.new(username, password)))
    end

    def self.connect(*args)
      with_event_loop do
        EM.connect(HOST, PORT, self, *args)
      end
    end

    def self.stream(client, &blk)
      connect(client).stream(&blk)
    end

    def self.with_event_loop
      if EM.reactor_running?
        yield if block_given?
      else
        EM.run { yield if block_given? }
      end
    end

    def initialize(client, timeout = 20)
      super
      @client, @timeout = client, timeout
    end

    def authentication
      
    end

    def connection_completed
    end

    def post_init
      set_comm_inactivity_timeout(@timeout)
      send_data request
    end

    def request
      <<-HTTP.gsub(/[\n]/m, "\r\n")
#{verb.to_s.upcase} #{url} HTTP/1.1
Host: #{HOST}
#{authentication}

HTTP
    end
  end

  def self.Stream(url, verb = :get)
    Class.new(Stream) do
      self.url = url
      self.verb = verb
    end
  end
end