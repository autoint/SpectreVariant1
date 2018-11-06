/**
 * @name Spectre variant one
 * @description Insert description here...
 * @kind problem
 * @problem.severity warning
 * @precision medium
 * @id cpp/spectre-one-no-taint
 */


import cpp

import semmle.code.cpp.dataflow.DataFlow
import semmle.code.cpp.dataflow.TaintTracking
import semmle.code.cpp.controlflow.Guards
import semmle.code.cpp.valuenumbering.GlobalValueNumbering



import semmle.code.cpp.dataflow.DataFlow::DataFlow

abstract class PointerAddOrArrayExpr extends Expr {
  abstract Expr getOffset();
}


class PointerAddAndDerefAsPAOAE extends PointerAddOrArrayExpr {
  PointerAddExpr pae;
  PointerAddAndDerefAsPAOAE() {
    DataFlow::localFlow(DataFlow::exprNode(pae), DataFlow::exprNode(this.(PointerDereferenceExpr).getOperand())) or
    DataFlow::localFlow(DataFlow::exprNode(pae), DataFlow::exprNode(this.(PointerFieldAccess).getQualifier()))
  }

  

  override Expr getOffset() {
    result = pae.getAnOperand() and
    not result.getType().getUnspecifiedType() instanceof PointerType
  }
}


class ArrayExprAsPAOAE extends PointerAddOrArrayExpr, ArrayExpr {
  override Expr getOffset() {
    result = getArrayOffset()
  }
}


class PointerArithTaint extends TaintTracking::Configuration {
  PointerArithTaint() {
    this = "PointerArithTaint"
  }

  
  override predicate isSource(DataFlow::Node node) {
    node.asExpr() instanceof PointerAddOrArrayExpr and
    node.asExpr().getType().getSize() > 1
  }


  override predicate isSink(DataFlow::Node node) {
    exists(PointerAddOrArrayExpr parent |
      parent.getOffset() = node.asExpr()
    )
  }
}


from PointerAddOrArrayExpr outer, PointerAddOrArrayExpr inner, GuardCondition gc, GVN gvn, PointerArithTaint pat
where pat.hasFlow(DataFlow::exprNode(inner), DataFlow::exprNode(outer.getOffset()))
  // avoid character class lookup tables
  and inner.getType().getSize() > 1
  // accesses are guarded
  and gvn.getAnExpr() = inner.getOffset()
  // local guard condition on the first memory access
  and gc.controls(inner.getBasicBlock(), _)
  and gc.comparesLt(gvn.getAnExpr(), _, _, _, _)
select outer, "Potential spectre issue here ($@) bounded by $@", inner, inner.toString(),gc, gc.toString()
