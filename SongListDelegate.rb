class SongListDelegate
  attr_accessor :parent

  def numberOfRowsInTableView(tableView)
    parent.display_files.count
  end

  def tableView(tableView, objectValueForTableColumn:column, row:row)
    parent.display_files[row].valueForKey(column.identifier.to_sym)
  end

  def split_name(path)
    path.split("/").last
  end
end
