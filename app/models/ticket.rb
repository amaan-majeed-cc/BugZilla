class Ticket < ApplicationRecord
  belongs_to :creator, class_name: "User"
  belongs_to :developer, class_name: "User", optional: true
  belongs_to :project, class_name: "Project"

  has_one_attached :image
  validate :valid_image_content_type


  TICKET_TYPES = [ "bug", "feature" ]
  BUG_STATUS = [ "new", "started", "resolved" ]
  FEATURE_STATUS = [ "new", "started", "completed" ]
  validates :status, inclusion: { in: BUG_STATUS + FEATURE_STATUS }
  validates :ticket_type, inclusion: { in: TICKET_TYPES }

  validates :title, :deadline, :ticket_type, :status, :creator_id, :project_id, presence: true

  private
  def valid_image_content_type
    if image.attached? &&
       ![ "image/png", "image/gif" ].include?(image.content_type)

      errors.add(:image, "must be PNG or GIF")
    end
  end
end
