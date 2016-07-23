require 'test_helper'

# Przed klasa warto zawsze opisac zeby rubocop sie nieplul a inni wiedzieli co
# sie dzieje w kodzie
class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'product attributes must not be empty' do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test 'ogranicz czas testowania/pracy do rozsądnych godzin pracy' do
    assert (
             (
               Time.now.hour > 6 &&
               Time.now.hour < 18
             ) ||
             (
               Time.now.hour > 21 &&
               Time.now.hour <= 24
             )
           )
  end

  test 'product price must be positive' do
    product = Product.new(
      title:        'My Book Title',
      description:  'yyy',
      image_url:    'zzz.jpg'
    )
    product.price = -1
    assert product.invalid?
    assert_equal 'must be greater than or equal to 0.01',
                 product.errors[:price].join('; ')

    product.price = 1
    assert product.valid?
  end

  def new_product(image_url)
    Product.new(
      title:        'My Book 2 from product with url passed',
      description:  'descriptionnnn',
      price:        1,
      image_url:    image_url
    )
  end

  test 'image url' do
    ok = %w(fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.c/xfred.png)
    bad = %w(fred.doc fred.gif/more fred.gif.more)
    ok.each do |name|
      assert new_product(name).valid?, "#{name} should be valid"
    end

    bad.each do |name|
      assert new_product(name).invalid?, "#{name} should be invalid"
    end
  end

  test 'product is not valid without a unique title' do
    product = Product.new(
      title:        products(:ruby).title,
      description:  'yyyy',
      price:        1,
      image_url:    'fred.gif'
    )
    assert !product.save
    assert_equal 'has already been taken', product.errors[:title].join('; ')
    # assert_equal I18n.translate('activerecord.errors.messages.taken'),
    #             product.errors[:title].join('; ')
  end
end
