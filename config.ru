$:<<::File.dirname(__FILE__)

# Gems
require "rubygems"
require "bundler/setup"
require "sinatra"
require "yaml"
require "app"


set :run, false
set :raise_errors, true
run App.new
