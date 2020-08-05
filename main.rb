require_relative "talks_data"
require_relative "table"


talks_data = Talks_data::List

track = Track.new(talks_data)
table = Table.new(track.talks)
table.table

