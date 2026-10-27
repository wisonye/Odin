# This is a fork of [The Odin Programming Language](https://github.com/odin-lang/Odin)

## Overview

I tried both `Odin` and `Jai` for a while, and I love both. In the past few months, I have used both of them to experiment with the following side-projects:

- Common utilities, ported from my C utils, which include: Hex, logger, memory-prints, commands, terminal, IO multiplexing (TCP/UDP/IPC), etc.

- `libuv-like` event loop for my own TUI framework

- TUI widgets

- Ported all my fish/bash scripts to both of them. YES, you can use `Jai` or `Odin` like a scripting language: run a source file directly without producing the actual binary file, absolutely no problem:)

</br>

## My coding environment includes the following:

- FreeBSD on a Mini PC (Void Linux and Alpine Linux inside the bhyve VM)
- Void Linux on a 2019 iMac 5K
- Alpine Linux on a 2008 ThinkPad Yoga
- OpenBSD on a M2 MacBook Air

</br>

Honestly, I prefer `Jai` over `Odin`. But unfortunately, `Jai` doesn't support BSDs yet (my daily OS is **FreeBSD**), and I don't think Jonathan plans to support them either; that's why `Odin` is my C alernative choose so far.

</br>

## To get better programming user experiences, I made the following change to `Odin`.

Consistent `#` prefix for compile-time directives:

- `import` becomes `#import` - Compile-time module importing.

- `when` becomes `#if` — Compile-time conditional compilation.

- `foreign` becomes `#foreign` — Compile-time foreign blocks and foreign library declarations.

All those changes are just my personal preferences, nothing related to `Jai vs Odin` arguments; they're very different from the design, just the syntax looks a bit similar.


Finally, the self-run Odin file looks like this:

```odin
#!/usr/bin/env -S sh -c 'odin run "$0" -file -collection:utils=/home/wison/odin/odin-utils -define:LOGGER_LEVEL=0 -define:LOGGER_DISABLE_COLOR=true -define:LOGGER_BUFFER_SIZE=512 -define:DEFAULT_TEMP_ALLOCATOR_BACKING_SIZE=256 -- "$@"'

//
// $0: The current filename
// $@: Expand to all arguments following by the current filename
// "$@": Same as Symbol’s value as variable is void: $@ except the "xx yy" (double-quoted) argument becomes single argument!!!
//

package temp

//
//
//
test :: proc() {
	#if ODIN_OS == .Darwin {
		fmt.printf("\n>>> Darwin")
	}
	else #if ODIN_OS == .Linux {
		fmt.printf("\n>>> Linux")
	}
	else #if ODIN_OS == .FreeBSD {
		fmt.printf("\n>>> FreeBSD")
	}
	else #if ODIN_OS == .OpenBSD {
		fmt.printf("\n>>> OpenBSD")
	}
	else #if ODIN_OS == .NetBSD {
		fmt.printf("\n>>> NetBSD")
	}
}

//
//
//
print_slice:: proc(slice_ptr: ^[]$T, var_name_and_prefix: string) {
    fmt.printf(
        "\n>>> %s type: %v, len: %v, value: %#v\n",
        var_name_and_prefix,
        typeid_of(type_of(slice_ptr)),
        len(slice_ptr),
        slice_ptr^
    )
}

//
//
//
main :: proc() {
	fmt.printf("\n>>> Hello from Odin:)")

	temp_int: u32 = 0xAABBCCDD
	// memory.print_memory(&temp_int)
	mem.print_memory(&temp_int)

	args: []cstring = runtime.args__
	print_slice(&args, "args")

	test()
}

#import "base:runtime"
#import "core:fmt"
#import mem "utils:memory"
```


Then, you can run it like this:

```fish
chmod +x ~/temp/temp.odin
~/temp.odin
```

Example output:

```fish
(I) [ odin-development.test ] /home/wison/odin/Odin   ~/temp/temp.odin 111 "Hello buddy:)" xxx yyy

>>> Hello from Odin:)
(D) [ Memory - print_memory ] [ u32, size: 4 ]
(D) [ Memory - print_memory ] --------
(D) [ Memory - print_memory ] DDCCBBAA
(D) [ Memory - print_memory ] --------

>>> args type: ^[]cstring, len: 5, value: [
	"temp",
	"111",
	"Hello buddy:)",
	"xxx",
	"yyy",
]

>>> FreeBSD
```
