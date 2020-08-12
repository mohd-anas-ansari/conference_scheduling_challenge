class Session
  attr_reader :title, :duration
  def initialize title, duration
    @title = title
    @duration = duration
  end
end
