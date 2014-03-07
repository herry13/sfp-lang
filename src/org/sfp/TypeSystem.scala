package org.sfp

import scala.util.parsing.combinator.JavaTokenParsers
import org.sf.lang.Reference
import org.sf.lang.LinkReference

object TypeSystem {
  type Type = Set[String]
  val bool = "bool"
  val num = "num"
  val str = "str"
  val obj = "obj"
  val ref = "ref"
  val list = "list"
  val schema = "schema"
  val constraint = "constraint"
  val action = "action"
}

class TypeSystem extends JavaTokenParsers {
  import TypeSystem._
  
  protected override val whiteSpace = """(\s|//.*|(?m)/\*(\*(?!/)|[^*])*\*/)+""".r
  
  // TODO
  def Sfp: Parser[Any] =
    SpecificationItem
  
  // TODO
  def SpecificationItem: Parser[Any] =
    ( Assignment ~ SpecificationItem
    | Schema ~ SpecificationItem
    | GlobalConstraint ~ SpecificationItem
    | epsilon
    )
  
  // TODO
  def Body: Parser[Any] =
    begin ~>
    ( Assignment ~ Body
    | epsilon
    ) <~ end
  
  // TODO
  def Assignment: Parser[Any] =
    Reference ~ SFPValue <~ eos
  
  // TODO
  def SFPValue: Parser[Any] =
    ( eq ~> BasicValue
    | LinkReference
    | Isa ~ Prototype
    | Type
    | Action
    )
  
  // TODO
  def Isa: Parser[Any] =
    ( "isa" ~> rep1sep(ident, ",")
    | epsilon
    )
    
  // TODO
  def Prototype: Parser[Any] =
    ( "extends" ~> Reference ~ Prototype
    | Body ~ Prototype
    | epsilon
    )
  
  def BasicValue: Parser[Type] =
    ( Boolean
    | Number
    | stringLiteral ^^ (x => Set(str))
    | DataReference ^^ (dr => ???)
    | Vector
    | Null
    )

  def LinkReference: Parser[LinkReference] =
    Reference ^^ (r => new LinkReference(r))
    
  def DataReference: Parser[org.sf.lang.Reference] =
    "DATA" ~> Reference
 
  def Reference: Parser[org.sf.lang.Reference] =
    rep1sep(ident, ".") ^^ (r => org.sf.lang.Reference(r))
  
  // TODO
  def Schema: Parser[Any] =
    "schema" ~> ident <~ Super ~ Body
  
  // TODO
  def Super: Parser[Any] =
    ( "extends" ~> rep1sep(ident, ",")
    | epsilon
    )
    
  def Type: Parser[Type] =
    ":" ~>
    ( ident ^^ (id => Set(id))
    | TypeList
    | TypeRef
    )
    
  def TypeRef: Parser[Type] =
    ( "@" ~> ident ^^ (id => Set(ref, id))
    | "@" ~> TypeList ^^ (tl => tl + ref)
    )
    
  def TypeList: Parser[Type] =
    "[" ~> ident <~ "]" ^^ (id => Set(list, id))
   
  def GlobalConstraint: Parser[Type] =
    "global" ~> ???
  
  def Action: Parser[Type] =
    "def" ~> ???
  
  protected val intRegex = """\-?[0-9]+(?!\.)""".r

  def Number: Parser[Type] =
    floatingPointNumber ^^ (n => Set(num))

  def Null: Parser[Type] = "NULL" ^^ (x => ???) // TODO
    
  def Vector: Parser[Type] =
    "[" ~>
    ( rep1sep(BasicValue, ",") ^^ (list => ???) // TODO
    | epsilon ^^ (x => List()) ^^ (x => ???)  // TODO
    ) <~ "]"
    
  def Boolean: Parser[Type] =
    ( "true" ^^ (x => Set(bool))
    | "false" ^^ (x => Set(bool))
    )  
    
  val epsilon: Parser[Any] = ""
    
  val eq: Parser[Any] = "=" | "is"
  
  val neq: Parser[Any] = "!=" | "isnt"
  
  val in: Parser[Any] = "in"
  
  val begin: Parser[Any] = "{"
    
  val end: Parser[Any] = "}"
    
  val eos: Parser[Any] = ";" | NL
  
  val NL: Parser[Any] = "\n" ~ "\r".?
}