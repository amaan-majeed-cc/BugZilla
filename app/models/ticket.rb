class Ticket < ApplicationRecord
  belongs_to :creator, class_name: "User"
  belongs_to :developer, class_name: "User", optional: true
  belongs_to :project, class_name: "Project"

  has_one_attached :image
  # validates_attachment_content_type :image, content_type: [ "image/png", "image/gif" ]
  validate :correct_image_type

  TICKET_TYPES = [ "bug", "feature" ]
  BUG_STATUS = [ "new", "started", "resolved" ]
  FEATURE_STATUS = [ "new", "started", "completed" ]
  validates :status, inclusion: { in: BUG_STATUS + FEATURE_STATUS }
  validates :ticket_type, inclusion: { in: TICKET_TYPES }

  validates :title, :deadline, :ticket_type, :status, :creator_id, :project_id, presence: true

  private
  def correct_image_type
    if image.attached?
      acceptable_types = [ "image/png", "image/gif" ]
      unless acceptable_types.include?(image.content_type)
        errors.add(:image, "must be a PNG or GIF")
      end
    end
  end
end
