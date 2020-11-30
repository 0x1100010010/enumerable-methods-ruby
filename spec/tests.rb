
#!/usr/bin/ruby

require 'rspec'
require './main.rb'
require 'colorize'

describe Enumerable do
    arr_in = [1, 3, 5, 4, 0]
    enum_in = (1..5)
    regexp_in = %w[dog door rod blade]
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



end