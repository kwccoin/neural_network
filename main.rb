require './lib/math_libs'
require './lib/text_utils'
require './lib/image_utils'

class NeuralNetwork
  def initialize
    @math = MathLibs.new
  end
  def train(x)
    
    @c = Array.new(x.size) {Array.new(x.first.size)}
    for i in 0...@c.size
      for j in 0...@c[i].size
        @c[i][j] = Random.rand(-1.0...1.0)
      end
    end
    100.times do |time|
      layers_train(x)
    end
    @h
  end
  def predict(x)
    @y = Array.new
    layers_predict(x)
    @y
  end
  def layers_train(x, *h)
    if !h.empty?
      @h = h
    else
      @h = Array.new(x.size) {Array.new(x.first.size)}
      for i in 0...@h.size
        for j in 0...@h[i].size
          @h[i][j] = Random.rand(-1.0...1.0)
        end
      end
    end
    for i in 0...x.size
      array = cell(x[i], @h[i], @c[i])
      if i + 1 < x.size
        @h[i + 1] = array[0]
        @c[i + 1] = array[1]
      end
    end
  end
  def layers_predict(x)
    for i in 0...x.size
      @y[i] = cell(x[i], @h.last, @c.last)[0]
    end
  end
  def cell(x, h, c)
    mult1 = @math.vectors_mult(x, h)
    add1 = @math.vectors_add(x, h)
    add2 = @math.vectors_add(x, h)
    add3 = @math.vectors_add(x, h)
    add4 = @math.vectors_add(x, h)
    add5 = @math.vectors_add(x, h)
    add6 = @math.vectors_add(x, h)
    add7 = @math.vectors_add(x, h)
    
    relu1 = @math.rectifier_function(mult1)
    sigm1 = @math.sigmoid_function(add1)
    tanh1 = @math.tanh_function(add2)
    sigm2 = @math.sigmoid_function(add3)
    sigm3 = @math.sigmoid_function(add4)
    tanh2 = @math.tanh_function(add5)
    sigm4 = @math.sigmoid_function(add6)
    relu2 = @math.rectifier_function(add7)
    
    add8 = @math.vectors_add(sigm1, tanh1)
    add9 = @math.vectors_add(relu1, sigm2)
    mult2 = @math.vectors_mult(sigm3, tanh2)
    mult3 = @math.vectors_mult(sigm4, relu2)
    
    sigm5 = @math.sigmoid_function(add8)
    tanh3 = @math.tanh_function(mult2)
    tanh4 = @math.tanh_function(add9)
    tanh5 = @math.tanh_function(mult3)
    
    add10 = @math.vectors_add(sigm5, tanh3)
    add11 = @math.vectors_add(tanh5, c)
    tanh6 = @math.tanh_function(add11)
    # c to array
    mult4 = @math.vectors_mult(tanh4, tanh6)
    ident = @math.identity_function(mult4)
    tanh7 = @math.tanh_function(add10)
    
    mult5 = @math.vectors_mult(tanh7, ident)
    # h to array
    tanh8 = @math.tanh_function(mult5)
    
    [tanh8, mult4]
  end
end

img = ImageUtils.new
img_array = img.read_image('C:\msys64\home\Łukasz Fuszara\neural_network\dataset\mnist_png\training\1\3.png')

nn = NeuralNetwork.new
w = nn.train(img_array)

i = 0
max = 1000
while i <= max
  str = 'C:\msys64\home\Łukasz Fuszara\neural_network\dataset\mnist_png\training\1' + '\\' + i.to_s + '.png'
  if File.exist? str
    img_array = img.read_image(str)
    w = nn.train(img_array)
  end
  i += 1
end

img.draw_image(w)