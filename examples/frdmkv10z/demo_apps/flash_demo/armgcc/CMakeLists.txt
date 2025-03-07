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
set(CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS_DEBUG} -T${ProjDirPath}/../../../../../platform/devices/MKV10Z7/linker/gcc/MKV10Z32xxx7_flash.ld  -static")

# RELEASE LINK FILE
set(CMAKE_EXE_LINKER_FLAGS_RELEASE "${CMAKE_EXE_LINKER_FLAGS_RELEASE} -T${ProjDirPath}/../../../../../platform/devices/MKV10Z7/linker/gcc/MKV10Z32xxx7_flash.ld  -static")

# DEBUG ASM FLAGS
SET(CMAKE_ASM_FLAGS_DEBUG "${CMAKE_ASM_FLAGS_DEBUG} -g  -mcpu=cortex-m0plus  -mthumb  -Wall  -fno-common  -ffunction-sections  -fdata-sections  -ffreestanding  -fno-builtin  -mapcs  -std=gnu99")

# DEBUG C FLAGS
SET(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -g  -O0  -mcpu=cortex-m0plus  -mthumb  -MMD  -MP  -Wall  -fno-common  -ffunction-sections  -fdata-sections  -ffreestanding  -fno-builtin  -mapcs  -std=gnu99")

# DEBUG LD FLAGS
SET(CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS_DEBUG} -g  --specs=nano.specs  -lm  -Wall  -fno-common  -ffunction-sections  -fdata-sections  -ffreestanding  -fno-builtin  -mthumb  -mapcs  -Xlinker --gc-sections  -Xlinker -static  -Xlinker -z  -Xlinker muldefs  -Xlinker --defsym=__stack_size__=0x400  -Xlinker --defsym=__heap_size__=0x200")

# RELEASE ASM FLAGS
SET(CMAKE_ASM_FLAGS_RELEASE "${CMAKE_ASM_FLAGS_RELEASE} -mcpu=cortex-m0plus  -mthumb  -Wall  -fno-common  -ffunction-sections  -fdata-sections  -ffreestanding  -fno-builtin  -mapcs  -std=gnu99")

# RELEASE C FLAGS
SET(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -Os  -mcpu=cortex-m0plus  -mthumb  -MMD  -MP  -Wall  -fno-common  -ffunction-sections  -fdata-sections  -ffreestanding  -fno-builtin  -mapcs  -std=gnu99")

# RELEASE LD FLAGS
SET(CMAKE_EXE_LINKER_FLAGS_RELEASE "${CMAKE_EXE_LINKER_FLAGS_RELEASE} --specs=nano.specs  -lm  -Wall  -fno-common  -ffunction-sections  -fdata-sections  -ffreestanding  -fno-builtin  -mthumb  -mapcs  -Xlinker --gc-sections  -Xlinker -static  -Xlinker -z  -Xlinker muldefs  -Xlinker --defsym=__stack_size__=0x400  -Xlinker --defsym=__heap_size__=0x200")

# ASM MACRO
SET(CMAKE_ASM_FLAGS_DEBUG "${CMAKE_ASM_FLAGS_DEBUG}  -DDEBUG")

# C MACRO
SET(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG}  -DDEBUG")
SET(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG}  -DCPU_MKV10Z32VLF7")
SET(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG}  -DFRDM_KV10Z")
SET(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG}  -DFREEDOM")
SET(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE}  -DNDEBUG")
SET(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE}  -DCPU_MKV10Z32VLF7")
SET(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE}  -DFRDM_KV10Z")
SET(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE}  -DFREEDOM")

# CXX MACRO

# INCLUDE_DIRECTORIES
IF(CMAKE_BUILD_TYPE MATCHES Debug)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../platform/osa/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../platform/utilities/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../platform/CMSIS/Include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../platform/devices)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../platform/devices/MKV10Z7/include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../platform/devices/MKV10Z7/startup)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../platform/hal/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../platform/drivers/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../platform/system/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../platform/drivers/src/flash/C90TFS/drvsrc/include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/..)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../..)
ELSEIF(CMAKE_BUILD_TYPE MATCHES Release)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../platform/osa/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../platform/utilities/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../platform/CMSIS/Include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../platform/devices)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../platform/devices/MKV10Z7/include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../platform/devices/MKV10Z7/startup)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../platform/hal/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../platform/drivers/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../platform/system/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../platform/drivers/src/flash/C90TFS/drvsrc/include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/..)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../..)
ENDIF()

# ADD_EXECUTABLE
ADD_EXECUTABLE(flash_demo 
    "${ProjDirPath}/../../../../../platform/utilities/src/fsl_misc_utilities.c"
    "${ProjDirPath}/../../../../../platform/devices/MKV10Z7/startup/gcc/startup_MKV10Z7.S"
    "${ProjDirPath}/../main.c"
    "${ProjDirPath}/../flash_swap.c"
    "${ProjDirPath}/../../../../../platform/drivers/src/flash/C90TFS/drvsrc/source/CopyToRam.c"
    "${ProjDirPath}/../../../../../platform/drivers/src/flash/C90TFS/drvsrc/source/DEFlashPartition.c"
    "${ProjDirPath}/../../../../../platform/drivers/src/flash/C90TFS/drvsrc/source/DFlashGetProtection.c"
    "${ProjDirPath}/../../../../../platform/drivers/src/flash/C90TFS/drvsrc/source/DFlashSetProtection.c"
    "${ProjDirPath}/../../../../../platform/drivers/src/flash/C90TFS/drvsrc/source/EEEWrite.c"
    "${ProjDirPath}/../../../../../platform/drivers/src/flash/C90TFS/drvsrc/source/EERAMGetProtection.c"
    "${ProjDirPath}/../../../../../platform/drivers/src/flash/C90TFS/drvsrc/source/EERAMSetProtection.c"
    "${ProjDirPath}/../../../../../platform/drivers/src/flash/C90TFS/drvsrc/source/FlashCheckSum.c"
    "${ProjDirPath}/../../../../../platform/drivers/src/flash/C90TFS/drvsrc/source/FlashCommandSequence.c"
    "${ProjDirPath}/../../../../../platform/drivers/src/flash/C90TFS/drvsrc/source/FlashEraseAllBlock.c"
    "${ProjDirPath}/../../../../../platform/drivers/src/flash/C90TFS/drvsrc/source/FlashEraseBlock.c"
    "${ProjDirPath}/../../../../../platform/drivers/src/flash/C90TFS/drvsrc/source/FlashEraseResume.c"
    "${ProjDirPath}/../../../../../platform/drivers/src/flash/C90TFS/drvsrc/source/FlashEraseSector.c"
    "${ProjDirPath}/../../../../../platform/drivers/src/flash/C90TFS/drvsrc/source/FlashEraseSuspend.c"
    "${ProjDirPath}/../../../../../platform/drivers/src/flash/C90TFS/drvsrc/source/FlashGetSecurityState.c"
    "${ProjDirPath}/../../../../../platform/drivers/src/flash/C90TFS/drvsrc/source/FlashInit.c"
    "${ProjDirPath}/../../../../../platform/drivers/src/flash/C90TFS/drvsrc/source/FlashProgram.c"
    "${ProjDirPath}/../../../../../platform/drivers/src/flash/C90TFS/drvsrc/source/FlashProgramCheck.c"
    "${ProjDirPath}/../../../../../platform/drivers/src/flash/C90TFS/drvsrc/source/FlashProgramOnce.c"
    "${ProjDirPath}/../../../../../platform/drivers/src/flash/C90TFS/drvsrc/source/FlashProgramSection.c"
    "${ProjDirPath}/../../../../../platform/drivers/src/flash/C90TFS/drvsrc/source/FlashReadOnce.c"
    "${ProjDirPath}/../../../../../platform/drivers/src/flash/C90TFS/drvsrc/source/FlashReadResource.c"
    "${ProjDirPath}/../../../../../platform/drivers/src/flash/C90TFS/drvsrc/source/FlashSecurityBypass.c"
    "${ProjDirPath}/../../../../../platform/drivers/src/flash/C90TFS/drvsrc/source/FlashVerifyAllBlock.c"
    "${ProjDirPath}/../../../../../platform/drivers/src/flash/C90TFS/drvsrc/source/FlashVerifyBlock.c"
    "${ProjDirPath}/../../../../../platform/drivers/src/flash/C90TFS/drvsrc/source/FlashVerifySection.c"
    "${ProjDirPath}/../../../../../platform/drivers/src/flash/C90TFS/drvsrc/source/PFlashGetProtection.c"
    "${ProjDirPath}/../../../../../platform/drivers/src/flash/C90TFS/drvsrc/source/PFlashSetProtection.c"
    "${ProjDirPath}/../../../../../platform/drivers/src/flash/C90TFS/drvsrc/source/PFlashSwap.c"
    "${ProjDirPath}/../../../../../platform/drivers/src/flash/C90TFS/drvsrc/source/PFlashSwapCtl.c"
    "${ProjDirPath}/../../../../../platform/drivers/src/flash/C90TFS/drvsrc/source/SetEEEEnable.c"
    "${ProjDirPath}/../../../../../platform/drivers/src/flash/C90TFS/drvsrc/include/FTFx_KX_flash_config.h"
    "${ProjDirPath}/../../../../../platform/drivers/src/flash/C90TFS/drvsrc/include/SSD_FTFx.h"
    "${ProjDirPath}/../../../../../platform/drivers/src/flash/C90TFS/drvsrc/include/SSD_FTFx_Common.h"
    "${ProjDirPath}/../../../../../platform/drivers/src/flash/C90TFS/drvsrc/include/SSD_FTFx_Internal.h"
    "${ProjDirPath}/../../../../../platform/drivers/src/flash/C90TFS/drvsrc/include/SSD_Types.h"
    "${ProjDirPath}/../hardware_init.c"
    "${ProjDirPath}/../../../gpio_pins.c"
    "${ProjDirPath}/../../../gpio_pins.h"
    "${ProjDirPath}/../../../pin_mux.c"
    "${ProjDirPath}/../../../pin_mux.h"
    "${ProjDirPath}/../../../board.c"
    "${ProjDirPath}/../../../board.h"
    "${ProjDirPath}/../../../../../platform/utilities/src/fsl_debug_console.c"
    "${ProjDirPath}/../../../../../platform/utilities/inc/fsl_debug_console.h"
    "${ProjDirPath}/../../../../../platform/utilities/src/print_scan.c"
    "${ProjDirPath}/../../../../../platform/utilities/src/print_scan.h"
    "${ProjDirPath}/../../../../../platform/devices/MKV10Z7/startup/system_MKV10Z7.c"
    "${ProjDirPath}/../../../../../platform/devices/startup.c"
    "${ProjDirPath}/../../../../../platform/devices/startup.h"
)
SET_TARGET_PROPERTIES(flash_demo PROPERTIES OUTPUT_NAME "flash_demo.elf")

TARGET_LINK_LIBRARIES(flash_demo -Wl,--start-group)
# LIBRARIES
IF(CMAKE_BUILD_TYPE MATCHES Debug)
    TARGET_LINK_LIBRARIES(flash_demo ${ProjDirPath}/../../../../../lib/ksdk_platform_lib/armgcc/KV10Z7/debug/libksdk_platform.a)
ELSEIF(CMAKE_BUILD_TYPE MATCHES Release)
    TARGET_LINK_LIBRARIES(flash_demo ${ProjDirPath}/../../../../../lib/ksdk_platform_lib/armgcc/KV10Z7/release/libksdk_platform.a)
ENDIF()

# SYSTEM LIBRARIES
TARGET_LINK_LIBRARIES(flash_demo m)
TARGET_LINK_LIBRARIES(flash_demo c)
TARGET_LINK_LIBRARIES(flash_demo gcc)
TARGET_LINK_LIBRARIES(flash_demo nosys)
TARGET_LINK_LIBRARIES(flash_demo -Wl,--end-group)

# MAP FILE
SET(CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS_DEBUG}  -Xlinker -Map=debug/flash_demo.map")
SET(CMAKE_EXE_LINKER_FLAGS_RELEASE "${CMAKE_EXE_LINKER_FLAGS_RELEASE}  -Xlinker -Map=release/flash_demo.map")

# BIN AND HEX
ADD_CUSTOM_COMMAND(TARGET flash_demo POST_BUILD COMMAND ${CMAKE_OBJCOPY} -Oihex ${EXECUTABLE_OUTPUT_PATH}/flash_demo.elf ${EXECUTABLE_OUTPUT_PATH}/flash_demo.hex)
ADD_CUSTOM_COMMAND(TARGET flash_demo POST_BUILD COMMAND ${CMAKE_OBJCOPY} -Obinary ${EXECUTABLE_OUTPUT_PATH}/flash_demo.elf ${EXECUTABLE_OUTPUT_PATH}/flash_demo.bin)
