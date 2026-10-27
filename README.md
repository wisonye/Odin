# This is a fork of [The Odin Programming Language](https://github.com/odin-lang/Odin)

I tried both `Odin` and `Jai` for a while, and I love both. In the past few months, I have used both of them to experiment with the following side-projects:

- Common utilities, ported from my C utils, which include: Hex, logger, memory-prints, commands, terminal, IO multiplexing (TCP/UDP/IPC, etc.

- `libuv-like` event loop for my own TUI framework

- TUI widgets

- Ported all my fish/bash scripts to both of them. YES, you can use `Jai` or `Odin` like a scripting language: run a source file directly without producing the actual binary file, absolutely no problem:)

</br>

Honestly, I prefer `Jai` over `Odin`. But unfortunately, `Jai` doesn't support BSDs yet (my daily OS is **FreeBSD**), and I don't think Jonathan plans to support them either; that's why `Odin` is my C alernative choose so far.

To get better programming user experiences, I made the following change to `Odin`.

Consistent `#` prefix for compile-time directives:

- `import` becomes `#import` - Compile-time module importing.

- `when` becomes `#if` — Compile-time conditional compilation.

- `foreign` becomes `#foreign` — Compile-time foreign blocks and foreign library declarations.

All those changes are just my personal preferences, nothing related to `Jai vs Odin` arguments; they're very different from the design, just the syntax looks a bit similar.
