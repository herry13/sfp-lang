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

A short introduction of SFP language can be read in [here](https://github.com/herry13/sfp-lang/wiki).

This implementation is an SFP compiler based on its formal semantics. The current version supports the following features:
- Static type system
	- Basic types: `bool`, `int`, `float`, `str`, `*` (reference-type)
	- Static schema
- Data and Link references (including _forward_ references)
	- Reference keywords: `root`, `parent`, and `this`
- Special purpose values
	- `null`: empty reference
	- `TBD` (To-Be-Defined): in planning, this has **any value** semantics for loose specification
	- `unknown`
	- `undefined`
- Object prototypes
- Global constraint with various operators
	- Equality & Inequality: `=`, `!=`
	- Logic: `not`, `if-then`, `{}` (conjunction), `()` (disjunction)
	- Membership: `in`
	- Numeric: `<`, `<=`, `>`, `>=`
- Actions
- File inclusion
- Finite Domain Representation generator for planning
- Partial-order plan generator

The language is being developed to support other features. Click [here](https://github.com/herry13/sfp-lang/issues?q=is%3Aopen+is%3Aissue+label%3A%22new+feature%22) for more details.


To build
--------
Requirement:
- OCaml >= 3.12.1
- Yojson >= 1.1.8 (it can be installed via OPAM: `opam install yojson`)

Compile:

	cd ocaml
	make dist

The above command will generate file `csfp` in directory `ocaml`. In default, the codes are compiled into OCaml bytecodes which requires OCaml runtime for running. However, we can compile the codes into native bytecodes by setting variable `NATIVE=1` in `Makefile`. This change will generate the same file i.e. `sfp`, but this is a native executable file which can be invoked without any OCaml runtime.


Usage
-----
The simplest command to use `sfp` is

	$ ./sfp spec.sfp

This will parse the specification in file `spec.sfp` and generate the final result in JSON. In addition, there are several options that can be used:
- `-x`  syntax checking

		sfp -x spec.sfp

- `-t`  type checking

		sfp -t spec.sfp

- `-m`  return `root` object instead of `main`

		sfp -m spec.sfp

- `-g`  evaluate global constraints on the specification

		sfp -g spec.sfp

- `-f`  generate Finite Domain Representation (FDR)

		sfp -f initial.sfp goal.sfp

- `-p`  solves an SFP planning problem

		sfp -p initial.sfp goal.sfp


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


**initial.sfp**:

	// file: initial.sfp
	include "model.sfp";
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
	include "model.sfp";
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

	sfp -p initial.sfp goal.sfp

Note that environment variable `FD_PREPROCESS` and `FD_SEARCH` must be set before invoking the command so that `sfp` can invoke the search engine.


License
-------
[Apache License version 2.0](LICENSE)
