class Review < ActiveRecord::Base
  before_save { self.picture = "none"}
  belongs_to :reader
  default_scope -> { order('created_at DESC') }
  has_attached_file :bookcover, :styles => { :small => "150x150>", :large => "300x300>"},
                  :url  => "/assets/reviews/:id/:style/:basename.:extension",
                 :path => ":rails_root/public/assets/reviews/:id/:style/:basename.:extension" 

  validates_numericality_of :rating
  validates :reader_id, :title, :author, :comment, :rating, presence: true
  validates :picture, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\Z}i,
    messsage: 'must be a URL for GIF, JPG or PNG image.'
}
 
validates_attachment :bookcover,
    :presence => true,
    :size => { :in => 0..10.megabytes },
    :content_type => { :content_type => /^image\/(jpeg|png|gif|tiff)$/ }
    
  #  validates_attachment_file_name :bookcover, :matches => [/png\Z/, /jpe?g\Z/, /gif\Z/]
 # after_validation :assign_default_picture

  #validates_inclusion_of :rating :in=>[1,2,3]

end
