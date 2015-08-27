class Listing < ActiveRecord::Base
	if Rails.env.development?
		has_attached_file :image, styles: { medium: "300x", thumb: "200x>" }, default_url: "default.jpg"
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
	else
		has_attached_file :image, styles: { medium: "300x", thumb: "200x>" }, default_url: "default.jpg",
					  :storage => :dropbox,
					  :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
					  :path => ":style/:id_:filename"
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
	belongs_to :user
	end

	#add validations
	validates :name, :description, :price, presence: true
	validates :price, numericality: {greater_than: 0}
	validates_attachment_presence :image

	#link to user
	belongs_to :user

end
