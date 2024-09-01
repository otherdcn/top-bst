class Node
  attr_accessor :data, :next_node
  
  def initialize(data)
    self.data = data
  end
end

class Queue
  attr_accessor :head_node, :tail_node

  def initialize
    self.head_node = nil
    self.tail_node = nil
  end

  def empty?
    head_node.nil?
  end

  def peek
    return nil if empty?

    head_node.data
  end

  def enqueue(data)
    node = Node.new(data)

    if empty?
      self.head_node = node
    elsif tail_node.nil?
      self.tail_node = node
      self.head_node.next_node = tail_node
    else
      self.tail_node.next_node = node
      self.tail_node = node
    end

    tail_node
  end

  def dequeue
    return nil if empty?

    dequeued_node = head_node.data
    self.head_node = head_node.next_node

    self.tail_node = nil if tail_node == head_node

    dequeued_node
  end

  def traverse(node)
    return nil if empty?

    if node.nil?
      print ".\n"
      return
    elsif node.next_node.nil?
      print "#{node.data}.\n"
      return
    else
      print "#{node.data}, "
      traverse(node.next_node)
    end
  end
end

=begin
q = Queue.new

puts "At Super Ticket Masters! Line to buy tickets for HYU concert open!"
q_2 = Queue.new

["Joe", "Jin", "Jay", "Joy", "Jan", "Jen", "Jua"][0...].each do |element|
  puts "Joining line: #{element}"
  q_2.enqueue(element)
end

puts "\nFirst in line: #{q_2.peek}"

print "People in the queue: "
q_2.traverse(q_2.head_node)

puts ""

puts "Removing poeple from the queue"
6.times do |i|
  next_in_line = q_2.dequeue

  puts "#{next_in_line}! you can come in.\n"
end

puts "\nFirst in line: #{q_2.peek}"

print "Who's left in the queue: "
q_2.traverse(q_2.head_node)
=end

