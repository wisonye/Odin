// Cycles of global '#if's where no choice of branches is consistent, so each is an error
package test_issue_global_when_cycle

// taken, `int` becomes 4 bytes and the first condition is false; not taken, the second is true
#if size_of(int) == 8 { A :: 1 }
#if A == 1 { int :: i32 }

// both taken is consistent, but each branch is needed to decide its own condition
#if Y == 1 { X :: 1 }
#if X == 1 { Y :: 1 }

// a '#if' needing a name it may declare
#if B == 1 { B :: 1 }

// or one declared by a '#if' within it
#if C == 1 {
	#if true { C :: 1 }
}
