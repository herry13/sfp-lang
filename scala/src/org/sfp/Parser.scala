package org.sfp

import scala.util.parsing.combinator.JavaTokenParsers
import scala.io.Source

object Parser extends Parser with App {
  val help = """Usage: scala org.sfp.lang.Parser [option] <sf-file>
where [option] are:
  -ast   generate abstract syntax tree only
  -h     print this help"""
  
  val (opts, rest) = parseArguments
  
  if (rest.length <= 0) Console.println(help)
  else if (opts.isEmpty) parseFile(rest.head)
  else {
    if (opts.head.equals("-h")) Console.println(help)
    else if (opts.head.equals("-ast")) println(parseFile(rest.head))
    else println("unrecognize command")
  }
  
  def parseArguments: (List[String], List[String]) = {
    def parse(args: Array[String], opts: List[String], rest: List[String]): (List[String], List[String]) = {
      if (args.isEmpty) (opts, rest)
      else if (args.head.charAt(0) == '-') parse(args.tail, args.head :: opts, rest)
      else parse(args.tail, opts, args.head :: rest)
    }
    parse(args, List(), List())
  }
}

class Parser extends JavaTokenParsers {
  import Expression._
  
  //protected override val whiteSpace = """(\s|//.*|(?m)/\*(\*(?!/)|[^*])*\*/)+""".r
  protected override val whiteSpace = """([ \t\x0b\r\f]|//.*|(?m)/\*(\*(?!/)|[^*])*\*/)+""".r
  
  def Sfp: Parser[Expression] =
    SpecificationItem ^^ (si => new Expression(sfp, List(si)))
  
  def SpecificationItem: Parser[Expression] =
    ( Assignment ~ SpecificationItem ^^ { case a ~ si => new Expression(specItem, List(a, si)) }
    | Schema ~ SpecificationItem ^^ { case sc ~ si => new Expression(specItem, List(sc, si)) }
    | GlobalConstraint ~ SpecificationItem ^^ { case g ~ si => new Expression(specItem, List(g, si)) }
    | epsilon ^^ (x => new Expression(specItem))
    )
  
  def Body: Parser[Expression] =
    begin ~> Assignment.* <~ end ^^ { aa => new Expression(body, aa) }
  
  def Assignment: Parser[Expression] =
    Reference ~ SFPValue <~ eos.+ ^^ { case r ~ v => new Expression(assignment, List(r, v)) }
  
  def SFPValue: Parser[Expression] =
    ( eq ~> BasicValue ^^ (bv => new Expression(sfpValue, List(bv)))
    | Isa ~ Prototype ^^ { case ss ~ p => new Expression(sfpValue, List(ss, p)) }
    | Type ^^ (t => new Expression(sfpValue, List(t)))
    | Action ^^ (ac => new Expression(sfpValue, List(ac)))
    | LinkReference ^^ (lr => new Expression(sfpValue, List(lr)))
    )
  
  def Isa: Parser[Expression] =
    ( "isa" ~> rep1sep(ident, ",") ^^ (ss => new Expression(isa, ss))
    | epsilon ^^ (x => new Expression(isa))
    )
  
  def Prototype: Parser[Expression] =
    ( "extends" ~> Reference ~ Prototype ^^ {
        case ref ~ p => new Expression(prototype, List(ref, p))
      }
    | Body ~ Prototype ^^ {
        case b ~ p => new Expression(prototype, List(b, p))
      }
    | epsilon ^^ (x => new Expression(prototype))
    )
  
  def BasicValue: Parser[Expression] =
    ( Boolean
    | Number
    | stringLiteral ^^ (s => new Expression(string, List(s)))
    | Null
    | DataReference
    | Vector
    )

  def LinkReference: Parser[Any] =
    Reference ^^ (r => new Expression(linkRef, List(r)))
    
  def DataReference: Parser[Expression] =
    Reference ^^ (r => new Expression(dataRef, List(r)))
 
  def Reference: Parser[Expression] =
    rep1sep(ident, ".") ^^ (r => new Expression(ref, r))
  
  def Schema: Parser[Expression] =
    "schema" ~> ident ~ Super ~ Body <~ eos ^^ { case id ~ ss ~ b =>
      new Expression(schema, List(id, ss, b))
    }
  
  def Super: Parser[Expression] =
    ( "extends" ~> rep1sep(ident, ",") ^^ (ss => new Expression(schemata, ss))
    | epsilon ^^ (x => new Expression(schemata, List()))
    )
  
  def Type: Parser[Expression] =
    ":" ~>
    ( ident
    | TypeList
    | TypeRef
    ) ^^ (t => new Expression(_type, List(t)))
    
  def TypeRef: Parser[Expression] =
    ( "@" ~> ident ^^ (id => new Expression(typeRef, List(id)))
    | "@" ~> TypeList ^^ (tl => new Expression(typeRef, List(tl)))
    )

  def TypeList: Parser[Expression] =
    "[" ~> ident <~ "]" ^^ (id => new Expression(typeList, List(id)))
   
  def GlobalConstraint: Parser[Expression] =
    "global" ~> ??? // TODO
  
  def Action: Parser[Expression] =
    "def" ~> ??? //TODO
  
  def Number: Parser[Expression] =
    floatingPointNumber ^^ (n => new Expression(number, List(n)))

  def Null: Parser[Expression] = "null" ^^ (x => new Expression(_null))
  
  def Vector: Parser[Expression] =
    "[" ~>
    ( rep1sep(BasicValue, ",") ^^ (list => new Expression(vector, list))
    | epsilon ^^ (x => new Expression(vector, List()))
    ) <~ "]"
    
  def Boolean: Parser[Expression] =
    ( "true" ^^ (x => new Expression(boolean, List(true)))
    | "false" ^^ (x => new Expression(boolean, List(false)))
    )  

  //--- constraints ---//
  def Conjunction: Parser[Any] =
    begin ~ ConstraintStatement.* ~ end

  def Disjunction: Parser[Any] =
    ConstraintStatement.*
    
  def ConstraintStatement: Parser[Any] =
    ( Equal
    | NotEqual
    | MemberOfList
    ) <~ eos
  
  def Implication: Parser[Any] = ???
    
  def Negation: Parser[Any] =
    not ~ ConstraintStatement
  
  def Equal: Parser[Any] =
    Reference ~ eq ~ BasicValue
    
  def NotEqual: Parser[Any] =
    Reference ~ neq ~ BasicValue
    
  def MemberOfList: Parser[Any] =
    Reference ~ in ~ Vector
    
  val epsilon: Parser[Any] = ""
    
  val eq: Parser[Any] = "=" // | "is"
  
  val neq: Parser[Any] = "!=" // | "isnt"
  
  val in: Parser[Any] = "in"
  
  val not: Parser[Any] = "not" | "!"
    
  val begin: Parser[Any] = "{" ~ NL.*
    
  val end: Parser[Any] = "}"
    
  val eos: Parser[Any] = ";".r | NL.+ | "\\Z".r
  
  val NL: Parser[Any] = """(\r?\n)+""".r

  def parse(s: String): Any = {
    parseAll(Sfp, s) match {
      case Success(root, _) => root
      case NoSuccess(msg, next) => throw new Exception("at " + next.pos)
    }
  }
    
  /*def parseIncludeFile(filePath: String, ns: Reference, s: Store): Store = {
    parseAll(Body, Source.fromFile(filePath).mkString) match {
      case Success(body, _) => body(ns)(s)
      case NoSuccess(msg, next) => throw new Exception("at " + next.pos)
    }
  }*/
    
  def parseFile(filePath: String) = parse(Source.fromFile(filePath).mkString)
}