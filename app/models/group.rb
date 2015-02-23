class Group < ActiveRecord::Base
   before_save  {self.email = email.downcase}
   before_create 
   has_many :reader, dependent: :destroy

   has_secure_password
   has_attached_file :grouppicture, :styles => { :small => "150x150>", :large => "300x300>"},
                  :url  => "/assets/groups/:id/:style/:basename.:extension",
                 :path => ":rails_root/public/assets/groups/:id/:style/:basename.:extension" 

   validates_attachment :grouppicture,
    :presence => true,
    :size => { :in => 0..10.megabytes },
    :content_type => { :content_type => /^image\/(jpeg|png|gif|tiff)$/ }

 
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
