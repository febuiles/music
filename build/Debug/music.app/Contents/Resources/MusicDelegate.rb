framework "QTKit"
#
#  MusicDelegate.rb
#  music
#
#  Created by Federico Builes on 1/11/11.
#  Copyright (c) 2011 mheroin. All rights reserved.
#

class MusicDelegate
  def applicationDidFinishLaunching(notification)
    NSLog "Empiezo "
    NSLog Dir["/Users/federico/Music/iTunes/iTunes Music/**/*.mp3"].length.to_s
    NSLog "Termino"
  end

  def play_song(sender)

NSLog "hicieron play!"
  end

  def pause_song(sender)
  end

  def previous_song(sender)
  end

  def next_song(sender)
  end
end
