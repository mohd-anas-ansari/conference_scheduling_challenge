require "terminal-table"

class Table
  attr_accessor :table

  def initialize table_data
    @table = create_table(table_data)
  end

  def create_table(table_data) 
    data_for_table = []
    for item in table_data do 
      data_for_table << [item.title, item.time, item.duration]
    end

    table = Terminal::Table.new :headings => ['Time', 'Talk', 'Duration'], :rows => data_for_table, :style => { :border_x => "-", :border_i => "-",:border_top => false, :border_bottom => false, :border_y => ""}

    puts "\n"    
    puts table
    puts "\n"    
  end
end