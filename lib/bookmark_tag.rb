require_relative './bookmark'

class BookmarkTag
  attr_reader :bookmark_id, :tag_id

  def initialize(id, bookmark_id, tag_id)
    @bookmark_id = bookmark_id
    @tag_id = tag_id
    @id = id
  end

  def create(bookmark_id, tag_id)
    result = Bookmark.connect_to_database.exec("INSERT INTO bookmark_tags (bookmark_id, tag_id) VALUES ('#{bookmark_id}', '#{tag_id}') RETURNING id, bookmark_id, tag_id;")
    BookmarkTag.new(result.first['id'], result.first['bookmark_id'], result.first['tag_id'])
  end

  def self.all
    result = Bookmark.connect_to_database.exec('SELECT * FROM bookmark_tags')
    result.map do |bookmark_tag|
      BookmarkTag.new(bookmark_tag['id'], bookmark_tag['bookmark_id'], bookmark_tag['tag_id'])
    end
  end
end
