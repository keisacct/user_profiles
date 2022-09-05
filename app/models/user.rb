class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  acts_as_taggable_on
  acts_as_taggable_on :stayed_countries
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, 
         omniauth_providers: [:google_oauth2]

  has_many :sns_credentials
  has_many :stayed_countries
  has_many :countries, through: [:stayed_countries]
  has_many :questions

  validates :username, presence: true, uniqueness: true
  mount_uploader :user_icon, ImageUploader

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    user = User.where(email: auth.info.email).first_or_initialize(
      username: auth.info.name,
      email: auth.info.email
    )
    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns}
  end
end
