require 'comment'

describe Comment do
  describe '.all' do
    it 'returns all comments' do
      bookmark = Bookmark.add('Makers Academy', 'http://makersacademy.com')
      comment = Comment.create(bookmark.id, 'this is a comment')
      expect(comment.id).not_to be_nil
    end
  end
end
