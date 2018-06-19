class Item < ApplicationRecord
	mount_uploaders :photos, PhotoUploader
  	serialize :photos, JSON
  	has_and_belongs_to_many :categories
end
