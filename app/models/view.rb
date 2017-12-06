class View < ApplicationRecord
  belongs_to :user
  
  scope :recently_played, -> { order(updated_at: :desc) }
  
  simple_enum :list_type, %i[ playlist channel ]
end
