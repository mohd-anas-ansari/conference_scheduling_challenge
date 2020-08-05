class Talk
  attr_accessor  :title, :duration, :time

  def initialize talk, time
    @title = talk.title
    @duration = talk.duration
    @time = time
  end


end