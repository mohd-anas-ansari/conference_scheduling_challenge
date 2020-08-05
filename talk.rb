class Talk
  attr_accessor  :title, :duration, :time

  def initialize title, duration, time=0
    @title = title
    @duration = duration
    @time = time
  end

end