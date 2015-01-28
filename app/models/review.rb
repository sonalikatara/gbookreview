class Review < ActiveRecord::Base
  belongs_to :reader
  default_scope -> { order('created_at DESC') }

  validates_numericality_of :rating
  validates :reader_id, :title, :author, :comment, :rating, presence: true
  validates :picture, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\Z}i,
    messsage: 'must be a URL for GIF, JPG or PNG image.'
}

  after_validation :assign_default_picture

  #validates_inclusion_of :rating :in=>[1,2,3]

  private

    def assign_default_picture
      if picture.blank?
        self.picture = "none"
      end
    end

end
