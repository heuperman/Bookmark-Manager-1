require 'comment'

describe Comment do
  describe '.all' do
    it 'returns all comments' do
      comment = Commment.create(1, 'this is a comment')
      expect(Comment.all).to eq([comment])
    end
  end
end
