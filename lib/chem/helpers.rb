module Chem
  class Helpers
    ENTITY_REGEX = /<([\w.-]+)>/

    def self.execute_list(lines)
      STDOUT.puts %x{ #{lines.join("\n")} }
    end
    
    def self.entities(lines)
      ents = []
      lines = [lines].flatten
      lines.each do |line|
        ents = ents | line.scan(ENTITY_REGEX).flatten
      end
      ents
    end

    def self.replace(line, content)
      line.gsub(ENTITY_REGEX) do |match|
        content[$1]
      end
    end

    def self.table_display(column_names, *columns)
      out = ""
      lengths = column_names.map &:length
      lengths.each_with_index do |l, i|
        lengths[i] = [l, columns[i].map(&:to_s).sort_by(&:length).last.length].max
      end

      out << row_display(lengths, column_names)
      columns[0].each_index do |i|
        row = []
        columns.each do |c|
          row << c[i]
        end
        out << row_display(lengths, row)
      end
      out
    end

    def self.row_display(sizes, columns)
      out = ""
      first = true
      columns.each_with_index do |c, i|
        out << " | " unless first
        first = false
        out << c.to_s.ljust(sizes[i])
      end
      out << "\n"
      out
    end
  end
end
