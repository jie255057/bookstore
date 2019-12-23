class Order < ApplicationRecord
  include AASM
  belongs_to :user
  has_many :order_item

  validates :recipient, :tel, :address, presence: true
  validates :num, uniqueness: true

  before_save :generate_num

  def total_price
    order_item.reduce(0) { |sum, item| sum + item.sell_price }.to_i
  end
  
  aasm column: 'state' do
    state :pending, initial: true
    state :paid, :delivered, :cancelled

    event :pay do

      before do |args|
        self.transaction_id = args[:transaction_id]
      end
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
