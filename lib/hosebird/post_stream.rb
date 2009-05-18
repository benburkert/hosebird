module Hosebird
  class PostStream < Stream
    def initialize(twitter, follow, timeout = 300, *args, &blk)
      super
      blk = args.pop if blk.nil? && args.last.respond_to?(:call)
      blk, timeout = timeout, 300 if timeout.respond_to?(:call)

      @twitter, @follow, @timeout, @callback = twitter, follow, timeout, blk
      @buffer = ''
    end

    def post_params
      "follow=#{@follow * ' '}"
    end

    def request
      body = post_params
      <<-REQUEST.gsub(/[\n]/, "\r\n")
POST #{url} HTTP/1.1
Host: #{HOST}
#{authorization}
Content-Type: application/x-www-form-urlencoded
Content-Length: #{body.length}

#{body}
REQUEST
    end
  end
end