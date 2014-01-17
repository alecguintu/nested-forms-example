class Campaign < ActiveRecord::Base
  # General relationship
  has_many :attachments, dependent: :destroy
  # Specific relationships
  has_many :audios, dependent: :destroy, class_name: Audio
  has_one :video, dependent: :destroy, class_name: Video

  accepts_nested_attributes_for :audios, allow_destroy: true
  accepts_nested_attributes_for :video, allow_destroy: true

  validates :name, presence: true

  validate :should_have_one_of_any_attachment
  def should_have_one_of_any_attachment
    errors.add(:attachments, "should have at least one attachmnet") if self.video.blank? && self.audios.blank?
  end

  validate :should_have_one_video
  def should_have_one_video
    errors.add(:video, "should have one video") if video_have_none? && !self.audios.present?
  end

  validate :should_have_at_least_one_audio
  def should_have_at_least_one_audio
    errors.add(:audios, "should have at least one audio") if audio_have_none? && !self.video.present?
  end

  def video_have_none?
    self.video.present? && self.video.marked_for_destruction?
  end

  def audio_have_none?
    self.audios.present? && self.audios.reject(&:marked_for_destruction?).count < 1
  end
end
