require_relative 'node'
require_relative 'queue'

class Tree
  attr_accessor :root_node

  def initialize(messy_array)
    clean_array = clean(messy_array)

    self.root_node = build_tree(clean_array, 0, clean_array.size - 1)
  end

  def build_tree(array, start_index, end_index)
    if start_index > end_index
      return nil
    else
      middle_index = (start_index + end_index) / 2
      root_node = Node.new(array[middle_index])

      root_node.left_child = build_tree(array, start_index, middle_index - 1)
      root_node.right_child = build_tree(array, middle_index + 1, end_index)
    end

    root_node
  end

  def clean(array)
    array.sort.uniq
  end

  def empty?
    root_node.nil?
  end

  def insert(data, test_node = root_node)
    if empty?
      self.root_node = Node.new(data)
      return root_node
    elsif test_node.nil?
      return Node.new(data)
    elsif data == test_node.data
      return nil
    elsif data < test_node.data
      test_node.left_child = insert(data, test_node.left_child)
    elsif data > test_node.data
      test_node.right_child = insert(data, test_node.right_child)
    end

    return test_node
  end

  def replace_with_successor(curr)
    curr = curr.right_child
    while !(curr.nil?) && !(curr.left_child.nil?)
      curr = curr.left_child
    end

    curr
  end

  def delete(node, test_node = root_node)
    if empty?
      return nil
    elsif test_node.nil?
      return nil
    elsif node < test_node.data
      test_node.left_child = delete(node, test_node.left_child)
    elsif node > test_node.data
      test_node.right_child = delete(node, test_node.right_child)
    elsif node == test_node.data
      if test_node.left_child.nil? && test_node.right_child.nil?
        return nil
      elsif !(test_node.left_child.nil?) && !(test_node.right_child.nil?)
        successor = replace_with_successor(test_node)
        test_node.data = successor.data
        test_node.right_child = delete(successor.data, test_node.right_child)
      elsif test_node.left_child.nil?
        return test_node.right_child
      elsif test_node.right_child.nil?
        return test_node.left_child
      else
        puts "Else clause"
      end
    end

    test_node
  end

  def find(data, test_node = root_node)
    node = nil

    if empty?
      return nil
    elsif test_node.nil?
      return nil
    elsif data < test_node.data
      node = find(data, test_node.left_child)
    elsif data > test_node.data
      node = find(data, test_node.right_child)
    elsif data == test_node.data
      return test_node
    end

    node
  end

  def traverse(algorithm = :level_order, &block)
    self.send(algorithm, &block)
  end

  def level_order(&block)
    return nil if empty?

    queue = Queue.new
    queue.enqueue(root_node)
    current_node = nil
    level_order_array = []

    until queue.empty?
      current_node = queue.dequeue

      if block_given?
        block.call(current_node)
      else
        level_order_array.push current_node
      end

      queue.enqueue(current_node.left_child) unless current_node.left_child.nil?
      queue.enqueue(current_node.right_child) unless current_node.right_child.nil?
    end

    level_order_array unless block_given?
  end

  def pre_order(node = root_node, pre_order_array = [] ,&block)
    return nil if empty?

    return if node.nil?

    if block_given?
      block.call(node)
    else
      pre_order_array.push(node)
    end

    pre_order(node.left_child, pre_order_array, &block)
    pre_order(node.right_child, pre_order_array, &block)

    pre_order_array unless block_given?
  end

  def in_order(node = root_node, in_order_array = [], &block)
    return nil if empty?

    return if node.nil?

    in_order(node.left_child, in_order_array, &block)

    if block_given?
      block.call(node)
    else
      in_order_array.push(node)
    end

    in_order(node.right_child, in_order_array, &block)

    in_order_array unless block_given?
  end

  def post_order(node = root_node, post_order_array = [], &block)
    return nil if empty?

    return if node.nil?

    post_order(node.left_child, post_order_array, &block)
    post_order(node.right_child, post_order_array, &block)

    if block_given?
      block.call(node)
    else
      post_order_array.push(node)
    end

    post_order_array unless block_given?
  end

  def pretty_print(node = root_node, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end

