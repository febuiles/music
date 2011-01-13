class SearchDelegate
  attr_accessor :parent
  attr_accessor :search_bar

  def updateFilter(sender)
    search_string = search_bar.stringValue
    search_regexp = Regexp.new(search_string, Regexp::IGNORECASE)
    if search_string.empty?
      parent.display_files = parent.files
    end

    parent.display_files = parent.files.find_all do |file|
      file[:artist] =~ search_regexp || file[:song] =~ search_regexp
    end
    parent.update_display_filenames
    parent.songs_view.reloadData
  end
end
