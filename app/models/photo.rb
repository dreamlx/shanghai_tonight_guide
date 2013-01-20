# encoding: utf-8
class Photo < ActiveRecord::Base
  attr_accessible :title, :desc, :photoable_id, :photoable_type ,:photo, :photo_cache, :remove_photo
  #belongs_to :album
  belongs_to :photoable ,:polymorphic => true, :inverse_of => :photos
  
  #call back
  after_save :replace_photo_of_place
  after_destroy :replace_photo_of_place
  
  mount_uploader :photo, AlbumPhotoUploader
  
  rails_admin do
    label "照片库"
    list do 
      field :title do 
        label "标题"
      end
      field :desc do 
        label "详细说明"
      end
      field :photoable do
        label "相片归属"
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
    if last_photo.nil?
      place.thumb_url =""
    else
      place.thumb_url = last_photo.photo.normal.url
    end
    place.save
  end
  

  
end
