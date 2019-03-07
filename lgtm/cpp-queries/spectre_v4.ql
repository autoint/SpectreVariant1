/**
 * @name Spectre variant four
 * @description Insert description here...
 * @kind problem
 * @problem.severity warning
 * @precision medium
 * @id cpp/spectre-four-no-taint
 */

 

import cpp
import semmle.code.cpp.ir.implementation.aliased_ssa.IR
import semmle.code.cpp.ir.ValueNumbering

/**
 * Holds if data flows from `nodeFrom` to `nodeTo` in exactly one local
 * (intra-procedural) step.
 */
predicate localFlowStep(Instruction nodeFrom, Instruction nodeTo) {
  nodeTo.(CopyInstruction).getSourceValue() = nodeFrom or
  nodeTo.(PhiInstruction).getAnOperand().getDefinitionInstruction() = nodeFrom
}

/**
 * Holds if data flows from `source` to `sink` in zero or more local
 * (intra-procedural) steps.
 */
predicate localFlow(Instruction source, Instruction sink) {
  localFlowStep*(source, sink)
}

/**
 * Holds if taint propagates from `nodeFrom` to `nodeTo` in exactly one local
 * (intra-procedural) step.
 */
predicate localTaintStep(Instruction nodeFrom, Instruction nodeTo) {
  // Taint can flow using ordinary data flow.
  localFlowStep(nodeFrom, nodeTo)
  or
  // Taint can flow through expressions that alter the value but preserve
  // more than one bit of it _or_ expressions that follow data through
  // pointer indirections.
  not nodeTo instanceof CompareInstruction and
  not nodeTo instanceof CallInstruction and
  not (
    nodeTo.(StoreInstruction).getDestinationAddress() = nodeFrom
  ) and
  nodeTo.getAnOperand().getDefinitionInstruction() = nodeFrom
}

/**
 * Holds if taint may propagate from `source` to `sink` in zero or more local
 * (intra-procedural) steps.
 */
predicate localTaint(Instruction source, Instruction sink) {
  localTaintStep*(source, sink)
}

from StoreInstruction delayStore, LoadInstruction delayLoad, StoreInstruction bypassed, LoadInstruction spectreLoad
where delayLoad.getSourceValue() = delayStore
//  and not delayStore.getDestinationAddress() instanceof VariableAddressInstruction
  and localFlow(delayLoad, bypassed.getDestinationAddress())
  and valueNumber(spectreLoad.getSourceAddress()) = valueNumber(delayStore.getSourceValue())
  and bypassed.getASuccessor+() = spectreLoad
select bypassed.getAST(), "This store may be speculatively bypassed in the load $@", spectreLoad.getAST(), "here"
