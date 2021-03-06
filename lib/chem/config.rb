require 'yaml'

module Chem
  class Config
    attr_accessor :config

    def load
      if File.exist? '.chemrc'
        @config = YAML.load(File.read('.chemrc')) || {}
      else
        raise "No .chemrc file exists. Run `chem init`"
      end
    end

    def save
      File.write('.chemrc', @config.to_yaml)
    end
    
    def init 
      if File.exist? '.chemrc'
        raise ".chemrc file already exists"
      else
        File.write('.chemrc', '')
        puts "Initialized empty .chemrc file at #{File.join(Dir.pwd, '.chemrc')}"
      end
    end

    def list
      @config.keys
    end

    def exist?(name)
      @config.has_key? name
    end

    def get(name)
      exist?(name) ? Collection.new(name, @config[name]) : nil
    end

    def set(name, arr)
      @config[name] = arr
    end

    def delete(name)
      @config.delete name
    end
  end
end
