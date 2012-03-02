require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  #define fixture for this unit test
  fixtures :products
  
  
  #test 1   
  test "product attributes must not be empty" do
      product = Product.new
      assert product.invalid?
      assert product.errors[:title].any?
      assert product.errors[:description].any?
      assert product.errors[:price].any?
      assert product.errors[:image_url].any?
  end
  
 #test 2 
  test "product price must be positive" do
    product = Product.new(:title=> "My Book Title", :description => "yyy",  :image_url => "zzz.jpg")
  
    product.price = -1 
    assert product.invalid? 
    assert_equal "must be greater than or equal to 0.01", product.errors[:price].join('; ')
    product.price = 0 
    assert product.invalid? 
    assert_equal "must be greater than or equal to 0.01", product.errors[:price].join('; ')
    product.price = 1
    assert product.valid?
  end


 #test 3
 test "product is not valid without a unque title - i18n" do
    product = Product.new(:title => products(:ruby).title,
                          :description => "yyyyy",
                          :price => 1,
                          :image_url => "fred.gif")
    assert !product.save
    assert_equal "has already been taken" , product.errors[:title].join(';')
    assert_equal I18n.translate('activerecord.errors.messages.taken') , product.errors[:title].join(';')
 end
 test "product title must be at least ten character" do
   product = products(:ruby)
   assert product.valid? , "product title should not be invalid"
   product.title = product.title.first(9)
   assert product.invalid? , "product title should be invalid"
   
 end


end
