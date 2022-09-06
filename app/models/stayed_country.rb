class StayedCountry < ApplicationRecord
    extend ActiveHash::Associations::ActiveRecordExtensions
    acts_as_taggable
    acts_as_taggable_on :countries
    belongs_to :country
    belongs_to :user

    validates :country_id, presence: true
    validates :user, presence: true
    
end
