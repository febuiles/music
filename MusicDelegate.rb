framework "QTKit"
#
#  MusicDelegate.rb
#  music
#
#  Created by Federico Builes on 1/11/11.
#  Copyright (c) 2011 mheroin. All rights reserved.
#

class MusicDelegate

  attr_accessor :filenames

  def applicationDidFinishLaunching(notification)
    @filenames = Dir["/Users/federico/Music/iTunes/iTunes Music/**/*.mp3"]
  end

  def play_song(sender)
  end

  def pause_song(sender)
  end

  def previous_song(sender)
  end

  def next_song(sender)
  end
end
