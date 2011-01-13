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

  attr_accessor :filenames, :files, :display_files, :display_filenames
  attr_accessor :songs_view, :search_bar

  def initialize
    @filenames = Dir["/Users/federico/Music/iTunes/iTunes Music/**/*.mp3"]
    @files = Array.new          # struct of all the files
    @filenames.each do |f|
      splitted = f.split("/")
      artist = splitted[-2]
      song = splitted.last
      @files << { artist: artist, name: song, filename: f }
    end

    @current_song = nil
    @display_files = @files     # files to display (important in search)
    @display_filenames = update_display_filenames
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

    filename = @display_filenames[clicked_pos]
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
      how_many = @display_files.count - 1
    end

    new_song = Song.new(@display_filenames[cur_pos + how_many], cur_pos + how_many, self)

    @current_song.song.stop if @current_song.try(:song).try(:playing?)
    @current_song = new_song
    @current_song.song.play
  end

  def sound(sound, didFinishPlaying: state)
    next_song(self) if state
  end

  def update_display_filenames()
    @display_filenames = @display_files.map { |f| f[:filename] }
  end
end
