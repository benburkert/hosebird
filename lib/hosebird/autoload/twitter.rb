gem 'flyingmachine-aikidoka'
require 'aikidoka'
Aikidoka.rename("Mash" => "Twitter::Mash") { require 'twitter' }