package org.sfp

object Expression {
  val sfp = "sfp"
  val specItem = "specItem"
  val body = "body"
  val assignment = "assignment"
  val sfpValue = "sfpValue"
  val isa = "isa"
  val prototype = "prototype"
  val linkRef = "linkRef"
  val dataRef = "dataRef"
  val ref = "ref"
  val schema = "schema"
  val schemata = "schemata"
  val _type = "type"
  val typeRef = "typeRef"
  val typeList = "typeList"
  val number = "number"
  val boolean = "boolean"  
  val string = "string"
  val vector = "vector"
  val _null = "null"
}

class Expression(val label: String, val params: List[Any] = List()) {
  override def toString = 
    params.foldLeft[String]("(" + label)(
      (s: String, item: Any) => s + " " + item.toString
    ) + ")"
    
  def find(label: String): Expression = {
    def innerFind(params: List[Any]): Expression = {
      if (params.isEmpty) null
      else if (params.head.isInstanceOf[Expression] && params.head.asInstanceOf[Expression].label.equals(label))
        params.head.asInstanceOf[Expression]
      else innerFind(params.tail)
    }
    innerFind(params)
  }
  
  def addParam(p: Any) = new Expression(label, p :: params)
  
  def addParam(path: List[String], p: Any): Expression = {
    def addChildParam(path: List[String], p: Any, children: List[Any], acc: List[Any]): List[Any] = {
      if (children.isEmpty) throw new Exception("invalid path: " + path)
      else if (children.head.isInstanceOf[Expression] && children.head.asInstanceOf[Expression].label.equals(path.head))
        children.tail :: children.head.asInstanceOf[Expression].addParam(p) :: acc
      else addChildParam(path, p, children.tail, children.head :: acc)
    }
    
    if (path.head.equals(label)) {
      if (path.tail.isEmpty) new Expression(label, p :: params)
      else new Expression(label, addChildParam(path.tail, p, params, List()))
    }
    else throw new Exception("invalid path: " + path)
  }
}
