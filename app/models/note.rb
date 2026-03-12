class Note < ApplicationRecord
  validates :title, presence: true, length: { minimum: 3 }
  validates :content, presence: true
end
