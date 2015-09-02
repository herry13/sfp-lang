SFP Language Parser
===================
- Author: Herry (herry13@gmail.com)
- [BSD License](../master/LICENSE)

[![Build Status](https://travis-ci.org/herry13/sfp-ruby.png?branch=master)](https://travis-ci.org/herry13/sfp-ruby)
[![Gem Version](https://badge.fury.io/rb/sfp.png)](https://badge.fury.io/rb/sfp)

A Ruby script and library for parsing [SFP language](https://github.com/herry13/nuri/wiki/SFP-language), a declarative language to specify a planning task.

Click [here](https://github.com/herry13/nuri/wiki/SFP-language), for more details about SFP language.

This is a spin-out project from [Nuri](https://github.com/herry13/nuri).

**Note: Since version 0.3.0, the planner has been moved to another project: [sfplanner](https://github.com/herry13/sfplanner)**.


To install
----------
- Ruby 1.8.7

		$ gem install json
		$ gem install sfp
		
- Ruby 1.9.x and 2.x

		$ gem install sfp


Requirements
------------
- Ruby (>= 1.8.7)
- Ruby Gems
	- antlr3
	- json (using Ruby 1.8.7 only)


To use as a command line
------------------------
- parse a SFP file, and then print the output in JSON

		$ sfp <sfp-file>

To solve a planning task, you can use [sfplanner](https://github.com/herry13/sfplanner)/


To use as Ruby library
----------------------
- include file **main.sfp** in your codes:

	```ruby
	require 'sfp'
	```
		
- to parse an SFP file: create a Sfp::Parser object, and then pass the content of the file:

	```ruby
	# Determine the home directory of your SFP file.
	home_dir = File.expand_path(File.dirname("my_file.sfp"))

	# Create Sfp::Parser object
	parser = Sfp::Parser.new({:home_dir => "./"})

	# Parse the file.
	parser.parse(File.read("my_file.sfp"))

	# Get the result in Hash data structure
	result = parser.root
	```


Example of Planning Task
------------------------
- Create file **types.sfp** to hold required schemas:

	```javascript
	schema Service {
		running is false
		procedure start {
			conditions {
				this.running is false
			}
			effects {
				this.running is true
			}
		}
		procedure stop {
			conditions {
				this.running is true
			}
			effects {
				this.running is false
			}
		}
	}
	schema Client {
		refer isref Service
		procedure redirect(s isref Service) {
			conditions { }
			effects {
				this.refer is s
			}
		}
	}
	```
	
  In this file, we have two schemas that model our domain. First, schema
  **Service** with an attribute **running**, procedure **start** that
  changes **running**'s value from **false** to **true**, and procedure
  **stop** that changes **running**'s value from **true** to **false**.
  
  We also have schema **Client** with an attribute **refer**, which is
  a reference to an instance of **Service**. There is a procedure
  **redirect** that changes the value of **refer** with any instance if
  **Service**.

- Create file **task.sfp** to hold the task:

	```javascript
	include "types.sfp"
		
	initial state {
		a isa Service {
			running is true
		}

		b isa Service // with "running" is false

		pc isa Client {
			refer is a
		}
	}

	goal constraint {
		pc.refer is b
		a.running is false
	}

	global constraint {
		pc.refer.running is true
	}
	```
	
  In this file, we specify a task where in the initial state of our domain,
  we have two services **a** and **b**, and a client **pc**. **a** is
  running, **b** is stopped, and **pc** is referring to **a**. We want to
  generate a workflow that achieves goal: **pc** is referring to **b**
  and **a** is stopped, and preserves global constraint: **pc** is always
  referring to a running service.

- To generate the workflow, we invoke **sfplanner** (see [sfplanner](https://github.com/herry13/sfplanner))
  command with argument the path of the task file:

		$ sfplanner task.sfp

  Which will generate a workflow in JSON

	```javascript
	{
	  "type": "sequential",
	  "workflow": [
	    {
	      "name": "$.b.start",
	      "parameters": {
	      },
	      "condition": {
	        "$.b.running": false
	      },
	      "effect": {
	        "$.b.running": true
	      }
	    },
	    {
	      "name": "$.pc.redirect",
	      "parameters": {
	        "$.s": "$.b"
	      },
	      "condition": {
	      },
	      "effect": {
	        "$.pc.refer": "$.b"
	      }
	    },
	    {
	      "name": "$.a.stop",
	      "parameters": {
	      },
	      "condition": {
	        "$.a.running": true
	      },
	      "effect": {
	        "$.a.running": false
	      }
	    }
	  ],
	  "version": "1",
	  "total": 3
	}
	```

  This workflow is sequential that has 3 procedures. If you executes
  the workflow in given order, it will achieves the goal state as well
  as perserves the global constraints during the execution.
