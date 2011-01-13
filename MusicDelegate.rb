require 'song'
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

class Object
  def try(method)
    send method if respond_to? method
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
    play_song(sender)
  end

  def play_song(sender)
    clicked_pos = self.songs_view.clickedRow
    if clicked_pos == -1        # first song or same song
      if @current_song.try(:song).try(:playing?) # same song
        clicked_pos = @current_song.position
      else
        clicked_pos = 0
      end
    end
    @current_song.song.stop if @current_song

    filename = @filenames[clicked_pos]
    @current_song = Song.new(filename, clicked_pos, self)
    @current_song.song.play
  end

  def stop_song(sender)
    @current_song.song.stop if @current_song
  end

  def pause_song(sender)
    @current_song.song.pause if @current_song
  end

  def previous_song(sender)
    jump(-1)
  end

  def next_song(sender)
    jump(1)
  end

  def jump(how_many)
    cur_pos = @current_song.position rescue 0

    if cur_pos == 0 && how_many < 0 # jump to the last song
      how_many = @files.count - 1
    end

    new_song = Song.new(@filenames[cur_pos + how_many], cur_pos + how_many, self)

    @current_song.song.stop if @current_song.try(:song).try(:playing?)
    @current_song = new_song
    @current_song.song.play
  end

  def sound(sound, didFinishPlaying: state)
    next_song(self) if state
  end
end
