class View < ApplicationRecord
  belongs_to :user
  
  scope :not_deleted, -> { where(deleted_at: nil) }
  scope :recently_played, -> { not_deleted.order(updated_at: :desc) }
  scope :with_user, ->(user) { where(user_id: user.try(:id))}
  
  simple_enum :list_type, %i[ playlist channel ]
end
