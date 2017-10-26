require 'chunky_png'

class ImageUtils
  def read_image(path)
    image = Array.new
    img = ChunkyPNG::Image.from_file(path)
    height = img.dimension.height
    width  = img.dimension.width
    height.times do |i|
      image[i] = Array.new
      width.times do |j|
        image[i][j] = ChunkyPNG::Color.r(img[i,j]) / 255.0
      end
    end
    image
  end
  def draw_image(img)
    image = ChunkyPNG::Image.new(28, 28, ChunkyPNG::Color::TRANSPARENT)
    for i in 0...28
      for j in 0...28
        pixel = (img[i][j] * 255.0).to_i.abs
        image[i,j] = ChunkyPNG::Color.rgb(pixel, pixel, pixel)
      end
    end
    image.save('maps.png')
  end
end
