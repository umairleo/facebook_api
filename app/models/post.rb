class Post < ApplicationRecord
  belongs_to :user
  validates :content, presence: true, length: {in: 1..255} 
end
