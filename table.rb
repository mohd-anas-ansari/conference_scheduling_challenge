class Table
  :attr_acessor :table

  def initialize table_data
    @table = create_table(table_data)
  end


end