require 'test/helper'
require "test/app_helper"
require 'test/fixtures/sinatra/app'

class SinatraTest < Test::Unit::TestCase

  def app
    @app ||= SinatraApp
  end
  def default_value(name)
    Rack::Sprockets::Base.defaults["#{Rack::Sprockets::Options::RACK_ENV_NS}.#{name}"]
  end

  context "A Sinatra app using Rack::Sprockets" do

    context "requesting valid JavaScript" do
      setup do
        app.use Rack::Sprockets,
          :root => file_path('test','fixtures','sinatra')

        @compiled = File.read(file_path('test','fixtures','sinatra','app','javascripts', 'app_compiled.js'))
        @response = visit "/javascripts/app.js"
      end

      should_respond_with_compiled_js
    end

    context "requesting valid nested JavaScript" do
      setup do
        app.use Rack::Sprockets,
          :root => file_path('test','fixtures','sinatra')

        @compiled = File.read(file_path('test','fixtures','sinatra','app','javascripts', 'nested', 'thing_compiled.js'))
        @response = visit "/javascripts/nested/thing.js"
      end

      should_respond_with_compiled_js
    end

  end

end
