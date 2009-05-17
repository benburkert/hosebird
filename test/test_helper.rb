require 'rubygems'
require 'test/unit'
require 'context'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'hosebird'

class Test::Unit::TestCase
  def config
    @config ||= YAML::load(open("#{ENV['HOME']}/.twitter"))
  end
end
