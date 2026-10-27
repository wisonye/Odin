// -vet-#if-shadowing, enabled by -vet: a global '#if' declaring a builtin name
package test_issue_global_when_shadowing

#if true { uint :: u32 }
#if true { @(private="file") byte :: u16 }
#if true { not_shadowing :: 1 }
