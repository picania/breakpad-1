#
# processor
#
set(ProcessorSources
    processor/basic_code_modules.cc
    processor/basic_source_line_resolver.cc
    processor/call_stack.cc
    processor/cfi_frame_info.cc
    processor/disassembler_x86.cc
    processor/dump_context.cc
    processor/dump_object.cc
    processor/exploitability.cc
    processor/exploitability_linux.cc
    processor/exploitability_win.cc
    processor/fast_source_line_resolver.cc
    processor/logging.cc
    processor/microdump_processor.cc
    processor/minidump.cc
    processor/minidump_processor.cc
    processor/module_comparer.cc
    processor/module_serializer.cc
    processor/pathname_stripper.cc
    processor/proc_maps_linux.cc
    processor/process_state.cc
    processor/simple_symbol_supplier.cc
    processor/source_line_resolver_base.cc
    processor/stack_frame_cpu.cc
    processor/stack_frame_symbolizer.cc
    processor/stackwalk_common.cc
    processor/stackwalker.cc
    processor/stackwalker_address_list.cc
    processor/stackwalker_amd64.cc
    processor/stackwalker_arm.cc
    processor/stackwalker_arm64.cc
    processor/stackwalker_mips.cc
    processor/stackwalker_ppc.cc
    processor/stackwalker_ppc64.cc
    processor/stackwalker_selftest.cc
    processor/stackwalker_sparc.cc
    processor/stackwalker_x86.cc
    processor/symbolic_constants_win.cc
    processor/synth_minidump.cc
    processor/tokenize.cc

	processor/processor.cmake
)
source_group("" FILES ${ProcessorSources})

add_library(processor STATIC
	${ProcessorSources}
)

target_include_directories(processor PUBLIC
	${CMAKE_CURRENT_SOURCE_DIR}
)

target_compile_definitions(processor PRIVATE
	$<$<CXX_COMPILER_ID:MSVC>:_CRT_SECURE_NO_WARNINGS>
	$<$<CXX_COMPILER_ID:MSVC>:_SCL_SECURE_NO_WARNINGS>
	BPLOG_MINIMUM_SEVERITY=SEVERITY_ERROR
)

target_compile_options(processor PRIVATE
	$<$<CXX_COMPILER_ID:MSVC>:/wd4800 /wd4146>
	$<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:Debug>>:/MTd>
	$<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:Release>>:/MT>
	$<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:MinSizeRel>>:/MT>
	$<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:RelWithDebInfo>>:/MT>
)

#
# minidump_stackwalk
#
set(MinidumSources
	processor/minidump_stackwalk.cc
)
source_group("" FILES ${MinidumSources})

add_executable(minidump_stackwalk
    ${MinidumSources}
)

target_include_directories(minidump_stackwalk PRIVATE
	${CMAKE_CURRENT_SOURCE_DIR}
)

target_compile_definitions(minidump_stackwalk PRIVATE
	$<$<CXX_COMPILER_ID:MSVC>:_CRT_SECURE_NO_WARNINGS>
	$<$<CXX_COMPILER_ID:MSVC>:_SCL_SECURE_NO_WARNINGS>
	BPLOG_MINIMUM_SEVERITY=SEVERITY_ERROR
)

target_compile_options(minidump_stackwalk PRIVATE
	$<$<CXX_COMPILER_ID:MSVC>:/wd4800 /wd4146>
	$<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:Debug>>:/MTd>
	$<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:Release>>:/MT>
	$<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:MinSizeRel>>:/MT>
	$<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:RelWithDebInfo>>:/MT>
)

target_link_libraries(minidump_stackwalk
	processor
	disasm
    common
)
