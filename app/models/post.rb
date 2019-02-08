# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  validates :content, presence: true, length: { in: 1..255 }
  has_many :likes, dependent: :destroy

  def likes?
    likes.count
  end
end
