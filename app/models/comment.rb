class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :commented_on, class_name: 'Comment'
  has_many :subcomments, class_name: 'Comment', foreign_key: 'commented_on_id'
  validates :content, profanity_filter: true
end
