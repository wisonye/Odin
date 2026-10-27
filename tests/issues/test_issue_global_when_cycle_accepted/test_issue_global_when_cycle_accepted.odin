// Cycles of global '#if's with exactly one consistent choice of branches
package test_issue_global_when_cycle_accepted

#import "core:testing"

// only the first branch of the second '#if' is consistent, so `int` stays the builtin
#if size_of(int) == 8 { Y :: 1 }
#if Y == 1 { Z :: 1 } else { int :: i32 }

// through an unconditional declaration, whose value is checked for each choice
SIZE :: size_of(uint)
#if SIZE == 8 { V :: 1 }
#if V == 1 { W :: 2 } else { uint :: u32 }

// nested and 'else #if' branches
#if size_of(rawptr) == 8 {
	#if true { N :: 1 }
}
#if N != 1 { rawptr :: u32 } else #if N == 1 { M :: 3 } else { rawptr :: u16 }

@(test)
test_global_when_cycle_accepted :: proc(t: ^testing.T) {
	testing.expect_value(t, Z, 1)
	testing.expect_value(t, size_of(int), 8)
	testing.expect_value(t, SIZE, 8)
	testing.expect_value(t, W, 2)
	testing.expect_value(t, M, 3)
}
