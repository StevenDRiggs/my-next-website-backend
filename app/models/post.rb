class Post < ApplicationRecord
  include ActiveModel::Serializers::JSON

  attr_reader :slug

  has_many :comments

  # class methods
  def self.find_by_slug(slug)
    self.all.select{|post| post.slug == slug}.first
  end

  # instance methods
  def slug
    self.title.gsub(/\s+/, '-').gsub('_', '-').gsub(/[^A-Za-z0-9-]/, '').downcase
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
