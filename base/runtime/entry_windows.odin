#+private
#+build windows
#+no-instrumentation
package runtime

#import "base:intrinsics"

#if ODIN_BUILD_MODE == .Dynamic {
	@(link_name="DllMain", linkage="strong", require)
	DllMain :: proc "system" (hinstDLL: rawptr, fdwReason: u32, lpReserved: rawptr) -> b32 {
		context = default_context()

		// Populate Windows DLL-specific globals
		dll_forward_reason = DLL_Forward_Reason(fdwReason)
		dll_instance       = hinstDLL

		switch dll_forward_reason {
		case .Process_Attach:
			#if !ODIN_BEDROCK { #force_no_inline _startup_runtime() }
			#if ODIN_CODEPAGE_MAGIC {
				old_console_codepage = GetConsoleOutputCP()
				SetConsoleOutputCP(UTF_8)
			}
			intrinsics.__entry_point()
		case .Process_Detach:
			#if !ODIN_BEDROCK { #force_no_inline _cleanup_runtime() }
			#if ODIN_CODEPAGE_MAGIC { SetConsoleOutputCP(old_console_codepage) }
		case .Thread_Attach:
			break
		case .Thread_Detach:
			break
		}
		return true
	}
} else #if !ODIN_TEST && !ODIN_NO_ENTRY_POINT {
	#if ODIN_ARCH == .i386 && !ODIN_NO_CRT {
		// Windows i386 with CRT: libcmt provides mainCRTStartup which calls _main
		// Note: "c" calling convention adds underscore prefix automatically on i386
		@(link_name="main", linkage="strong", require)
		main :: proc "c" (argc: i32, argv: [^]cstring) -> i32 {
			args__ = argv[:argc]
			context = default_context()
			#if !ODIN_BEDROCK { #force_no_inline _startup_runtime() }
			#if ODIN_CODEPAGE_MAGIC {
				old_console_codepage = GetConsoleOutputCP()
				SetConsoleOutputCP(UTF_8)
			}
			intrinsics.__entry_point()
			#if !ODIN_BEDROCK       { #force_no_inline _cleanup_runtime() }
			#if ODIN_CODEPAGE_MAGIC { SetConsoleOutputCP(old_console_codepage) }
			return 0
		}
	} else #if ODIN_NO_CRT {
		@(link_name="mainCRTStartup", linkage="strong", require)
		mainCRTStartup :: proc "system" () -> i32 {
			context = default_context()
			#if !ODIN_BEDROCK { #force_no_inline _startup_runtime() }
			#if ODIN_CODEPAGE_MAGIC {
				old_console_codepage = GetConsoleOutputCP()
				SetConsoleOutputCP(UTF_8)
			}
			intrinsics.__entry_point()
			#if !ODIN_BEDROCK       { #force_no_inline _cleanup_runtime() }
			#if ODIN_CODEPAGE_MAGIC { SetConsoleOutputCP(old_console_codepage) }
			return 0
		}
	} else {
		@(link_name="main", linkage="strong", require)
		main :: proc "c" (argc: i32, argv: [^]cstring) -> i32 {
			args__ = argv[:argc]
			context = default_context()
			#if !ODIN_BEDROCK { #force_no_inline _startup_runtime() }
			#if ODIN_CODEPAGE_MAGIC {
				old_console_codepage = GetConsoleOutputCP()
				SetConsoleOutputCP(UTF_8)
			}
			intrinsics.__entry_point()
			#if !ODIN_BEDROCK       { #force_no_inline _cleanup_runtime() }
			#if ODIN_CODEPAGE_MAGIC { SetConsoleOutputCP(old_console_codepage) }
			return 0
		}
	}
}