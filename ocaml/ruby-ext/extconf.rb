EXT_NAME = "test"

OCAML_PACKAGES = %[]

CAML_LIBS = %w[]

CAML_OBJS = %w[]

CAML_FLAGS = ""

CAML_INCLUDES = []

$:.unshift "."

require 'rocaml'

Interface.generate("test") do
	def_module("test") do
		fun "print", UNIT => UNIT
	end
end

require 'rocaml_extconf'
create_makefile(EXT_NAME)
