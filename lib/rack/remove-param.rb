module Rack
  class RemoveParam
    def initialize(app, param_to_filter)
        @param_to_filter = param_to_filter
      @app = app
    end

    def call(env) 
      dup._call(env)
    end

    def _call(env)
      @request = Rack::Request.new(env)

      if @request.post?
        delete_param(@request.params, @param_to_filter)
        env["rack.request.form_hash"] = @request.params
        env["rack.request.form_vars"] = Rack::Utils.build_query(@request.params)
      end

      @status, @headers, @body = @app.call(env)
      [@status, @headers, @body]
    end

    private
    def delete_param(hash, param)
      hash.delete(param)
      hash.each{|k, value| delete_param(value, param) if value.is_a?(Hash) }
    end
  end
end
