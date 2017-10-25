require './lib/math_libs'
require './lib/text_utils'

class NeuralNetwork
  def initialize
    @math = MathLibs.new
  end
  def train(x)
    @h = Array.new(x.size) {Array.new(x.first.size)}
    for i in 0...@h.size
      for j in 0...@h[i].size
        @h[i][j] = Random.rand(-1.0...1.0)
      end
    end
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
  def layers_train(x)
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

text = 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'
util = TextUtils.new
util.read_text(text)
x1 = util.one_hot_vector
text = 'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.'
util = TextUtils.new
util.read_text(text)
x2 = util.one_hot_vector
nn = NeuralNetwork.new
w = nn.train(x1)
y = nn.predict(x2)

p util.result_to_string(y)