SFP Language Compiler
=====================

[![Build Status](https://travis-ci.org/herry13/sfp-lang.svg?branch=master)](https://travis-ci.org/herry13/sfp-lang)

SFP language serves two objectives:

1. To define a declarative specification of configuration state of a system.
2. To model a reconfiguration task which consists of:
	- a current state (init)
	- a desired state (goal)
	- a set of actions, each of which has parameters, cost, preconditions (condition before applying the action), and effects (condition after applying the action)
	- a set of global constraints (condition that must be satisfied at intermediate and final states)

SFP was developed based on [SmartFrog](http://smartfrog.org) language and [PDDL](http://en.wikipedia.org/wiki/Planning_Domain_Definition_Language). The syntax resembles SmartFrog language with new notations for describing actions and global constraints (using PDDL-style).

This implementation is an SFP compiler based on its formal semantics. The current version supports the following features:
- Static type system
- Static schema
- Basic values: boolean, number, string, null, and vector
- Data and link references (including _forward_ references)
- `TBD` (to be defined) value: in planning, this has **any value** semantics (loose specification)
- Object prototypes
- Actions
- Global constraints
- File inclusion
- Keywords: `root`, `parent`, and `this`
- Finite Domain Representation ([FDR](http://www.fast-downward.org/TranslatorOutputFormat)) generator for planning
- Partial-order plan generator
- Numeric comparison operator: `<`, `<=`, `>`, `>=`

The language is being developed to support other features. Click [here](https://github.com/herry13/sfp-lang/issues?q=is%3Aopen+is%3Aissue+label%3A%22new+feature%22) for more details.


To build
--------
Requirement:
- OCaml >= 3.12.1
- Yojson >= 1.1.8 (it can be installed via OPAM: `opam install yojson`)

Compile:

	cd ocaml
	make dist

The above command will generate file `csfp` in directory `ocaml`. In default, the codes are compiled into OCaml bytecodes which requires OCaml runtime for running. However, we can compile the codes into native bytecodes by setting variable `NATIVE=1` in `Makefile`. This change will generate the same file i.e. `csfp`, but this is a native executable file which can be invoked without any OCaml runtime.


Usage
-----
The simplest command to use `csfp` is

	$ ./csfp spec.sfp

This will parse the specification in file `spec.sfp` and generate the final result in JSON. In addition, there are several options that can be used:
- `./csfp -ast spec.sfp` : print an abstract syntax tree of the specification, which is very useful to quickly find any syntax error.
- `./csfp -type spec.sfp` : evaluate the types of every element and check any type-error on the specification.
- `./csfp -json spec.sfp` : evaluate every element and generate the final result in JSON.
- `./csfp -yaml spec.sfp` : evaluate every element and generate the final result in YAML.
- `./csfp -fs spec.sfp` : print variables and their values in a flat-structure.
- `./csfp -init init.sfp -goal goal.sfp -fdr` : given an initial state in `init.sfp` and a goal state in `goal.sfp`, generate and print a Finite Domain Representation of this configuration task -- the output can be given to the FastDownward search engine to find a solution plan.
- `./csfp -init init.sfp -goal goal.sfp -fd` :  given an initial state in `init.sfp` and a goal state in `goal.sfp`, generate and print the solution plan of this configuration task. **Note**: environment variable `FD_PREPROCESSOR` and `FD_SEARCH` must be set with the path of the FastDownward preprocessor and search engine respectively.


Example
-------

The following files specify the model, the initial, and the goal state of a configuration task.

**model.sfp**:

	// file : model.sfp
	schema Machine {
	  dns = "ns.foo";
	}
	schema Client extends Machine {
	  refer: *Service = null;
	  def redirect(s: Service) {
	    condition { }
	    effect {
	      this.refer = s;
	    }
	  }
	}
	schema Service {
	  running = true;
	  port = 80;
	  def start {
	    condition {
	      this.running = false;
	    }
	    effect {
	      this.running = true;
	    }
	  }
	  def stop {
	    condition {
	      this.running = true;
	    }
	    effect {
	      this.running = false;
	    }
	  }
	}


**init.sfp**:

	// file: init.sfp
	include "system1-model.sfp";
	main {
	  s1 isa Machine {
	    web isa Service { }
	  }
	  s2 extends s1, {
	    web.running = false;
	  }
	  pc1 isa Client {
	    refer = s1.web;
	  }
	  pc2 pc1;
	}


**goal.sfp**:

	// file: goal.sfp
	include "system1-model.sfp";
	main {
	  s1 isa Machine {
	    web isa Service {
	      running = false;
	    }
	  }
	  s2 extends s1, {
	    web.running = true;
	  }
	  pc1 isa Client {
	    refer = s2.web;
	  }
	  pc2 pc1;
	  global {
	    pc1.refer.running = true;
	    pc2.refer.running = true;
	  }
	}


To generate the plan for the above configuration task, invoke the following command

	./csfp -init init.sfp -goal goal.sfp fd

Note that environment variable `FD_PREPROCESS` and `FD_SEARCH` must be set before invoking the command.


License
-------
[Apache License version 2.0](https://raw.githubusercontent.com/herry13/smartfrog-lang/sfp/LICENSE)
