class Tag

  attr_reader :id

  def initialize(id, content)
    @id = id
    @content = content
  end

  def self.create(id, content)
    result = Bookmark.connect_to_database.exec("INSERT INTO tags (content) VALUES ('#{content}') RETURNING id, content;")
    Tag.new(result.first['id'], result.first['content'])
    BookmarkTag.create(id, result.first['id'])
  end

  def self.all
    result = Bookmark.connect_to_database.exec('SELECT * FROM tags')
    result.map do |tag|
      Tag.new(tag['id'], content['content'])
    end
  end
end
