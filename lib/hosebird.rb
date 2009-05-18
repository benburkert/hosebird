require 'forwardable'
require 'extlib'
require 'eventmachine'

dir = File.dirname(__FILE__) / :hosebird

autoload :JSON,     dir / :autoload / :json
autoload :Twitter,  dir / :autoload / :twitter
autoload :Yajl,     dir / :autoload / :yajl

require dir / :stream
require dir / :get_stream
require dir / :post_stream

module Hosebird
  def self.Stream(url, verb = :GET)
    Class.new(lookup_class(verb)) do
      self.url = url
    end
  end

  def self.lookup_class(verb)
    case verb
    when :GET   then GetStream
    when :POST  then PostStream
    end
  end

  class Firehose    < Stream('/firehose.json');   end
  class Gardenhose  < Stream('/gardenhose.json'); end
  class Spritzer    < Stream('/spritzer.json');   end

  class Birddog < Stream('/birddog.json', :POST); end
  class Shadow  < Stream('/shadow.json',  :POST); end
  class Follow  < Stream('/follow.json',  :POST); end
end