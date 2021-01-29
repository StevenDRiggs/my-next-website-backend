class Post < ApplicationRecord
  has_many :comments

  def slug
    self.title.split(/\s+/).map{|word| word.downcase}.join('-')
  end
end
