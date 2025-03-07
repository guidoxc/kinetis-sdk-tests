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
set(CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS_DEBUG} -T${ProjDirPath}/../../../../../../../../../platform/devices/MK24F25612/linker/gcc/MK24FN256xxx12_flash.ld  -static")

# RELEASE LINK FILE
set(CMAKE_EXE_LINKER_FLAGS_RELEASE "${CMAKE_EXE_LINKER_FLAGS_RELEASE} -T${ProjDirPath}/../../../../../../../../../platform/devices/MK24F25612/linker/gcc/MK24FN256xxx12_flash.ld  -static")

# DEBUG ASM FLAGS
SET(CMAKE_ASM_FLAGS_DEBUG "${CMAKE_ASM_FLAGS_DEBUG} -g  -mcpu=cortex-m4  -mfloat-abi=hard  -mfpu=fpv4-sp-d16  -mthumb  -Wall  -fno-common  -ffunction-sections  -fdata-sections  -ffreestanding  -fno-builtin  -mapcs  -std=gnu99")

# DEBUG C FLAGS
SET(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -g  -O0  -Wno-format  -fno-strict-aliasing  -mcpu=cortex-m4  -mfloat-abi=hard  -mfpu=fpv4-sp-d16  -mthumb  -MMD  -MP  -Wall  -fno-common  -ffunction-sections  -fdata-sections  -ffreestanding  -fno-builtin  -mapcs  -std=gnu99")

# DEBUG LD FLAGS
SET(CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS_DEBUG} -g  -Xlinker --defsym=__ram_vector_table__=1  -mcpu=cortex-m4  -mfloat-abi=hard  -mfpu=fpv4-sp-d16  --specs=nano.specs  -lm  -Wall  -fno-common  -ffunction-sections  -fdata-sections  -ffreestanding  -fno-builtin  -mthumb  -mapcs  -Xlinker --gc-sections  -Xlinker -static  -Xlinker -z  -Xlinker muldefs  -Xlinker --defsym=__stack_size__=0x4000  -Xlinker --defsym=__heap_size__=0x8000")

# RELEASE ASM FLAGS
SET(CMAKE_ASM_FLAGS_RELEASE "${CMAKE_ASM_FLAGS_RELEASE} -mcpu=cortex-m4  -mfloat-abi=hard  -mfpu=fpv4-sp-d16  -mthumb  -Wall  -fno-common  -ffunction-sections  -fdata-sections  -ffreestanding  -fno-builtin  -mapcs  -std=gnu99")

# RELEASE C FLAGS
SET(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -Os  -Wno-format  -fno-strict-aliasing  -mcpu=cortex-m4  -mfloat-abi=hard  -mfpu=fpv4-sp-d16  -mthumb  -MMD  -MP  -Wall  -fno-common  -ffunction-sections  -fdata-sections  -ffreestanding  -fno-builtin  -mapcs  -std=gnu99")

# RELEASE LD FLAGS
SET(CMAKE_EXE_LINKER_FLAGS_RELEASE "${CMAKE_EXE_LINKER_FLAGS_RELEASE} -Xlinker --defsym=__ram_vector_table__=1  -mcpu=cortex-m4  -mfloat-abi=hard  -mfpu=fpv4-sp-d16  --specs=nano.specs  -lm  -Wall  -fno-common  -ffunction-sections  -fdata-sections  -ffreestanding  -fno-builtin  -mthumb  -mapcs  -Xlinker --gc-sections  -Xlinker -static  -Xlinker -z  -Xlinker muldefs  -Xlinker --defsym=__stack_size__=0x4000  -Xlinker --defsym=__heap_size__=0x8000")

# ASM MACRO
SET(CMAKE_ASM_FLAGS_DEBUG "${CMAKE_ASM_FLAGS_DEBUG}  -DDEBUG")

# C MACRO
SET(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG}  -D_DEBUG=1")
SET(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG}  -DCPU_MK24FN256VDC12")
SET(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG}  -DFSL_RTOS_UCOSII")
SET(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG}  -DTWR_K24F120M")
SET(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG}  -DTOWER")
SET(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE}  -D_DEBUG=0")
SET(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE}  -DCPU_MK24FN256VDC12")
SET(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE}  -DFSL_RTOS_UCOSII")
SET(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE}  -DTWR_K24F120M")
SET(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE}  -DTOWER")

# CXX MACRO

# INCLUDE_DIRECTORIES
IF(CMAKE_BUILD_TYPE MATCHES Debug)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../rtos/uCOSII/src/uCOS-II/Ports/ARM-Cortex-M4/Generic/GNU)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../rtos/uCOSII/src/uC-CPU/ARM-Cortex-M4/GNU)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/osa/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../rtos)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/utilities)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/CMSIS/Include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/devices)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/devices/MK24F25612/include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/devices/MK24F25612/startup)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../..)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/adapter/sources)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/adapter/sources/sdk)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/device/include/MK24F25612)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/device/include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/device/sources/classes/audio)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/device/sources/classes/cdc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/device/sources/classes/common)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/device/sources/classes/composite)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/device/sources/classes/hid)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/device/sources/classes/include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/device/sources/classes/include/config)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/device/sources/classes/msd)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/device/sources/classes/phdc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/device/sources/classes/video)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/device/sources/controller/khci)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/device/sources/controller)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/hal)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/include/MK24F25612)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/sources/classes/audio)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/sources/classes/cdc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/sources/classes/hid)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/sources/classes/hub)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/sources/classes/msd)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/sources/classes/phdc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/sources/classes/printer)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/sources/controller/khci)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/sources/controller)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/otg/sources/driver/khci)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/otg/sources/driver/max3353/sdk)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/otg/include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/otg/sources/otg)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/hal/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/drivers/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/drivers/src/uart)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/drivers/src/gpio)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/drivers/src/pit)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/drivers/src/edma)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/system/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../..)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/composite/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../rtos/uCOSII/src/config)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../rtos/uCOSII/src/uCOS-II/Source)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../rtos/uCOSII/src/uC-CPU)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../rtos/uCOSII/src/uC-LIB)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/utilities/inc)
ELSEIF(CMAKE_BUILD_TYPE MATCHES Release)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../rtos/uCOSII/src/uCOS-II/Ports/ARM-Cortex-M4/Generic/GNU)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../rtos/uCOSII/src/uC-CPU/ARM-Cortex-M4/GNU)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/osa/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../rtos)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/utilities)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/CMSIS/Include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/devices)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/devices/MK24F25612/include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/devices/MK24F25612/startup)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../..)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/adapter/sources)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/adapter/sources/sdk)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/device/include/MK24F25612)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/device/include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/device/sources/classes/audio)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/device/sources/classes/cdc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/device/sources/classes/common)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/device/sources/classes/composite)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/device/sources/classes/hid)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/device/sources/classes/include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/device/sources/classes/include/config)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/device/sources/classes/msd)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/device/sources/classes/phdc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/device/sources/classes/video)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/device/sources/controller/khci)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/device/sources/controller)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/hal)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/include/MK24F25612)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/sources/classes/audio)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/sources/classes/cdc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/sources/classes/hid)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/sources/classes/hub)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/sources/classes/msd)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/sources/classes/phdc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/sources/classes/printer)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/sources/controller/khci)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/sources/controller)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/otg/sources/driver/khci)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/otg/sources/driver/max3353/sdk)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/otg/include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/otg/sources/otg)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/hal/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/drivers/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/drivers/src/uart)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/drivers/src/gpio)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/drivers/src/pit)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/drivers/src/edma)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/system/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../..)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/composite/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../rtos/uCOSII/src/config)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../rtos/uCOSII/src/uCOS-II/Source)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../rtos/uCOSII/src/uC-CPU)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../rtos/uCOSII/src/uC-LIB)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/utilities/inc)
ENDIF()

# ADD_EXECUTABLE
ADD_EXECUTABLE(dev_audio_speaker_ucosii 
    "${ProjDirPath}/../../../../../../../../../rtos/uCOSII/src/uCOS-II/Ports/ARM-Cortex-M4/Generic/GNU/os_cpu.h"
    "${ProjDirPath}/../../../../../../../../../rtos/uCOSII/src/uCOS-II/Ports/ARM-Cortex-M4/Generic/GNU/os_cpu_a.S"
    "${ProjDirPath}/../../../../../../../../../rtos/uCOSII/src/uCOS-II/Ports/ARM-Cortex-M4/Generic/GNU/os_cpu_c.c"
    "${ProjDirPath}/../../../../../../../../../rtos/uCOSII/src/uCOS-II/Ports/ARM-Cortex-M4/Generic/GNU/os_dbg.c"
    "${ProjDirPath}/../../../../../../../../../platform/utilities/src/fsl_misc_utilities.c"
    "${ProjDirPath}/../../../../../../../../../platform/devices/MK24F25612/startup/gcc/startup_MK24F25612.S"
    "${ProjDirPath}/../../usb_request.h"
    "${ProjDirPath}/../../usb_request.c"
    "${ProjDirPath}/../../usb_descriptor.h"
    "${ProjDirPath}/../../usb_descriptor.c"
    "${ProjDirPath}/../../audio_speaker.h"
    "${ProjDirPath}/../../audio_speaker.c"
    "${ProjDirPath}/../../../../../../../../../platform/composite/inc/fsl_soundcard.h"
    "${ProjDirPath}/../../../../../../../../../platform/composite/src/soundcard/fsl_soundcard.c"
    "${ProjDirPath}/../../fsl_sgtl5000_driver.c"
    "${ProjDirPath}/../../fsl_sgtl5000_driver.h"
    "${ProjDirPath}/../../hardware_init.c"
    "${ProjDirPath}/../../../../../../../gpio_pins.c"
    "${ProjDirPath}/../../../../../../../gpio_pins.h"
    "${ProjDirPath}/../../../../../../../pin_mux.c"
    "${ProjDirPath}/../../../../../../../pin_mux.h"
    "${ProjDirPath}/../../../../../../../board.h"
    "${ProjDirPath}/../../../../../../../board.c"
    "${ProjDirPath}/../../../../../../../../../rtos/uCOSII/src/config/app_hooks.c"
    "${ProjDirPath}/../../../../../../../../../rtos/uCOSII/src/uCOS-II/Source/os_core.c"
    "${ProjDirPath}/../../../../../../../../../rtos/uCOSII/src/uCOS-II/Source/os_flag.c"
    "${ProjDirPath}/../../../../../../../../../rtos/uCOSII/src/uCOS-II/Source/os_mbox.c"
    "${ProjDirPath}/../../../../../../../../../rtos/uCOSII/src/uCOS-II/Source/os_mem.c"
    "${ProjDirPath}/../../../../../../../../../rtos/uCOSII/src/uCOS-II/Source/os_mutex.c"
    "${ProjDirPath}/../../../../../../../../../rtos/uCOSII/src/uCOS-II/Source/os_q.c"
    "${ProjDirPath}/../../../../../../../../../rtos/uCOSII/src/uCOS-II/Source/os_sem.c"
    "${ProjDirPath}/../../../../../../../../../rtos/uCOSII/src/uCOS-II/Source/os_task.c"
    "${ProjDirPath}/../../../../../../../../../rtos/uCOSII/src/uCOS-II/Source/os_time.c"
    "${ProjDirPath}/../../../../../../../../../rtos/uCOSII/src/uCOS-II/Source/os_tmr.c"
    "${ProjDirPath}/../../../../../../../../../platform/utilities/src/fsl_debug_console.c"
    "${ProjDirPath}/../../../../../../../../../platform/utilities/inc/fsl_debug_console.h"
    "${ProjDirPath}/../../../../../../../../../platform/utilities/src/print_scan.c"
    "${ProjDirPath}/../../../../../../../../../platform/utilities/src/print_scan.h"
    "${ProjDirPath}/../../../../../../../../../platform/devices/MK24F25612/startup/system_MK24F25612.c"
    "${ProjDirPath}/../../../../../../../../../platform/devices/startup.c"
    "${ProjDirPath}/../../../../../../../../../platform/devices/startup.h"
)
SET_TARGET_PROPERTIES(dev_audio_speaker_ucosii PROPERTIES OUTPUT_NAME "dev_audio_speaker_ucosii.elf")

TARGET_LINK_LIBRARIES(dev_audio_speaker_ucosii -Wl,--start-group)
# LIBRARIES
IF(CMAKE_BUILD_TYPE MATCHES Debug)
    TARGET_LINK_LIBRARIES(dev_audio_speaker_ucosii ${ProjDirPath}/../../../../../../../../../usb/usb_core/device/lib/ucosii/armgcc/MK24F25612/debug/libusbd_ucosii.a)
    TARGET_LINK_LIBRARIES(dev_audio_speaker_ucosii ${ProjDirPath}/../../../../../../../../../lib/ksdk_ucosii_lib/armgcc/K24F25612/debug/libksdk_platform_ucosii.a)
ELSEIF(CMAKE_BUILD_TYPE MATCHES Release)
    TARGET_LINK_LIBRARIES(dev_audio_speaker_ucosii ${ProjDirPath}/../../../../../../../../../usb/usb_core/device/lib/ucosii/armgcc/MK24F25612/release/libusbd_ucosii.a)
    TARGET_LINK_LIBRARIES(dev_audio_speaker_ucosii ${ProjDirPath}/../../../../../../../../../lib/ksdk_ucosii_lib/armgcc/K24F25612/release/libksdk_platform_ucosii.a)
ENDIF()

# SYSTEM LIBRARIES
TARGET_LINK_LIBRARIES(dev_audio_speaker_ucosii m)
TARGET_LINK_LIBRARIES(dev_audio_speaker_ucosii c)
TARGET_LINK_LIBRARIES(dev_audio_speaker_ucosii gcc)
TARGET_LINK_LIBRARIES(dev_audio_speaker_ucosii nosys)
TARGET_LINK_LIBRARIES(dev_audio_speaker_ucosii -Wl,--end-group)

# MAP FILE
SET(CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS_DEBUG}  -Xlinker -Map=debug/dev_audio_speaker_ucosii.map")
SET(CMAKE_EXE_LINKER_FLAGS_RELEASE "${CMAKE_EXE_LINKER_FLAGS_RELEASE}  -Xlinker -Map=release/dev_audio_speaker_ucosii.map")

# BIN AND HEX
ADD_CUSTOM_COMMAND(TARGET dev_audio_speaker_ucosii POST_BUILD COMMAND ${CMAKE_OBJCOPY} -Oihex ${EXECUTABLE_OUTPUT_PATH}/dev_audio_speaker_ucosii.elf ${EXECUTABLE_OUTPUT_PATH}/dev_audio_speaker_ucosii.hex)
ADD_CUSTOM_COMMAND(TARGET dev_audio_speaker_ucosii POST_BUILD COMMAND ${CMAKE_OBJCOPY} -Obinary ${EXECUTABLE_OUTPUT_PATH}/dev_audio_speaker_ucosii.elf ${EXECUTABLE_OUTPUT_PATH}/dev_audio_speaker_ucosii.bin)
