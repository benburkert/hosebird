begin
  gem 'brianmario-yajl-ruby'
rescue Gem::LoadError
  gem 'yajl-ruby'
end

require 'yajl'