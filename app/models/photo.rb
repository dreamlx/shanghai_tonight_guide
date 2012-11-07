class Photo < ActiveRecord::Base
   attr_accessible :title, :desc, :album_id,:photo, :photo_cache, :remove_photo
  belongs_to :album
  mount_uploader :photo, AlbumPhotoUploader
end
