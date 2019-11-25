module BookHelper
  def cover_image_tag(book, width: 800, height: 600 , fake_img: false)
    if fake_img
      if book.cover_image.attached?
        image_tag book.cover_image.variant(resize_to_limit: [width,height])
      else
        image_tag "https://fakeimg.pl/350x200/?text=Hello"
      end
    else
    image_tag book.cover_image.variant(resize_to_limit: [width,height]) if book.cover_image.attached?
    end
  end


  private


end