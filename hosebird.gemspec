# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{hosebird}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ben Burkert"]
  s.date = %q{2009-05-18}
  s.email = %q{ben@benburkert.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.textile"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.textile",
     "Rakefile",
     "VERSION",
     "examples/growlr.rb",
     "examples/spritzr.rb",
     "lib/hosebird.rb",
     "lib/hosebird/autoload/json.rb",
     "lib/hosebird/autoload/twitter.rb",
     "lib/hosebird/autoload/yajl.rb",
     "lib/hosebird/get_stream.rb",
     "lib/hosebird/post_stream.rb",
     "lib/hosebird/stream.rb",
     "test/hosebird/get_stream_test.rb",
     "test/hosebird/post_stream_test.rb",
     "test/hosebird/stream_test.rb",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/benburkert/hosebird}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.requirements = ["eventmachine", "extlib", "json", "twitter"]
  s.rubygems_version = %q{1.3.3}
  s.summary = %q{A libary for Twitter's new Streaming API codename Hosebird.}
  s.test_files = [
    "test/hosebird/get_stream_test.rb",
     "test/hosebird/post_stream_test.rb",
     "test/hosebird/stream_test.rb",
     "test/test_helper.rb",
     "examples/growlr.rb",
     "examples/spritzr.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
