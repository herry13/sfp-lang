#!/usr/bin/env ruby

dir = File.expand_path(File.dirname(__FILE__))
require "#{dir}/../lib/sfp"
require 'yaml'

child = {'a' => 1}
parent = {'x' => child, 'b' => 2}
child['_parent'] = parent
puts parent.at?('x.a')
puts child.at?('this.a')
puts child.at?('this.parent.b')
puts child.at?('this.parent.c')
puts child.at?('this.parent').ref
puts child.at?('root.b')
