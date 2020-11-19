module Enumerable
  def my_each
    return for i in self do
      yield i
    end
  end

  def my_each_with_index
  end

  def my_select
  end

  def my_all?
  end

  def my_any?
  end

  def my_none?
  end

  def my_count
  end

  def my_map
  end

  def my_inject
  end

  def multiply_els
  end
end

puts ([3,2,1,4,5,6]).each { |i| } 
puts ([3,2,1,4,5,6]).my_each { |i| }