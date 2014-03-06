package org.lang.sfp

import scala.util.parsing.combinator.JavaTokenParsers
import org.sf.lang.Store
import org.sf.lang.Reference

class ValueSystem extends JavaTokenParsers {
  protected override val whiteSpace = """(\s|//.*|(?m)/\*(\*(?!/)|[^*])*\*/)+""".r
  
  def Sfp: Parser[Store] =
    SpecificationItem ^^ (si =>
      ((v: Any) =>
        if (v.isInstanceOf[Store]) v.asInstanceOf[Store]
        else throw new Exception("missing main object")
      )(si(org.sf.lang.Reference.Empty)(org.sf.lang.Store.Empty).accept(org.sf.lang.Store.replaceLink).find(new Reference("main")))
    )
  
  def SpecificationItem: Parser[Reference => Store => Store] =
    ( Assignment ~ SpecificationItem ^^ { case a ~ si => (ns: Reference) => (s: Store) => si(ns)(a(ns)(s)) }
    | Schema ~ SpecificationItem ^^ { case sc ~ si => (ns: Reference) => (s: Store) => si(ns)(sc(s)) }
    | GlobalConstraint ~ SpecificationItem ^^ { case g ~ si => (ns: Reference) => (s: Store) => si(ns)(g(s)) }
    | epsilon ^^ (x => (ns: Reference) => (s: Store) => s)
    )
  
  def Body: Parser[Reference => Store => Store] =
    begin ~>
    ( Assignment ~ Body ^^ { case a ~ b => (ns: Reference) => (s: Store) => b(ns)(a(ns)(s)) }
    | epsilon ^^ (x => (ns: Reference) => (s: Store) => s)
    ) <~ end
  
  def Assignment: Parser[Reference => Store => Store] =
    Reference ~ SFPValue <~ eos ^^ {
      case r ~ v =>
        (ns: Reference) => (s: Store) =>
          if (r.length == 1) v(ns)(ns ++ r)(s)
          else
            ((l: (Reference, Any)) =>
              if (l._2.isInstanceOf[Store]) v(ns)(l._1 ++ r)(s)
              else throw new Exception("prefix of " + r + " is not a store")
            )(s.resolve(ns, r.prefix))
    }
  
  def SFPValue: Parser[Reference => Reference => Store => Store] =
    ( eq ~> BasicValue ^^ (bv =>
        (ns: Reference) => (r: Reference) => (s: Store) => s.bind(r, bv)
      )
    | LinkReference ^^ (lr =>
        (ns: Reference) => (r: Reference) => (s: Store) => s.bind(r, lr)
      )
    | Isa ~ Prototype ^^ { case ss ~ p =>
        (ns: Reference) => (r: Reference) => (s: Store) =>
          p(ns)(r)(ss(r)(s.bind(r, org.sf.lang.Store.Empty)))
      }
    | Type ^^ (t =>
        (ns: Reference) => (r: Reference) => (s: Store) => s.bind(r, t)
      )
    | Action ^^ (ac =>
        (ns: Reference) => (r: Reference) => (s: Store) => s.bind(r, ac)
      )
    )
  
  def Isa: Parser[Reference => Store => Store] =
    ( "isa" ~> rep1sep(ident, ",") ^^ (ss => schemata(ss)
      )
    | epsilon ^^ (x => (r: Reference) => (s: Store) => s)
    )
    
  def Prototype: Parser[Reference => Reference => Store => Store] =
    ( "extends" ~> Reference ~ Prototype ^^ {
        case ref ~ p =>
          (ns: Reference) => (r: Reference) => (s: Store) =>
            p(ns)(r)(s.inherit(ns, ref, r))
      }
    | Body ~ Prototype ^^ {
        case b ~ p =>
          (ns: Reference) => (r: Reference) => (s: Store) =>
            p(ns)(r)(b(r)(s))
      }
    | epsilon ^^ (x =>
        (ns: Reference) => (r: Reference) => (s: Store) => s
      )
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
 
  def Reference: Parser[Reference] =
    rep1sep(ident, ".") ^^ (r => org.sf.lang.Reference(r))
  
  def Schema: Parser[Store => Store] =
    "schema" ~> ident ~ Super ~ Body ^^ { case id ~ ss ~ b =>
      (s: Store) =>
        ((r: Reference) =>
          b(r)(ss(r)(s.bind(r, org.sf.lang.Store.Empty)))
        )(new Reference(id))
    }
  
  def Super: Parser[Reference => Store => Store] =
    ( "extends" ~> rep1sep(ident, ",") ^^ (ss => schemata(ss))
    | epsilon ^^ (x => (r: Reference) => (s: Store) => s)
    )
  
  private def schemata(ss: List[String]): Reference => Store => Store =
    (r: Reference) => (s: Store) =>
      ss.foldRight[Store](s)((id: String, s1: Store) =>
        s1.inherit(org.sf.lang.Reference.Empty, new Reference(id), r)
      )
    
  def Type: Parser[Any] =
    ":" ~>
    ( ident ^^ (id =>
        if (id.equals(TypeSystem.bool)) false
        else if (id.equals(TypeSystem.num)) 0
        else if (id.equals(TypeSystem.str)) ""
        else org.sf.lang.Store.Empty
      )
    | TypeList
    | TypeRef
    )
    
  def TypeRef: Parser[Any] =
    ( "@" ~> ident
    | "@" ~> TypeList
    ) ^^ (x => null)
    
  def TypeList: Parser[Any] =
    "[" ~> ident <~ "]" ^^ (x => List())
   
  def GlobalConstraint: Parser[Store => Store] =
    "global" ~> ??? //TODO
  
  def Action: Parser[Any] =
    "def" ~> ??? //TODO
  
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