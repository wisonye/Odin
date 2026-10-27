package sdl3

SDL3_WASM_LIB :: #config(SDL3_WASM_LIB, "env.o")

#if ODIN_ARCH == .wasm32 || ODIN_ARCH == .wasm64p32 {
	@(export) #foreign #import lib { SDL3_WASM_LIB }
} else #if ODIN_OS == .Windows {
	@(export) #foreign #import lib { "SDL3.lib" }
} else {
	@(export) #foreign #import lib { "system:SDL3" }
}