require "terminal-table"
require_relative "track"
require_relative "talk_list"



class Tracks
  attr_accessor :track_1, :track_2

  def initialize
    @track_1 = Track.new
    @track_2 = Track.new     
  end

  def generate_tracks
    @track_1.add_talks_to_track
    @track_2.add_talks_to_track
  end


  def generate_tables 
    generate_table @track_1, "Track 1"
    generate_table @track_2, "Track 2"
  end

  def generate_table track, track_name
    data_for_table = []
    for item in track.track do 
      data_for_table << [format_time(item.time), item.title, item.duration]
    end

    table = Terminal::Table.new :headings => ['Time', 'Talk', 'Duration'], :rows => data_for_table, :style => { :border_x => "-", :border_i => "-",:border_top => false, :border_bottom => false, :border_y => ""}

    puts "\n"    
    puts track_name
    puts table
  end

  def generate_unscheduled_table track, track_name
    data_for_table = []
    for item in track do 
      data_for_table << [item.title, item.duration]
    end

    table = Terminal::Table.new :headings => ['Talk', 'Duration'], :rows => data_for_table, :style => { :border_x => "-", :border_i => "-",:border_top => false, :border_bottom => false, :border_y => ""}

    puts "\n"    
    puts track_name
    puts table
  end


  def format_time value
    value_with_padding = "%04d" % value
    value_in_two_parts = [value_with_padding[0..1], value_with_padding[2..3]]   
    hours = value_in_two_parts[0]
    minutes = value_in_two_parts[1]

    am_pm = value > 1200 ? "PM" : "AM"
    str = "#{hours}:#{minutes} #{am_pm}"
  end

  def display_unscheduled_talks
    generate_unscheduled_table @track_2.unscheduled_talks, "UNSCHEDULED TALKS"
  end
end



tracks = Tracks.new
tracks.generate_tracks

tracks.generate_tables
tracks.display_unscheduled_talks