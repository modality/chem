module Chem
  class Collection
    def initialize(name, lines)
      @name = name
      @lines = lines
    end

    def entities
      Helpers.entities(@lines)
    end

    def validate(chem_config, stack = [])
      check_parity!(chem_config)
      check_references!(chem_config, stack)
    end

    def check_parity!(chem_config)
      return if entities.length < 2
      arrays = entities.map {|e| chem_config.get(e)}
      if arrays.map(&:length).uniq.length > 1
        raise "Parity error in collection \"#{@name}\":\n#{Helpers.table_display(['collection','length'], entities, arrays.map(&:length))}"
      end
    end

    def check_references!(chem_config, stack)
      stack = stack.concat([@name])
      intersect = entities & stack
      raise "Circular reference(s) to \"#{intersect.join('", "')}\" found in \"#{@name}\"" if intersect.length > 0 

      entities.each do |e|
        chem_config.get(e).validate(chem_config, stack)
      end
    end

    def method_missing(method, *args, &block)
      @lines.send(method, *args, &block)
    end
  end
end
