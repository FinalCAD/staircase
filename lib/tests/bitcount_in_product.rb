# def solution(a, b)
#   BitcountInProduct.new(variable_a: a, variable_b: b).solution
# end

class BitcountInProduct
  def solution(variable_a:, variable_b:)
    (variable_a * variable_b).to_s(2).count('1')
  end
end
