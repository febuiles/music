framework "AppKit"

class Song < NSSound

  attr_accessor :position, :song

  def initialize(path, position)
    @position = position
    @song = NSSound.alloc.initWithContentsOfFile(path, byReference: false)
  end

  def method_missing(method, *args, &block)
    @song.send method, *args, &block
  end
end
