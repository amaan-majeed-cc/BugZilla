class Ticket < ApplicationRecord
  belongs_to :creator, class_name: "User"
  belongs_to :developer, class_name: "User"
  belongs_to :project, class_name: "Project"

  enum :ticket_type, {
    feature: "feature",
    bug: "bug"
  }

  validates :title, :deadline, :ticket_type, :status, :creator_id, :developer_id, :project_id, presence: true
end
