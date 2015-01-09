class Reader < ActiveRecord::Base
   belongs_to :group
   has_many :review
   validates :group_id, presence: true;   
end
