class Post < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_attached_file :image, styles: { large: "600x600>", medium: "300x300>", thumb: "100x100#" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
