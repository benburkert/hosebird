module Hosebird
  class Stream < EM::Connection
    extend Forwardable

    HOST        = 'stream.twitter.com'
    PORT        = 80
    KEEP_ALIVE  = /\A[0-F]{3}\Z/
    NEWLINE     = /[\n]/
    CRLF        = /[\r][\n]/
    EOF         = /[\r][\n]\Z/
    JSON_START  = /\A[{]/
    JSON_END    = /[}]\Z/

    class_inheritable_accessor :url

    attr_accessor :twitter, :timeout, :buffer

    def_delegators :twitter, :client
    def_delegators :client, :username, :password

    def self.basic_stream(username, password, *args, &blk)
      subscribe(Twitter::Base.new(Twitter::HTTPAuth.new(username, password)), *args, &blk)
    end

    def self.connect(host = HOST, port = PORT, *args)
      EM.connect(host, port, self, *args)
    end

    def self.subscribe(*args, &blk)
      with_event_loop do
        connect(HOST, PORT, *(blk.nil? ? args : args << blk))
      end
    end

    def self.with_event_loop
      if EM.reactor_running?
        yield if block_given?
      else
        EM.run { yield if block_given? }
      end
    end

    def authorization
      case client
      when Twitter::HTTPAuth then basic_auth
      end
    end

    def basic_auth
      "Authorization: Basic #{["#{username}:#{password}"].pack('m').strip.gsub(NEWLINE, '')}"
    end

    def callback(json)
      @callback.call(json) unless @callback.nil?
    end

    def extract_json(lines)
      lines.map {|line| JSON.parse(line).to_mash if line =~ JSON_START && line =~ JSON_END}.compact
    end

    def post_init
      set_comm_inactivity_timeout(@timeout)
      send_data request
    end

    def receive_data(data)
      @buffer << data

      if @buffer =~ EOF
        lines = @buffer.split(CRLF)
        @buffer = ''
      else
        lines = @buffer.split(CRLF)
        @buffer = lines.pop
      end

      extract_json(lines).each {|line| callback(line)}
    end

    def unbind
      close_connection
      reconnect HOST, PORT
      post_init
    end
  end
end