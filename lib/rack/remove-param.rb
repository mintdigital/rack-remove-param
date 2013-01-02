module Rack
  class RemoveParam
    def initialize(app, params_to_filter)
      process_params(params_to_filter)
      @app = app
    end

    def call(env)
      dup._call(env)
    end

    def _call(env)
      @request = Rack::Request.new(env)

      if @request.post?
        delete_params(@request.params)
        env["rack.request.form_hash"] = @request.params
        env["rack.request.form_vars"] = Rack::Utils.build_query(@request.params)
      end

      @status, @headers, @body = @app.call(env)
      [@status, @headers, @body]
    end

    private

    def process_params(params)
      @params_to_filter = params.is_a?(String) ? Array.new(1, params) : Array.new(params)
    end

    def delete_params(hash)
      @params_to_filter.each do |param|
        delete_param(hash, param)
      end
    end

    def delete_param(hash, param)
      hash.delete(param)
      hash.each{|k, value| delete_param(value, param) if value.is_a?(Hash) }
    end
  end
end
