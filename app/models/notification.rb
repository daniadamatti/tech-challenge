class Notification < ApplicationRecord
  belongs_to :cart
  validates :message, presence: true
end
