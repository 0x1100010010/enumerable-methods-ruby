module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    i = 0
    while i < to_a.length
      yield(to_a[i])
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    while i < length
      yield(self[i], i)
      i += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    arr = []
    my_each do |i|
      arr << i if yield i
    end
    arr
  end

  def my_all?(*args, &block)
    if block_given?
      my_select(&block).length == length
    else
      return true if args == []

      return (my_select { |i| i.instance_of?(args[0]) }).length == length if args[0].is_a? Class
      return (my_select { |i| i.match(args[0]) }).length == length if args[0].is_a? Regexp
      return (my_select { |i| i == args[0] }).length == length if args[0].is_a? Integer

      false
    end
  end

  def my_any?(*args, &block)
    if block_given?
      my_select(&block).length.positive?
    else
      return (my_select { |i| ![nil, false].include?(i) }).length.positive? if args == []
      return (my_select { |i| i == args[0] }).length.positive? if args[0].is_a? Integer
      return (my_select { |i| i.instance_of?(args[0]) }).length.positive? if args[0].is_a? Class
      return (my_select { |i| i.match(args[0]) }).length.positive? if args[0].is_a? Regexp
    end
  end

  def my_none?(*args, &block)
    if block_given?
      my_select(&block).length.zero?
    else
      return length.zero? || (my_select { |i| ![nil, false].include?(i) }).length.zero? if args == []
      return (my_select { |i| i.instance_of?(args[0]) }).length.zero? if args[0].is_a? Class
      return (my_select { |i| i == args[0] }).length.zero? if args[0].is_a? Integer
    end
  end

  def my_count(*args, &block)
    if block_given?
      my_select(&block).length
    else
      return (my_select { |i| i == args[0] }).length if args[0].is_a? Integer

      length
    end
  end

  def my_map(proc = nil)
    return to_enum(:my_map) unless block_given?

    arr = []
    my_select { |n| arr << yield(n) } if proc.nil?
    my_select { |n| arr << proc.call(n) } unless proc.nil?
    arr
  end

  def my_inject(*args)
    if block_given?
      result = args.length.positive?
      res = result ? args[0] : self[0]
      drop(result ? 0 : 1).my_each { |i| res = yield(res, i) }
    elsif (args.length == 1) && ((args[0].is_a? Symbol) || (args[0].is_a? String))
      res = 0
      my_each { |i| res = res.send(args[0], i) }
    else
      res = args[0]
      drop(0).my_each { |i| res = res.send(args[1], i) }
    end
    res
  end

  def multiply_els(args)
    args.my_inject(1) { |prod, n| prod * n }
  end
end
