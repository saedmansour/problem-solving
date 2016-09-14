class User < ActiveRecord::Base
  ROLES = %w[admin moderator]

  acts_as_voter

  devise :database_authenticatable, :registerable, :recoverable, 
         :rememberable, :trackable, # :authentication_keys => [:username],
         :token_authenticatable , :omniauthable, :omniauth_providers => [:facebook]
                
  #validates :username, :uniqueness => { :case_sensitive => false }

  def self.find_for_facebook_oauth(provider, uid, name, email, oauth_token, username, oauth_expires_at, signed_in_resource=nil)
    user = User.where(:provider => provider, :uid => uid).first
    unless user
        user = User.create(
          :name => name,
          :provider => provider,
          :uid => uid,
          :email => email,
          :password => Devise.friendly_token[0,20],
          :oauth_token => oauth_token,
          :username => username,
          :oauth_expires_at => oauth_expires_at)
    end
    user
  end  
  
  #def self.find_first_by_auth_conditions(warden_conditions)
  #  conditions = warden_conditions.dup
  #  if username = conditions.delete(:username)
  #    where(conditions).where(["lower(username) = :value", { :value => username.downcase }]).first
  #  else
  #    where(conditions).first
  #  end
  #end

  has_many :posts

end #/User
