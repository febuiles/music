framework "AppKit"
#
#  MusicDelegate.rb
#  music
#
#  Created by Federico Builes on 1/11/11.
#  Copyright (c) 2011 mheroin. All rights reserved.
#


module Kernel
  def log(what)
    NSLog what.to_s
  end
end

class MusicDelegate

  attr_accessor :filenames, :files
  attr_accessor :songs_view

  def initialize
    @filenames = Dir["/Users/federico/Music/iTunes/iTunes Music/**/*.mp3"]
    @files = Array.new
    @filenames.each do |f|
      splitted = f.split("/")
      artist = splitted[-2]
      song = splitted.last
      @files << { artist: artist, name: song }
    end
    @current_song = nil
  end

  def applicationDidFinishLaunching(notification)
    self.songs_view.doubleAction = "table_click:"
  end

  def table_click(sender)
    play_song(self)
  end

  def play_song(sender)
    if @current_song && @current_song.playing?
      @current_song.resume
    else
      filename = @filenames[self.songs_view.clickedRow]
      @current_song = NSSound.alloc.initWithContentsOfFile(filename, byReference: false)
      @current_song.play
    end
  end

  def stop_song(sender)
    @current_song.stop if @current_song
  end

  def pause_song(sender)
    @current_song.pause if @current_song
  end

  def previous_song(sender)
  end

  def next_song(sender)
  end
end
