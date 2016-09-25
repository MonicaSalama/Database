class User < ActiveRecord::Base
    has_friendship
    has_many :microposts, dependent: :destroy
    mount_uploader :profilepicture, ProfilePictureUploader
    before_save  { self.email = email.downcase }
    before_save {self.phone = phone == ''? nil : phone}

    validates(:firstname, presence: true, length: { maximum: 50 })
    validates(:lastname, presence: true, length: { maximum: 50 })
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates(:email, presence: true, length: { maximum: 255 },
              format: { with: VALID_EMAIL_REGEX },
              uniqueness: { case_sensitive: false })
    has_secure_password
    validates(:phone, :allow_blank => true, uniqueness: true, length: { maximum: 15 })
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
    validate  :profilepicture_size
  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  def feed
    @me = User.find(id)
    friends_ids = @me.friends.map{|x| x[:id]}
    Micropost.where("user_id IN (?) OR user_id = ? or ispublic = ?", friends_ids, id, true)
  end
  
   def self.search(pattern)
      if pattern.blank?  # blank? covers both nil and empty string
        all
      else
              where("firstname LIKE ? or lastname LIKE ? or email = ? or phone = ?
              or hometown = ?" , "%#{pattern}%"  ,"%#{pattern}%","#{pattern}","#{pattern}","#{pattern}")
    end
  end
  
#   # add a user.
#   def add_friend(user, other_user)
#     user.friend_request(other_user);
#   end
  
#   # accept a user.
#   def accept_friend(user, other_user)
#     user.accept_request(other_user);
#   end
  
#   # decline a user.
#   def decline_friend(user, other_user)
#     user.decline_request(other_user);
#   end

#   # remove a user.
#   def remove_friend(user, other_user)
#     user.remove_friend(other_user);
#   end

#   # Returns true if the current user is following the other user.
#   def is_friend?(user, other_user)
#     user.friends_with?(other_user);
#   end
  
  private
    # Validates the size of an uploaded picture.
    def profilepicture_size
      if profilepicture.size > 5.megabytes
        errors.add(:profilepicture, "should be less than 5MB")
      end
    end
  
end
