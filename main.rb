require_relative "lib/bst"
array = (Array.new(15) { rand(1..100) })

puts "Create Balanced Binary Search Tree with: #{array}"

puts "---------------------------------------------------------------"

tree = Tree.new(array)

tree.pretty_print

puts "---------------------------------------------------------------"

puts "Is tree balanced: #{tree.balanced?}"

puts "---------------------------------------------------------------"

traversal_algorithms = %i[level_order pre_order in_order post_order]

traversal_algorithms.each do |algorithm|
  print "#{algorithm} traversal: ".ljust(25)
  tree.traverse(algorithm) { |node| print "#{node.data} " }
  puts ""
end

puts "---------------------------------------------------------------"

array_2 = (Array.new(6) { rand(110..150) })

puts "Add to tree with: #{array_2}"

array_2.each { |ele| tree.insert ele }

puts "---------------------------------------------------------------"

tree.pretty_print

puts "---------------------------------------------------------------"

puts "Is tree balanced: #{tree.balanced?}"

puts "---------------------------------------------------------------"

puts "Rebalancing tree...\n\n"

tree.rebalance

tree.pretty_print

puts "---------------------------------------------------------------"

puts "Is tree balanced: #{tree.balanced?}"

puts "---------------------------------------------------------------"

traversal_algorithms = %i[level_order pre_order in_order post_order]

traversal_algorithms.each do |algorithm|
  print "#{algorithm} traversal: ".ljust(25)
  tree.traverse(algorithm) { |node| print "#{node.data} " }
  puts ""
end
