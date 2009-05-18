module Hosebird
  class GetStream < Stream
    def initialize(twitter, timeout = 20, *args, &blk)
      super
      blk = args.pop if blk.nil? && args.last.respond_to?(:call)
      blk, timeout = timeout, 20 if timeout.respond_to?(:call)

      @twitter, @timeout, @callback = twitter, timeout, blk
      @buffer = ''
    end

    def request
      <<-REQUEST.gsub(/[\n]/, "\r\n")
GET #{url} HTTP/1.1
Host: #{HOST}
#{authorization}

REQUEST
    end
  end
end