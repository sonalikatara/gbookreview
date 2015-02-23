class Reader < ActiveRecord::Base
   before_save {self.email = email.downcase}
   belongs_to :group
   has_many :review, dependent: :destroy

    has_attached_file :readerpicture, :styles => { :small => "90x90>", :large => "300x300>"},
                  :url  => "/assets/readers/:id/:style/:basename.:extension",
                 :path => ":rails_root/public/assets/readers/:id/:style/:basename.:extension" 

   validates_attachment :readerpicture,
    :presence => true,
    :size => { :in => 0..10.megabytes },
    :content_type => { :content_type => /^image\/(jpeg|png|gif|tiff)$/ }


   validates :group_id, presence: true;   
   validates :readerName, presence: true,  uniqueness: { case_sensitive: false }, length: {maximum: 50}

   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
   validates :email, presence: true, format: {with:  VALID_EMAIL_REGEX }, length: {maximum: 255}

      
  validates_confirmation_of :email
  validates_presence_of :email_confirmation
 
end
