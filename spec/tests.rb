
#!/usr/bin/ruby

require 'rspec'
require './main.rb'
require 'colorize'

describe Enumerable do
    arr_in = [1, 3, 5, 4, 0]
    enum_in = (1..5)
    bool_in = [true, false, false, true]
    regexp_in = %w[dOg door rod blade]
    checkmark = "\u2713".green.bold
    puts checkmark.encode('utf-8')


    describe '[my_each tests] >'.blue.bold do

    it "my_each returned value." do
      expect( arr_in.my_each {|i|} ).to eq( arr_in.each {|i|})
    end
    
    it "my_each block parsing." do
      arr = []
      my_arr = []
      arr_in.each {|i| arr<<(i+1)}
      arr_in.my_each {|i| my_arr<<(i+1) }
      expect( my_arr ).to eq( arr )
    end
    
    it "my_each range parsing." do
      expect( (1..5).my_each {|i|} ).to eq( (1..5).each {|i|} )
    end

  end



  describe '[my_each_with_index tests] >'.bold.blue do
    it 'my_each_with_index returned value.' do
      expect( arr_in.my_each_with_index {|item, i|} ).to eq(arr_in.each_with_index {|item, i|})
    end
    
    block = proc {|el, i| puts "#{el}:#{i}"}
    
    
    it 'my_each_with_index block parsing.' do
      expect { print(arr_in.my_each_with_index(&block)) }.to output(print(arr_in.each_with_index(&block))).to_stdout
    end

    my_each_with_index_output = ''
    block = proc { |num, idx| my_each_with_index_output += "Num: #{num}, idx: #{idx}\n" }
    it 'my_each_with_index block parsing.' do
      expect(enum_in.my_each_with_index(&block)).to eq(enum_in.my_each_with_index(&block))
    end
  end

  describe '[my_select tests] >'.bold.blue do
    it 'my_select even value.' do
      expect( arr_in.my_select(&:even?)).to eq( arr_in.select(&:even?))
    end
    
    block = proc {|el, i| puts "#{el}:#{i}"}
    
    
    it 'my_select block parsing.' do
      expect( arr_in.my_select {|n| n > 0} ).to eq( arr_in.select {|n| n > 0} )
    end

    my_each_with_index_output = ''
      it 'my_select range parsing.' do
        expect( enum_in.my_select(&:odd?)).to eq( enum_in.select(&:odd?))
      end
  end


  describe '[my_all tests] >'.bold.blue do

    it 'my_all no-block.' do
      expect( arr_in.my_all? ).to eq( arr_in.all? )
    end

    it 'my_all even value.' do
      expect( arr_in.my_all?(&:even?)).to eq( arr_in.all?(&:even?))
    end
    
    it 'my_all block parsing.' do
      expect( arr_in.my_all? {|n| n > 0} ).to eq( arr_in.all? {|n| n > 0} )
    end

    it 'my_all class parsing.' do
      expect( arr_in.my_all?(Numeric)).to eq( arr_in.all?(Numeric))
    end

    it 'my_all sub-class parsing.' do
      expect( arr_in.my_all?(Integer)).to eq( arr_in.all?(Integer))
    end
 
    it 'my_all range parsing.' do
      expect( enum_in.my_all?(1)).to eq( enum_in.all?(1))
    end

    it 'my_all regexp parsing.' do
      expect( regexp_in.my_all?(/d/)).to eq( regexp_in.all?(/d/))
    end
  end


  describe '[my_any tests] >'.bold.blue do

    it 'my_any no-block.' do
      expect( arr_in.my_any? ).to eq( arr_in.any? )
    end

    it 'my_any even value.' do
      expect( arr_in.my_any?(&:even?)).to eq( arr_in.any?(&:even?))
    end
    
    it 'my_any block parsing.' do
      expect( arr_in.my_any? {|n| n > 0} ).to eq( arr_in.any? {|n| n > 0} )
    end

    it 'my_any class parsing.' do
      expect( arr_in.my_any?(Numeric)).to eq( arr_in.any?(Numeric))
    end

    it 'my_any sub-class parsing.' do
      expect( arr_in.my_any?(Integer)).to eq( arr_in.any?(Integer))
    end
 
    it 'my_any range parsing.' do
      expect( enum_in.my_any?(1)).to eq( enum_in.any?(1))
    end

    it 'my_any regexp parsing.' do
      expect( regexp_in.my_any?(/d/)).to eq( regexp_in.any?(/d/))
    end
  end

  describe '[my_none tests] >'.bold.blue do

    it 'my_none no-block.' do
      expect( arr_in.my_none? ).to eq( arr_in.none? )
    end

    it 'my_none even value.' do
      expect( arr_in.my_none?(&:even?)).to eq( arr_in.none?(&:even?))
    end
    
    it 'my_none block parsing.' do
      expect( arr_in.my_none? {|n| n > 0} ).to eq( arr_in.none? {|n| n > 0} )
    end

    it 'my_none class parsing.' do
      expect( arr_in.my_none?(Numeric)).to eq( arr_in.none?(Numeric))
    end

    it 'my_any sub-class parsing.' do
      expect( arr_in.my_any?(Integer)).to eq( arr_in.any?(Integer))
    end
 
    it 'my_none range parsing.' do
      expect( enum_in.my_none?(1)).to eq( enum_in.none?(1))
    end

    it 'my_none regexp parsing.' do
      expect( regexp_in.my_none?(/d/)).to eq( regexp_in.none?(/d/))
    end
  end


  describe '[my_count tests] >'.bold.blue do

    it 'my_count no-block.' do
      expect( arr_in.my_count ).to eq( arr_in.count )
    end

    it 'my_count even value.' do
      expect( arr_in.my_count(&:even?)).to eq( arr_in.count(&:even?))
    end
    
    it 'my_count block parsing.' do
      expect( regexp_in.my_count {|s| s == s.upcase} ).to eq( regexp_in.count {|s| s == s.upcase} )
    end

    it 'my_count range parsing.' do
      expect( enum_in.my_count(1)).to eq( enum_in.count(1))
    end
  end



  describe '[my_map tests] >'.bold.blue do

    it 'my_map even value.' do
      expect( arr_in.my_map(&:even?)).to eq( arr_in.map(&:even?))
    end
    
    it 'my_map block parsing.' do
      expect( regexp_in.my_map {|s| s == s.upcase} ).to eq( regexp_in.map {|s| s == s.upcase} )
    end

    it 'my_map block parsing insertion.' do
      expect( regexp_in.my_map { |word| word + '?' } ).to eq( regexp_in.map { |word| word + '?' } )
    end

    it 'my_map inversion.' do
      expect( regexp_in.my_map(&:!) ).to eq( regexp_in.map(&:!) )
    end
  end


  describe '[my_inject tests] >'.bold.blue do

    it 'my_inject block parsing.' do
      expect( arr_in.my_inject {|i,j| i+j} ).to eq( arr_in.inject {|i,j| i+j} )
    end

    # it 'my_inject block parsing.' do
    #   expect { print(arr_in.my_inject {|i,j| i+j}) }.to output(print(arr_in.my_inject {|i,j| i+j})).to_stdout
    # end

    it 'my_inject block parsing with parameter.' do
      expect( arr_in.my_inject(10) {|i,j| i+j} ).to eq( arr_in.inject(10) {|i,j| i+j} )
    end

    it 'my_inject symbol parsing without block.' do
      expect( arr_in.my_inject(:*) ).to eq( arr_in.inject(:*) )
    end

    it 'my_inject range & multi arguments parsing without block.' do
      expect( enum_in.my_inject(10,:*) ).to eq( enum_in.inject(10,:*) )
    end

    it 'my_inject range & block parsing.' do
      expect( enum_in.my_inject(4) {|prod, n| prod * n} ).to eq( enum_in.inject(4){|prod, n| prod * n} )
    end

  end
  

end