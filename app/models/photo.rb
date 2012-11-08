class Photo < ActiveRecord::Base
   attr_accessible :title, :desc, :photoable_id, :photoable_type ,:photo, :photo_cache, :remove_photo
  #belongs_to :album
  belongs_to :photoable ,:polymorphic => true
  mount_uploader :photo, AlbumPhotoUploader
end
