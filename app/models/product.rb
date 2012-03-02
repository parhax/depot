class Product < ActiveRecord::Base
  validates :title , :description , :image_url , :presence => {:message => "nabayad khali bashe!"}
  validates :price , :numericality => {:greater_than_or_equal_to => 0.01}
  validates :title , :uniqueness => true , :length => {:minimum => 10 , :message => 'must be at least ten character', :maximum => 30 , :message => "must not be greater than thirty char"}
  validates :image_url , :format => {
    :with => %r{\.(gif|jpg|png)$}i ,
    :message => "must be a URL for GIF, JPG or PNG image."}
end
