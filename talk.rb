class Talk
  attr_accessor  :title, :duration, :time

  def initialize talk, time=0
    @title = talk.title
    @duration = talk.duration
    @time = time
  end
  
end