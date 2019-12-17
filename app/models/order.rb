class Order < ApplicationRecord
  belongs_to :user
  has_many :order_item

  validates :recipient, :tel, :address, presence: true
  validates :num, uniqueness: true

  before_create :generate_num

  private
  def generate_num
    all = ([*'A'..'Z'] + [*0..9]) - [0, 1, 'I', 'O']
    self.num = all.sample(10).join
  end
end
