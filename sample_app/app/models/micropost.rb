class Micropost < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :postpicture, PostPictureUploader
  validates :user_id, presence: true
  validates :caption, presence: true, length: { maximum: 1000 }
  validate  :postpicture_size
  
   def self.search(pattern)
      if pattern.blank?  # blank? covers both nil and empty string
        all
      else
        where('caption LIKE ?', "%#{pattern}%")
    end
  end
  
  private

    # Validates the size of an uploaded picture.
    def postpicture_size
      if postpicture.size > 5.megabytes
        errors.add(:postpicture, "should be less than 5MB")
      end
    end
end
