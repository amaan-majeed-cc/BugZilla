class Ticket < ApplicationRecord
  belongs_to :creator, class_name: "User"
  belongs_to :developer, class_name: "User"
  belongs_to :project, class_name: "Project"

  has_one_attached :image

  # enum :ticket_type, {
  #   feature: "feature",
  #   bug: "bug"
  # }

  TICKET_TYPES = [ "bug", "feature" ]
  BUG_STATUS = [ "new", "started", "resolved" ]
  FEATURE_STATUS = [ "new", "started", "completed" ]
  validates :status, inclusion: { in: BUG_STATUS + FEATURE_STATUS }
  validates :ticket_type, inclusion: { in: TICKET_TYPES }

  validates :title, :deadline, :ticket_type, :status, :creator_id, :project_id, presence: true
end
