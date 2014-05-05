# SFP Compiler in OCaml

This compiler is the implementation of the formal semantic of SFP language in OCaml. The supported features are:

- Basic values (Boolean, Number, String, Null, Vector)
- Object
- Data and Link Reference (_forward link reference_ is not supported)
- Prototype
- Placement (_forward placement_ is not supported)
- Include file `#include "any.sfp"` or `include "any.sfp"`

Not yet supported:

- Schema
- Keywords `this`, `parent`, `root` in reference
- Global constraints
- Actions


## To build

Requirement:

- OCaml (tested on version >= 4.0.1)

Compile:

	make dist

This command will create the compiler executable file `sfp`.


## Usage

- JSON output

		$ ./sfp <sfp-file>

- YAML output
 
		$ ./sfp -yaml <sfp-file>

- XML output

		$ ./sfp -xml <sfp-file>


## License

[BSD License](https://raw.githubusercontent.com/herry13/sfp-lang/master/LICENSE)
