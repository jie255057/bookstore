class Book < ApplicationRecord
	acts_as_paranoid

	# validates
	validates :title, presence: true
	validates :isbn, :isbn13, presence: true, uniqueness: true
	validates :list_price, :sell_price, :page_num, numericality: {greater_than: 0}

	# relationships
	has_one_attached :cover_image
	belongs_to :publisher
	belongs_to :category
	has_many :comments
	has_many :favorites
  has_many :users, through: :favorites

	# scopes
	# def self.available
	# 	where(on_sell: true).where('list_price > 0')
	# end
	scope :available, -> { where(on_sell: true).where('list_price > 0') }

	def favorited_by?(u)
		favorites.exists?(user: u)
	end
end
