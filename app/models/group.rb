class Group < ActiveRecord::Base
   before_save  {self.email = email.downcase}
   before_create 
   has_many :reader, dependent: :destroy

   has_secure_password

 
   validates :picture, :description, presence: true

   validates :groupPassword, presence: true, length: {maximum:20}

   validates :groupName, presence: true,  uniqueness: { case_sensitive: false }, length: {maximum: 50}

   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
   validates :email, presence: true, format: {with:  VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }, length: {maximum: 255}

   validates :picture, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\Z}i,
    messsage: 'must be a URL for GIF, JPG or PNG image.'
    }

   validates_confirmation_of :groupPassword, :email
   validates_presence_of :groupPassword_confirmation, :email_confirmation

   def self.authenticateReader(group, groupPassword)
     #group = Group.where(groupName: groupName).first
     chk_group = Group.find(group)
     if  chk_group && chk_group.groupPassword == groupPassword
       chk_group
     else
       nil
     end  
   end

end
