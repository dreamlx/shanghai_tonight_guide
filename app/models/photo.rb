# encoding: utf-8
class Photo < ActiveRecord::Base
  attr_accessible :title, :desc, :photoable_id, :photoable_type ,:photo, :photo_cache, :remove_photo
  #belongs_to :album
  belongs_to :photoable ,:polymorphic => true
  
  after_save :replace_photo_of_place
  
  mount_uploader :photo, AlbumPhotoUploader
  
  rails_admin do
    list do 
      field :title do 
        label "标题"
      end
      field :desc do 
        label "描叙"
      end
      field :photoable do
        label "相片父对象"
      end
      field :photo do
        label "相片"
      end
    end
  end
  
  private
  def replace_photo_of_place

        place = Place.find(self.photoable_id)
        last_photo = place.photos.at(-1)
        place.photo = last_photo
        place.thumb_url = last_photo.photo.normal.url
        place.save

  end
end
