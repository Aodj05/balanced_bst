# frozen_string_literal: true

class Node
    # attr for data stored and, left child, right child
    attr_reader :value
    attr_accessor :left, :right

    def initialize(value)
        @value = value
        @left = nil
        @right = nil
    end
    # bonus Comparable module; compare nodes using data
  module Comparable
    #value == value
        
  end

end

class Tree
    # root attr
    attr_accessor :root, :value
    # accepts array when initialized
  def initialize(arr)
        @value = arr.sort.uniq
        @root = build_tree(value)
  end

    # root attr uses return value
  def build_tree(arr)
        #take array, turn into bt with node objs
        return nil if arr.empty?

        mid = (arr.size - 1)/2
        current_node = Node.new(arr[mid])

        current_node.left = build_tree(arr[0...mid])
        current_node.right = build_tree(arr[(mid+1)..-1])
      
      current_node
  end

    # insert and delete values
  def insert(current_node = root, value)
    # compare nodes,decide if left or right 
    return nil if value == current_node.value

    if value < current_node.value
        current_node.left.nil? ? current_node.left = Node.new(value) : insert(current_node.left, value)
    else
        current_node.right.nil? ? current_node.right = Node.new(value) : insert(current_node.right, value)
    end
  end

  def delete(value, current_node = root)
        return current_node if current_node.nil?

        if value < current_node.value
          current_node.left = delete(value, current_node.left)
        elsif value > current_node.value
          current_node.right = delete(value, current_node.right)
        else
          return current_node.right if current_node.left.nil?
          return current_node.left if current_node.right.nil?
        end
        current_node
  end
    
    # find a given value and return node
  def find(value, current_node = root)
    return current_node if current_node.nil? || current_node.value == value
    value < current_node.value ? find(value, current_node.left) : find(value, current_node.right)

  end

    # return array of values, bfs traversal, iteration and recursion
  def level_order(current_node = root, queue = [])
    print "#{current_node.value} "
    queue << current_node.left unless current_node.left.nil?
    queue << current_node.right unless current_node.right.nil?
    return if queue.empty?

    level_order(queue.shift, queue)
  end

    # inorder, return array of values in ldr dfs traversal
  def inorder(current_node = root)
        return if current_node.nil?
        inorder(current_node.left)
        print "#{current_node.value} "
        inorder(current_node.right)
  end

    #preorder, return array of values in dlr dfs traversal
  def preorder(current_node = root)
    return if current_node.nil?
    print "#{current_node.value} "
    inorder(current_node.left)
    inorder(current_node.right)
  end

    #postorder, return array of values in lrd dfs traversal
  def postorder(current_node = root)
    return if current_node.nil?
    inorder(current_node.left)
    inorder(current_node.right)
    print "#{current_node.value} "
  end

    # return node height
  def height(current_node = root)
    unless current_node.nil? || current_node == root
      current_node = (current_node.instance_of?(Node) ? find(current_node.value) : find(current_node))
    end

    return -1 if current_node.nil?

    [height(current_node.left), height(current_node.right)].max + 1
  end

    # return node depth
  def depth(current_node)
        return 0 if current_node.nil?

        leftDepth = depth(current_node.left)
        return -1 if leftDepth == -1

        rightDepth = depth(current_node.right)
        return -1 if rightDepth == -1

        diff = leftDepth - rightDepth
        if diff.abs > 1
          -1
        else
          [leftDepth, rightDepth].max + 1
        end
  end

    # check if tree is balanced
  def balanced?(current_node = root)
        depth(current_node)  == -1 ? false : true
  end

    #rebalanced unbalanced tree
  def rebalance
    self.value = ordered_arr
    self.root = build_tree(value)
  end

  def ordered_arr(current_node = root, arr = [])
    unless current_node.nil?
      ordered_arr(current_node.left, arr)
      arr << current_node.value
      ordered_arr(current_node.right, arr)
    end
    arr
  end

  def pretty_print(current_node = root, prefix = '', is_left = true)
    pretty_print(current_node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if current_node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{current_node.value}"
    pretty_print(current_node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if current_node.left
  end
end

arr = Array.new(15) { rand(1..100) }
tree = Tree.new(arr)

tree.balanced?

puts "Level order: "
puts tree.level_order

puts "Preorder: "
puts tree.preorder

puts "Inorder: "
puts tree.inorder

puts "Postorder: "
puts tree.postorder

5.times do
  a = rand(100..200)
  tree.insert(a)
  puts "#{a} was inserted"
end

tree.pretty_print

puts tree.balanced?

tree.rebalance

tree.pretty_print

puts tree.balanced?

puts "Level order: "
puts tree.level_order

puts "Preorder: "
puts tree.preorder

puts "Inorder: "
puts tree.inorder

puts "Postorder: "
puts tree.postorder
