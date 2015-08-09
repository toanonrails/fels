class User < ActiveRecord::Base
  has_many :active_relationships, class_name:  :Relationship,
                                  foreign_key: :follower_id,
                                  dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed

  has_many :passive_relationships, class_name:  :Relationship,
                                   foreign_key: :followed_id,
                                   dependent:   :destroy
  has_many :followers, through: :passive_relationships

  attr_accessor :remember_token
  mount_uploader :avatar, PictureUploader
  before_save :downcase_email
  validates_presence_of :name, :email
  validates :name, length: {maximum: 50}
  validates :email, format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum: 3, maximum:50}, allow_blank: true
  validate :picture_size

  # Follow an user
  def follow other_user_id
    active_relationships.create followed_id: other_user_id
  end

  # Unfollow an user
  def unfollow other_user_id
    relationship = active_relationships.find_by_followed_id other_user_id
    relationship.destroy if relationship
  end

  # Check if this user is following the given user or not
  def following? other_user
    following.include? other_user
  end

  # Remember a user in database for persistent session
  def remember
    @remember_token = User.new_token
    update_attribute :remember_digest, User.digest(remember_token)
  end

  # Forget a persistent session of a logged-out user
  def forget
    update_attribute :remember_digest, nil
  end

  # Check if the given token is match the digest in the database
  def authenticate? attribute, token
    digest = send "#{attribute}_digest"
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password? token
  end

  # Returns the hash digest of the given string
  def self.digest string
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create string, cost: cost
  end

  # Generate new token
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  private
  # Convert email address to downcase before save
  def downcase_email
    email.downcase!
  end

  # Validate uploaded avatar picture size
  def picture_size
    if avatar.size > 5.megabytes
      errors.add :avatar, "should less than 5MB"
    end
  end
end
