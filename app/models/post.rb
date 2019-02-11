# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  validates :content, presence: true, length: { in: 1..255 }
  has_many :likes, dependent: :destroy

  def likes?
    likes.count
  end
  def  self.get_posts(user)
    user_ids = user.friends.pluck(:id)
    user_ids.push(user.id)
    return Post.where(user_id: user_ids).order(id: :desc)  
  end
end
