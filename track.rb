require_relative "constants"
require_relative "talk_list"
require_relative "talk"

class Track
  attr_accessor :track
  def initialize
    @track = Array.new
  end

  @@talk_list = Talklist::List
  
  def add_talks_to_track
    @@current_time = Constants::Time[:start_time]
    add_talks_in_the_morning

    @@current_time = Constants::Time[:lunch_end_time]
    add_talks_in_the_evening
  end

  def add_talks_in_the_morning
    lunch_time = Constants::Time[:lunch_start_time]
    morning_period = Constants::Time[:morning_period]
    add_talk_in_the_given_period lunch_time, morning_period
  end

  def add_talks_in_the_evening
    network_session_start_time = Constants::Time[:network_session_start_time]
    evening_period = Constants::Time[:evening_period]
  
    add_talk_in_the_given_period network_session_start_time, evening_period
  end

  def add_talk_in_the_given_period end_time, period_left_duration
    max_session_duration = Constants::Time[:maximum_session_duration]
    total_lightning_period = Constants::Time[:total_lightning_period]
    while period_left_duration > 0 && @@talk_list.length != 0
      add_one_talk_to_track 
      increase_current_time_by_talk_duration
      period_left_duration -= @track[-1].duration

      if(period_left_duration <= max_session_duration)
        if([30, 45, 60].include? period_left_duration) 
          add_talk_of_duration_to_track period_left_duration
          increase_current_time_by_talk_duration

          period_left_duration -= @track[-1].duration
        end
        if(period_left_duration >= total_lightning_period)
          add_talk_of_duration_to_track period_left_duration
          increase_current_time_by_talk_duration
          period_left_duration -= @track[-1].duration
        end
      end


    end
  end

  def add_talk_of_duration_to_track duration
    talk_from_talk_list = find_talk_of_duration duration

    if(talk_from_talk_list) 
      talk_to_be_added = Talk.new(talk_from_talk_list, @@current_time)
      @track << talk_to_be_added
      increase_current_time_by_talk_duration

      remove_talk_from_talk_list talk_from_talk_list
    end

  end

  def find_talk_of_duration duration
    return @@talk_list.detect{| talk | talk.duration == duration}
  end

  def add_one_talk_to_track
    @track << talk_to_be_added_to_track
  end


  def talk_to_be_added_to_track
    talk = Talk.new(@@talk_list[0], @@current_time)
    remove_talk_from_talk_list @@talk_list[0]
    
    return talk
  end


  def remove_talk_from_talk_list talk
    @@talk_list.delete(talk)
  end

  def increase_current_time_by_talk_duration
    @@current_time = add_duration_the_time_way @@current_time, @track[-1].duration
  end

  def add_duration_the_time_way current_time, duration
    # duration should be less than or equal to 60
    duration_in_array = duration.to_s.chars.map(&:to_i)
    current_time_in_array = current_time.to_s.chars.map(&:to_i)
    carry = 0

    current_time_in_array[-1] += duration_in_array[-1]
    
    if(current_time_in_array[-1] > 9) 
      carry = ((current_time_in_array[-1].to_s)[-2]).to_i
      current_time_in_array[-1] = ((current_time_in_array[-1].to_s)[-1]).to_i
    end

    if(duration_in_array[-2])
    current_time_in_array[-2] += duration_in_array[-2] + carry
    end
    if(current_time_in_array[-2] >= 6) 
      carry = 1
      current_time_in_array[-2] =  current_time_in_array[-2] - 6
    end

    current_time_in_array[-3] += carry

    final_time_in_format = current_time_in_array.join.to_i
    return final_time_in_format
  end

  def unscheduled_talks
    return @@talk_list
  end
end





