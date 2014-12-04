class Review < ActiveRecord::Base
  validates_numericality_of :rating
  validates :reader, :title, :author, :comment, :rating, presence: true
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
