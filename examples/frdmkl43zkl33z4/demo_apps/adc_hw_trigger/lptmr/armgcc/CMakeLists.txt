INCLUDE(CMakeForceCompiler)

# CROSS COMPILER SETTING
SET(CMAKE_SYSTEM_NAME Generic)
CMAKE_MINIMUM_REQUIRED (VERSION 2.6)

# THE VERSION NUMBER
SET (Tutorial_VERSION_MAJOR 1)
SET (Tutorial_VERSION_MINOR 0)

# ENABLE ASM
ENABLE_LANGUAGE(ASM)

SET(CMAKE_STATIC_LIBRARY_PREFIX)
SET(CMAKE_STATIC_LIBRARY_SUFFIX)

SET(CMAKE_EXECUTABLE_LIBRARY_PREFIX)
SET(CMAKE_EXECUTABLE_LIBRARY_SUFFIX)

 
# CURRENT DIRECTORY
SET(ProjDirPath ${CMAKE_CURRENT_SOURCE_DIR})

# DEBUG LINK FILE
set(CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS_DEBUG} -T${ProjDirPath}/../../../../../../platform/devices/MKL33Z644/linker/gcc/MKL33Z64xxx4_flash.ld  -static")

# RELEASE LINK FILE
set(CMAKE_EXE_LINKER_FLAGS_RELEASE "${CMAKE_EXE_LINKER_FLAGS_RELEASE} -T${ProjDirPath}/../../../../../../platform/devices/MKL33Z644/linker/gcc/MKL33Z64xxx4_flash.ld  -static")

# DEBUG ASM FLAGS
SET(CMAKE_ASM_FLAGS_DEBUG "${CMAKE_ASM_FLAGS_DEBUG} -g  -Wall  -fno-common  -ffunction-sections  -fdata-sections  -ffreestanding  -fno-builtin  -mthumb  -mapcs  -std=gnu99  -mcpu=cortex-m0plus")

# DEBUG C FLAGS
SET(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -g  -O0  -Wall  -fno-common  -ffunction-sections  -fdata-sections  -ffreestanding  -fno-builtin  -mthumb  -mapcs  -std=gnu99  -mcpu=cortex-m0plus  -MMD  -MP")

# DEBUG LD FLAGS
SET(CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS_DEBUG} -g  --specs=nano.specs  -lm  -Wall  -fno-common  -ffunction-sections  -fdata-sections  -ffreestanding  -fno-builtin  -mthumb  -mapcs  -Xlinker --gc-sections  -Xlinker -static  -Xlinker -z  -Xlinker muldefs  -Xlinker --defsym=__heap_size__=0x200  -Xlinker --defsym=__stack_size__=0x200")

# RELEASE ASM FLAGS
SET(CMAKE_ASM_FLAGS_RELEASE "${CMAKE_ASM_FLAGS_RELEASE} -Wall  -fno-common  -ffunction-sections  -fdata-sections  -ffreestanding  -fno-builtin  -mthumb  -mapcs  -std=gnu99  -mcpu=cortex-m0plus")

# RELEASE C FLAGS
SET(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -Os  -Wall  -fno-common  -ffunction-sections  -fdata-sections  -ffreestanding  -fno-builtin  -mthumb  -mapcs  -std=gnu99  -mcpu=cortex-m0plus  -MMD  -MP")

# RELEASE LD FLAGS
SET(CMAKE_EXE_LINKER_FLAGS_RELEASE "${CMAKE_EXE_LINKER_FLAGS_RELEASE} --specs=nano.specs  -lm  -Wall  -fno-common  -ffunction-sections  -fdata-sections  -ffreestanding  -fno-builtin  -mthumb  -mapcs  -Xlinker --gc-sections  -Xlinker -static  -Xlinker -z  -Xlinker muldefs  -Xlinker --defsym=__heap_size__=0x200  -Xlinker --defsym=__stack_size__=0x200")

# ASM MACRO
SET(CMAKE_ASM_FLAGS_DEBUG "${CMAKE_ASM_FLAGS_DEBUG}  -DDEBUG")

# C MACRO
SET(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG}  -DDEBUG")
SET(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG}  -DCPU_MKL33Z64VLH4")
SET(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG}  -DFRDM_KL43Z")
SET(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG}  -DFREEDOM")
SET(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE}  -DNDEBUG")
SET(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE}  -DCPU_MKL33Z64VLH4")
SET(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE}  -DFRDM_KL43Z")
SET(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE}  -DFREEDOM")

# CXX MACRO

# INCLUDE_DIRECTORIES
IF(CMAKE_BUILD_TYPE MATCHES Debug)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../platform/osa/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../platform/utilities/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../platform/CMSIS/Include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../platform/devices)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../platform/devices/MKL33Z644/include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../platform/devices/MKL33Z644/startup)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../platform/hal/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../platform/drivers/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../platform/system/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../..)
ELSEIF(CMAKE_BUILD_TYPE MATCHES Release)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../platform/osa/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../platform/utilities/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../platform/CMSIS/Include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../platform/devices)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../platform/devices/MKL33Z644/include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../platform/devices/MKL33Z644/startup)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../platform/hal/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../platform/drivers/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../platform/system/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../..)
ENDIF()

# ADD_EXECUTABLE
ADD_EXECUTABLE(adc_lptmr_trigger 
    "${ProjDirPath}/../../../../../../platform/utilities/src/fsl_misc_utilities.c"
    "${ProjDirPath}/../../../../../../platform/devices/MKL33Z644/startup/gcc/startup_MKL33Z644.S"
    "${ProjDirPath}/../../main.c"
    "${ProjDirPath}/../../lptmr_trigger.c"
    "${ProjDirPath}/../../fsl_adc_irq.c"
    "${ProjDirPath}/../../hardware_init.c"
    "${ProjDirPath}/../../../../gpio_pins.c"
    "${ProjDirPath}/../../../../gpio_pins.h"
    "${ProjDirPath}/../../../../pin_mux.c"
    "${ProjDirPath}/../../../../pin_mux.h"
    "${ProjDirPath}/../../../../board.c"
    "${ProjDirPath}/../../../../board.h"
    "${ProjDirPath}/../../../../../../platform/utilities/src/fsl_debug_console.c"
    "${ProjDirPath}/../../../../../../platform/utilities/inc/fsl_debug_console.h"
    "${ProjDirPath}/../../../../../../platform/utilities/src/print_scan.c"
    "${ProjDirPath}/../../../../../../platform/utilities/src/print_scan.h"
    "${ProjDirPath}/../../../../../../platform/devices/MKL33Z644/startup/system_MKL33Z644.c"
    "${ProjDirPath}/../../../../../../platform/devices/startup.c"
    "${ProjDirPath}/../../../../../../platform/devices/startup.h"
)
SET_TARGET_PROPERTIES(adc_lptmr_trigger PROPERTIES OUTPUT_NAME "adc_lptmr_trigger.elf")

TARGET_LINK_LIBRARIES(adc_lptmr_trigger -Wl,--start-group)
# LIBRARIES
IF(CMAKE_BUILD_TYPE MATCHES Debug)
    TARGET_LINK_LIBRARIES(adc_lptmr_trigger ${ProjDirPath}/../../../../../../lib/ksdk_platform_lib/armgcc/KL33Z644/debug/libksdk_platform.a)
ELSEIF(CMAKE_BUILD_TYPE MATCHES Release)
    TARGET_LINK_LIBRARIES(adc_lptmr_trigger ${ProjDirPath}/../../../../../../lib/ksdk_platform_lib/armgcc/KL33Z644/release/libksdk_platform.a)
ENDIF()

# SYSTEM LIBRARIES
TARGET_LINK_LIBRARIES(adc_lptmr_trigger m)
TARGET_LINK_LIBRARIES(adc_lptmr_trigger c)
TARGET_LINK_LIBRARIES(adc_lptmr_trigger gcc)
TARGET_LINK_LIBRARIES(adc_lptmr_trigger nosys)
TARGET_LINK_LIBRARIES(adc_lptmr_trigger -Wl,--end-group)

# MAP FILE
SET(CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS_DEBUG}  -Xlinker -Map=debug/adc_lptmr_trigger.map")
SET(CMAKE_EXE_LINKER_FLAGS_RELEASE "${CMAKE_EXE_LINKER_FLAGS_RELEASE}  -Xlinker -Map=release/adc_lptmr_trigger.map")

# BIN AND HEX
ADD_CUSTOM_COMMAND(TARGET adc_lptmr_trigger POST_BUILD COMMAND ${CMAKE_OBJCOPY} -Oihex ${EXECUTABLE_OUTPUT_PATH}/adc_lptmr_trigger.elf ${EXECUTABLE_OUTPUT_PATH}/adc_lptmr_trigger.hex)
ADD_CUSTOM_COMMAND(TARGET adc_lptmr_trigger POST_BUILD COMMAND ${CMAKE_OBJCOPY} -Obinary ${EXECUTABLE_OUTPUT_PATH}/adc_lptmr_trigger.elf ${EXECUTABLE_OUTPUT_PATH}/adc_lptmr_trigger.bin)
