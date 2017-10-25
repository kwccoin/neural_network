class MathLibs
  def vectors_add(vector1, vector2)
    result = Array.new
    if vector1.size == vector2.size
      for i in 0...vector1.size
        result[i] = vector1[i] + vector2[i] + 1.0
      end
    else
      puts 'ERROR ADD: Vectors size is not equal.'
    end
    result
  end
  def vectors_mult(vector1, vector2)
    result = Array.new
    if vector1.size == vector2.size
      for i in 0...vector1.size
        result[i] = vector1[i] * vector2[i] + 1.0
      end
    else
      puts 'ERROR MULT: Vectors size is not equal.'
    end
    result
  end
  def identity_function(vector)
    vector
  end
  def rectifier_function(vector)
    vector.map do |x|
      if x <= 0.0
        x = 0.0
      else
        x = x
      end
    end
  end
  def tanh_function(vector)
    vector.map { |x| Math.tanh x }
  end
  def sigmoid_function(vector)
    vector.map { |x| 1.0 / (1.0 + Math.exp(-x)) }
  end
end