import org.sfp._

object test {
  println("Welcome to the Scala worksheet")       //> Welcome to the Scala worksheet
  
  
  //val sfp1 = "a is 1;"
  //val sfp1 = "a { b = true; };"
  val sfp1 = "schema a { }"                       //> sfp1  : String = schema a { }
  val parser = new Parser                         //> parser  : org.sfp.Parser = org.sfp.Parser@55da4057
  parser.parse(sfp1)                              //> res0: Any = (sfp (specItem (schema a (schemata) (body)) (specItem)))
}