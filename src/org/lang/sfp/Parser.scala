package org.lang.sfp

import scala.util.parsing.combinator.JavaTokenParsers
import scala.io.Source
import org.sf.lang.Reference
import org.sf.lang.Store

object Parser extends Parser with App {
  val help = "Usage: scala org.sfp.lang.Parser <sf-file>"
  if (args.length <= 0) Console.println(help)
  else parseFile(args.head)
}

class Parser extends JavaTokenParsers {
  protected override val whiteSpace = """(\s|//.*|(?m)/\*(\*(?!/)|[^*])*\*/)+""".r

  def Sfp: Parser[Any] = ???
  
  def Body: Parser[Any] = ???
  
  def parse(s: String): Any = {
    parseAll(Sfp, s) match {
      case Success(root, _) => root
      case NoSuccess(msg, next) => throw new Exception("at " + next.pos)
    }
  }
    
  def parseIncludeFile(filePath: String, ns: Reference, s: Store): Store = {
    parseAll(Body, Source.fromFile(filePath).mkString) match {
      case Success(body, _) => ???
      case NoSuccess(msg, next) => throw new Exception("at " + next.pos)
    }
  }
    
  def parseFile(filePath: String) = parse(Source.fromFile(filePath).mkString)
}