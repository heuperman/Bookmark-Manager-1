require 'comment'

describe Comment do
  describe '.create' do
    it 'creates a comment' do
      bookmark = Bookmark.add('Makers Academy', 'http://makersacademy.com')
      comment = Comment.create(bookmark.id, 'this is a comment')
      expect(comment.id).not_to be_nil
    end
  end
end
