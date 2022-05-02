# frozen_string_literal: true

require_relative './node'

# Tree class contains the functionality to build a balanced binary search tree
class Tree
  attr_reader :root

  def initialize(array)
    @root = build_tree(array.sort.uniq, 0, array.sort.uniq.length - 1)
  end

  def build_tree(array, beg, last)
    return nil if beg > last

    mid = (beg + last) / 2
    root = Node.new(array[mid])

    root.left = build_tree(array, beg, mid - 1)
    root.right = build_tree(array, mid + 1, last)

    root
  end

  def insert(root, value)
    if root.nil?
      root = Node.new(value)
      return root
    end

    if value < root.data
      root.left = insert(root.left, value)
    elsif value > root.data
      root.right = insert(root.right, value)
    end

    root
  end

  # Method provided by student of TOP
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

tree = Tree.new([9, 8, 9, 1, 7, 3, 1, 9, 5, 2, 4])
tree.insert(tree.root, 6)
tree.pretty_print
tree.insert(tree.root, 4)
