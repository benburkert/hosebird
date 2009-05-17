require 'extlib'
require 'eventmachine'

dir = File.dirname(__FILE__) / :hosebird / :autoload

autoload :Twitter, dir / :twitter

module Hosebird
  dir = File.dirname(__FILE__) / :hosebird

  require             dir / :stream
  autoload :Spritzer, dir / :spritzer
end