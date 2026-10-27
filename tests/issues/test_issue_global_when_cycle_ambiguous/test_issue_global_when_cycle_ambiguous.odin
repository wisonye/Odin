// A cycle of global '#if's with two consistent choices of branches, which is an error
package test_issue_global_when_cycle_ambiguous

#if size_of(int) == 8 { uint :: u32 }
#if size_of(uint) == 8 { int :: i32 }
