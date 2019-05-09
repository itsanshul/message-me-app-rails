class Message < ApplicationRecord
  belongs_to :user
  validates :body, presence: true
  scope :custom_list, -> { order(:created_at ).last(20) }
end
