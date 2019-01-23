class Enclosure < ActiveRecord::Base
  belongs_to :buyer

  mount_uploader :file, EnclosureUploader
end
