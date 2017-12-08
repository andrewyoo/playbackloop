class View < ApplicationRecord
  belongs_to :user
  
  scope :recently_played, -> { order(updated_at: :desc) }
  scope :not_user, ->(user) { where.not(user_id: user.try(:id)) }
  scope :with_user, ->(user) { where(user_id: user.try(:id))}
  
  simple_enum :list_type, %i[ playlist channel ]
end
