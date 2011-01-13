framework "AppKit"

class Song

  attr_accessor :position, :song

  def initialize(path, position, delegate)
    @position = position
    @song = NSSound.alloc.initWithContentsOfFile(path, byReference: false)
    @song.delegate = delegate
  end

  def method_missing(method, *args, &block)
    @song.send method, *args, &block
  end
end
