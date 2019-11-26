class Publisher < ApplicationRecord
    has_many :books
    
    scope :available, -> {where(online: true)}
end
