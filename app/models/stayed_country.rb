class StayedCountry < ApplicationRecord
    extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to :country
    belongs_to :user

    validates :country_id, presence: true
    validates :user, presence: true
    
end
