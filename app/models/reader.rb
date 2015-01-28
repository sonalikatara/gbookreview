class Reader < ActiveRecord::Base
   before_save {self.email = email.downcase}
   belongs_to :group
   has_many :review
   validates :group_id, presence: true;   
   validates :readerName, presence: true,  uniqueness: { case_sensitive: false }, length: {maximum: 50}

   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
   validates :email, presence: true, format: {with:  VALID_EMAIL_REGEX }, length: {maximum: 255}

   validates :picture, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\Z}i,
    messsage: 'must be a URL for GIF, JPG or PNG image.'
    }
    
  validates_confirmation_of :email
  validates_presence_of :email_confirmation
 
end
