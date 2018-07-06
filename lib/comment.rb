require_relative './bookmark'

class Comment
  attr_reader :id, :bookmark_id, :text

  def initialize(id, bookmark_id, text)
    @id = id
    @bookmark_id = bookmark_id
    @text = text
  end

  def self.create(bookmark_id, text)
    result = Bookmark.connect_to_database.exec("INSERT INTO comments (bookmark_id, text) VALUES ('#{bookmark_id}', '#{text}') RETURNING id, bookmark_id, text;")
    Comment.new(result.first['id'], result.first['bookmark_id'], result.first['text'])
  end

  def self.all
    result = Bookmark.connect_to_database.exec('SELECT * FROM comments')
    result.map do |comment|
      Comment.new(comment['id'], comment['bookmark_id'], comment['text'])
    end
  end
end
