class Post < ApplicationRecord
  include ActiveModel::Serializers::JSON

  attr_reader :slug

  has_many :comments

  def slug
    self.title.split(/\s+/).map{|word| word.downcase}.join('-')
  end

  def attributes
    {
      id: nil,
      title: nil,
      content: nil,
      created_at: nil,
      updated_at: nil,
      slug: nil
    }
  end
end
