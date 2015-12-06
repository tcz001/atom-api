class Image < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true
  has_attached_file :file, :path => ':class/:attachment/:id/:basename.:extension'
  validates :file, :attachment_presence => true
  validates_attachment_content_type :file, :content_type => /\Aimage\/.*\Z/
end
