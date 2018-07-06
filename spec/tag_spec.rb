require 'tag'

describe Tag do
  describe '.create' do
    it 'creates a tag' do
      tag = Tag.create('social')
      expect(tag.id).not_to be_nil
    end
  end
end
