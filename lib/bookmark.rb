require 'pg'
require 'uri'

class Bookmark
  attr_reader :id, :url, :title

  def initialize(id, url, title)
    @id = id
    @url = url
    @title = title
  end

  def self.all
    result = connect_to_database.exec('SELECT * FROM bookmarks')
    result.map do |bookmark|
      Bookmark.new(bookmark['id'], bookmark['url'], bookmark['title'])
    end
  end

  def self.add(title, url)
    result = connect_to_database.exec("INSERT INTO bookmarks (title, url) VALUES ('#{title}', '#{url}') RETURNING id, url, title;")
    Bookmark.new(result.first['id'], result.first['url'], result.first['title'])
  end

  def self.valid_url(url)
    url =~ /\A#{URI::regexp(['http', 'https'])}\z/
  end

  def self.delete(id)
    connect_to_database.exec("DELETE FROM bookmarks WHERE id='#{id}';")
  end

  def self.update(id, title, url)
    bookmark = connect_to_database.exec("UPDATE bookmarks SET title='#{title}', url='#{url}' WHERE id='#{id}' RETURNING id, url, title;")
    Bookmark.new(bookmark.first['id'], bookmark.first['url'], bookmark.first['title'])
  end

  def self.connect_to_database
    if ENV['RACK_ENV'] == 'test'
      PG.connect(dbname: 'bookmark_manager_test')
    else
      PG.connect(dbname: 'bookmark_manager')
    end
  end

  def ==(bookmark)
    @id == bookmark.id
  end
end
