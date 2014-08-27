(** common data structures used by other modules **)

module MapStr = Map.Make(String)

module MapRef = Map.Make ( struct
	type t = string list
	let compare = Pervasives.compare
end )

module SetRef = Set.Make ( struct
	type t = string list
	let compare = Pervasives.compare
end )

module SetInt = Set.Make ( struct
	type t = int
	let compare = Pervasives.compare
end )