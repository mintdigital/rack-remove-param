require 'rspec'
require 'rack-remove-param'
require 'rack/mock'

describe Rack::RemoveParam do
  before { @app = lambda {|env| [200, {'Content-Type' => 'text/plain'}, ['Hello']] }}
  describe 'New' do
    it 'should take path arg' do
      lambda { Rack::RemoveParam.new(@app, "bad_param")}.should_not raise_error(ArgumentError)
    end

    it 'should accept a path array' do
      lambda { Rack::RemoveParam.new(@app, ["bad_param", "bad_param2"])}.should_not raise_error(ArgumentError)
    end

    it 'should always need param' do
      lambda { Rack::RemoveParam.new(@app)}.should
        raise_error(ArgumentError)
    end
  end

  describe 'Call' do
    it 'should return middleware' do
      Rack::RemoveParam.new(@app, "bad_param").should respond_to(:call)
    end

    it 'should not remove param' do
      @app = lambda {|env| raise ArgumentError if env["rack.request.form_hash"].include?("bad_param");[200, {'Content-Type' => 'text/plain'}, ['Hello']]}
      expect {Rack::RemoveParam.new(@app, "other_bad_param").call(Rack::MockRequest.env_for("/post", :method => "POST", :params => {"bad_param" => "bad!"}))}.should raise_error(ArgumentError)
    end

    it 'should remove param' do
      @app = lambda {|env| raise ArgumentError if env["rack.request.form_hash"].include?("bad_param");[200, {'Content-Type' => 'text/plain'}, ['Hello']]}
     expect { Rack::RemoveParam.new(@app, "bad_param").call(Rack::MockRequest.env_for("/post", :method => "POST", :params => {"bad_param" => "bad!"}))}.should_not raise_error(ArgumentError)
    end

    it 'should accept nested params' do
      @app = lambda {|env| [200, {'Content-Type' => 'text/plain'}, ['Hello']]}
     expect { Rack::RemoveParam.new(@app, "bad_param").call(Rack::MockRequest.env_for("/post", :method => "POST", :params => {"bad_param" => "bad!", "nested" => {"x" => "y", "z" => {"a" => "b"}}}))}.should_not raise_error(ArgumentError)
    end

    it 'should remove multiple params' do
      @app = lambda {|env| raise ArgumentError if env["rack.request.form_hash"].include?("bp") || env["rack.request.form_hash"].include?("bp2");[200, {'Content-Type' => 'text/plain'}, ['Hello']]}
     expect { Rack::RemoveParam.new(@app, ["bp", "bp2"]).call(Rack::MockRequest.env_for("/post", :method => "POST", :params => {"bp" => "bad!", "bp2" => "worse!"}))}.should_not raise_error(ArgumentError)
    end
  end
end
