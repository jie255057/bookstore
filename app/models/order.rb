class Order < ApplicationRecord
  belongs_to :user
  has_many :order_item

  validates :recipient, :tel, :address, presence: true
end
