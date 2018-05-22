class Timer
  def self.start
    @beginning_time = Time.now
  end

  def self.end(message = '')
    end_time = Time.now
    puts "#{message}#{(end_time - @beginning_time)*1000.round(3)} ms"
  end
end