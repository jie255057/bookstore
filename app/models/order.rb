class Order < ApplicationRecord
  include AASM
  belongs_to :user
  has_many :order_item

  validates :recipient, :tel, :address, presence: true
  validates :num, uniqueness: true

  before_create :generate_num

  
  aasm column: 'state' do
    state :pending, initial: true
    state :paid, :delivered, :cancelled

    event :pay do
      transitions from: :pending, to: :paid
    end

    event :deliver do
      transitions from: :paid, to: :delivered
    end

    event :cancel do
      transitions from: [:pending, :paid, :delivered], to: :cancelled
    end
  end

  private
  def generate_num
    all = ([*'A'..'Z'] + [*0..9]) - [0, 1, 'I', 'O']
    self.num = all.sample(10).join
  end
end
