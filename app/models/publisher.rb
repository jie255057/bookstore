class Publisher < ApplicationRecord
    validates :name,  presence: true
    
    has_many :books
    
    scope :available, -> {where(online: true)}
end
