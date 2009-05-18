begin
  require 'json/ext'
rescue LoadError
  require 'json/pure'
  warn "The slow version of 'json' has been loaded ('json_pure')."
end