package org.lang.sfp

import scala.util.parsing.combinator.JavaTokenParsers

class ValueSystem extends JavaTokenParsers {
  protected override val whiteSpace = """(\s|//.*|(?m)/\*(\*(?!/)|[^*])*\*/)+""".r
  
  def Sfp: Parser[Any] =
    SpecificationItem
  
  def SpecificationItem: Parser[Any] =
    ( Assignment ~ SpecificationItem
    | Schema ~ SpecificationItem
    | GlobalConstraint ~ SpecificationItem
    | epsilon
    )
  
  def Body: Parser[Any] =
    begin ~>
    ( Assignment ~ Body
    | epsilon
    ) <~ end
  
  def Assignment: Parser[Any] =
    Reference ~ SFPValue <~ eos
  
  def SFPValue: Parser[Any] =
    ( eq ~> BasicValue
    | LinkReference
    | Isa ~ Prototype
    | Type
    | Action
    )
  
  def Isa: Parser[Any] =
    ( "isa" ~> rep1sep(ident, ",")
    | epsilon
    )
    
  def Prototype: Parser[Any] =
    ( "extends" ~> Reference ~ Prototype
    | Body ~ Prototype
    | epsilon
    )
  
  def BasicValue: Parser[Any] =
    ( Boolean
    | Number
    | stringLiteral
    | DataReference
    | Vector
    | Null
    )

  def LinkReference: Parser[Any] =
    Reference
    
  def DataReference: Parser[Any] =
    "DATA" ~> Reference
 
  def Reference: Parser[Any] =
    rep1sep(ident, ".") ^^ (r => ???)
  
  def Schema: Parser[Any] =
    "schema" ~> ident <~ Super ~ Body
  
  def Super: Parser[Any] =
    ( "extends" ~> rep1sep(ident, ",")
    | epsilon
    )
    
  def Type: Parser[Any] =
    ":" ~>
    ( ident
    | TypeList
    | TypeRef
    )
    
  def TypeRef: Parser[Any] =
    ( "@" ~> ident
    | "@" ~> TypeList
    )
    
  def TypeList: Parser[Any] =
    "[" ~> ident <~ "]"
   
  def GlobalConstraint: Parser[Any] =
    "global" ~> ???
  
  def Action: Parser[Any] =
    "def" ~> ???
  
  protected val intRegex = """\-?[0-9]+(?!\.)""".r

  def Number: Parser[Any] =
    floatingPointNumber ^^ (n =>
      if (intRegex.findFirstIn(n).get != n) n.toDouble
      else n.toInt
    )

  def Null: Parser[Any] = "NULL" ^^ (x => null)
    
  def Vector: Parser[List[Any]] =
    "[" ~>
    ( rep1sep(BasicValue, ",") ^^ (list => list)
    | epsilon ^^ (x => List())
    ) <~ "]"
    
  def Boolean: Parser[Boolean] =
    ( "true" ^^ (x => true)
    | "false" ^^ (x => false)
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