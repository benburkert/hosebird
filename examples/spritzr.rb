$KCODE = 'UTF8'
require 'fileutils'
require 'rubygems'
gem 'visionmedia-growl'
require 'growl'
require 'uri'
require File.join(File.dirname(__FILE__), '..', 'lib', 'hosebird')

config = YAML::load(open("#{ENV['HOME']}/.twitter")).to_mash

class Spritzr < Hosebird::Spritzer

  attr_accessor :config

  def initialize(*args)
    super

    @image_cache =  ENV['HOME'] / '.growlr'
    FileUtils.mkdir_p @image_cache
  end

  def callback(status)
    title =  "@#{status[:user][:screen_name]} "
    title << "#{DateTime.parse(status[:created_at]).strftime("%I:%M:%S %p")}"
    uri = URI.parse(status[:user][:profile_image_url])

    lookup_image(uri) do |path|
      Growl.notify status[:text], :title => title, :icon => path
    end
  end

  def lookup_image(uri)
    path = @image_cache / File.basename(uri.path)
    if File.exists? path
      yield path if block_given?
    else
      fetch_image(uri, path) { yield path if block_given? }
    end
  end

  def fetch_image(uri, path)
    EM::P::HttpClient2.connect(uri.host, uri.port).get(uri.path).callback do |r|
      File.open(@image_cache / File.basename(uri.path), 'w+') do |f|
        f << r.content
        f.flush
      end

      yield if block_given?
    end
  end
end

EM::run { Spritzr.basic_stream(config[:username], config[:password]) }