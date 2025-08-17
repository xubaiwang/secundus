# Secundus

> [!NOTE]
> WIP

Unleash secondary memories for Rust WebAssembly.

Although `multi-memory` proposal is already [standardized](https://github.com/WebAssembly/proposals/blob/main/README.md), and most[^1] of of WebAssembly runtimes has supported it,
there are several obstacles from the toolchain side that prevents us from using this feature:

[^1]: except WebKit, already assigned in [Bugzilla](https://bugs.webkit.org/show_bug.cgi?id=277743) but no further news

1. No concept of multiple memories in programming languages. Though there is a similar concept `addredd_space` in LLVM, it has not linked to WASM yet and has limitations (see [previous discussion](https://github.com/WebAssembly/multi-memory/issues/45)).
2. [`wasm-ld`](https://lld.llvm.org/WebAssembly.html) does not recognize multiple memories. There is only one memory in the linked output.

So currently the only possible way to make a multi-memory WASM is to craft the text format by hand (see the [`handwritten/`](./handwritten) example).
However, it is insane to write low-level assembly in application project. There should be a library to abstract these out.

This repo aims to solve this situation with three-step approach:

1. Write wasm memory functions that can be linked to
2. Craft out a custom linker that has multi-memory knowledge (`secundus-ld`)
3. Make a Rusty and ergonomic interface for using those functions
