#
#  SongListDelegate.rb
#  music
#
#  Created by Federico Builes on 1/11/11.
#  Copyright (c) 2011 mheroin. All rights reserved.
#

class SongListDelegate
  attr_accessor :parent

  def numberOfRowsInTableView(tableView)
    parent.files.count
  end

  def tableView(tableView, objectValueForTableColumn:column, row:row)
    parent.files[row].valueForKey(column.identifier.to_sym)
  end

  def split_name(path)
    path.split("/").last
  end
end
