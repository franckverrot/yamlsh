require 'yaml'

module Yamlsh
  class Env
    CdError   = Class.new(RuntimeError)
    PwdError  = Class.new(RuntimeError)
    SetError  = Class.new(RuntimeError)
    SaveError = Class.new(RuntimeError)

    def initialize(data_store, path = Path.new)
      @data_store = data_store
      @yaml = YAML.load_file(data_store)
      @path = path
      @current_yaml_at_path = @yaml.dup
    end

    def keys
      @current_yaml_at_path.keys.sort
    end

    def get(key)
      @current_yaml_at_path[key]
    end

    def set(key, value)
      @current_yaml_at_path[key] = value
    end

    def pwd
      @path.to_s
    end

    def cd key_path # . separated path
      key_path ||= ''

      if key_path == 'root'
        @path.reset
        @current_yaml_at_path = @yaml
      elsif key_path == '.'
        # nop
      elsif key_path == '..'
        @path.pop
        new_path = @path.to_s
        cd 'root'
        cd new_path
      else
        segments = key_path.split('.')
        segments.each do |segment|
          yaml = @current_yaml_at_path[segment]

          if yaml.respond_to? :keys
            @current_yaml_at_path = yaml
            @path.push segment
          else
            raise CdError, "#{segment} is a key, use SET to modify it"
          end
        end
      end
    end

    def save
      begin
        File.open(@data_store, 'w') { |f| f.puts @yaml.to_yaml }
        "ok"
      rescue => e
        "ko -- #{e.message}"
      end
    end

    def current_path
      @path.to_s
    end
  end
end
