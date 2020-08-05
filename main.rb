require_relative "talks_data"


table_data = Talks_data::List

p Track.new(table_data)
