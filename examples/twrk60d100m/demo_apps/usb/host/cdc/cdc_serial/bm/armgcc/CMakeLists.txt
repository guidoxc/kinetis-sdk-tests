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
set(CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS_DEBUG} -T${ProjDirPath}/../../../../../../../../../platform/devices/MK60D10/linker/gcc/MK60DN512xxx10_flash.ld  -static")

# RELEASE LINK FILE
set(CMAKE_EXE_LINKER_FLAGS_RELEASE "${CMAKE_EXE_LINKER_FLAGS_RELEASE} -T${ProjDirPath}/../../../../../../../../../platform/devices/MK60D10/linker/gcc/MK60DN512xxx10_flash.ld  -static")

# DEBUG ASM FLAGS
SET(CMAKE_ASM_FLAGS_DEBUG "${CMAKE_ASM_FLAGS_DEBUG} -g  -mcpu=cortex-m4  -mfloat-abi=soft  -mthumb  -Wall  -fno-common  -ffunction-sections  -fdata-sections  -ffreestanding  -fno-builtin  -mapcs  -std=gnu99")

# DEBUG C FLAGS
SET(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -g  -O0  -Wno-format  -fno-strict-aliasing  -mcpu=cortex-m4  -mfloat-abi=soft  -mthumb  -MMD  -MP  -Wall  -fno-common  -ffunction-sections  -fdata-sections  -ffreestanding  -fno-builtin  -mapcs  -std=gnu99")

# DEBUG LD FLAGS
SET(CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS_DEBUG} -g  -Xlinker --defsym=__ram_vector_table__=1  -mcpu=cortex-m4  -mfloat-abi=soft  --specs=nano.specs  -lm  -Wall  -fno-common  -ffunction-sections  -fdata-sections  -ffreestanding  -fno-builtin  -mthumb  -mapcs  -Xlinker --gc-sections  -Xlinker -static  -Xlinker -z  -Xlinker muldefs  -Xlinker --defsym=__stack_size__=0x4000  -Xlinker --defsym=__heap_size__=0x8000")

# RELEASE ASM FLAGS
SET(CMAKE_ASM_FLAGS_RELEASE "${CMAKE_ASM_FLAGS_RELEASE} -mcpu=cortex-m4  -mfloat-abi=soft  -mthumb  -Wall  -fno-common  -ffunction-sections  -fdata-sections  -ffreestanding  -fno-builtin  -mapcs  -std=gnu99")

# RELEASE C FLAGS
SET(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -Os  -Wno-format  -fno-strict-aliasing  -mcpu=cortex-m4  -mfloat-abi=soft  -mthumb  -MMD  -MP  -Wall  -fno-common  -ffunction-sections  -fdata-sections  -ffreestanding  -fno-builtin  -mapcs  -std=gnu99")

# RELEASE LD FLAGS
SET(CMAKE_EXE_LINKER_FLAGS_RELEASE "${CMAKE_EXE_LINKER_FLAGS_RELEASE} -Xlinker --defsym=__ram_vector_table__=1  -mcpu=cortex-m4  -mfloat-abi=soft  --specs=nano.specs  -lm  -Wall  -fno-common  -ffunction-sections  -fdata-sections  -ffreestanding  -fno-builtin  -mthumb  -mapcs  -Xlinker --gc-sections  -Xlinker -static  -Xlinker -z  -Xlinker muldefs  -Xlinker --defsym=__stack_size__=0x4000  -Xlinker --defsym=__heap_size__=0x8000")

# ASM MACRO
SET(CMAKE_ASM_FLAGS_DEBUG "${CMAKE_ASM_FLAGS_DEBUG}  -DDEBUG")

# C MACRO
SET(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG}  -D_DEBUG=1")
SET(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG}  -DCPU_MK60DN512VMD10")
SET(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG}  -DTWR_K60D100M")
SET(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG}  -DTOWER")
SET(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE}  -D_DEBUG=0")
SET(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE}  -DCPU_MK60DN512VMD10")
SET(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE}  -DTWR_K60D100M")
SET(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE}  -DTOWER")

# CXX MACRO

# INCLUDE_DIRECTORIES
IF(CMAKE_BUILD_TYPE MATCHES Debug)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/osa/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../rtos)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/utilities/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/CMSIS/Include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/devices)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/devices/MK60D10/include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/devices/MK60D10/startup)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../..)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/adapter/sources)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/adapter/sources/sdk)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/device/include/MK60D10)
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
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/include/MK60D10)
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
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/drivers/src/i2c)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/facility/include)
ELSEIF(CMAKE_BUILD_TYPE MATCHES Release)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/osa/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../rtos)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/utilities/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/CMSIS/Include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/devices)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/devices/MK60D10/include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/devices/MK60D10/startup)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../..)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/adapter/sources)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/adapter/sources/sdk)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/device/include/MK60D10)
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
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/include/MK60D10)
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
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/drivers/src/i2c)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/facility/include)
ENDIF()

# ADD_EXECUTABLE
ADD_EXECUTABLE(host_cdc_serial_bm 
    "${ProjDirPath}/../../../../../../../../../platform/utilities/src/fsl_misc_utilities.c"
    "${ProjDirPath}/../../../../../../../../../platform/devices/MK60D10/startup/gcc/startup_MK60D10.S"
    "${ProjDirPath}/../../../../../../../../../usb/facility/include/usb_uart_drv.h"
    "${ProjDirPath}/../../../../../../../../../usb/facility/uart/usb_uart_drv.c"
    "${ProjDirPath}/../../cdc_serial.c"
    "${ProjDirPath}/../../cdc_serial.h"
    "${ProjDirPath}/../../usb_host_cdc_io.c"
    "${ProjDirPath}/../../usb_host_cdc_io.h"
    "${ProjDirPath}/../../hardware_init.c"
    "${ProjDirPath}/../../../../../../../gpio_pins.c"
    "${ProjDirPath}/../../../../../../../gpio_pins.h"
    "${ProjDirPath}/../../../../../../../pin_mux.c"
    "${ProjDirPath}/../../../../../../../pin_mux.h"
    "${ProjDirPath}/../../../../../../../board.h"
    "${ProjDirPath}/../../../../../../../board.c"
    "${ProjDirPath}/../../../../../../../../../platform/utilities/src/fsl_debug_console.c"
    "${ProjDirPath}/../../../../../../../../../platform/utilities/inc/fsl_debug_console.h"
    "${ProjDirPath}/../../../../../../../../../platform/utilities/src/print_scan.c"
    "${ProjDirPath}/../../../../../../../../../platform/utilities/src/print_scan.h"
    "${ProjDirPath}/../../../../../../../../../platform/devices/MK60D10/startup/system_MK60D10.c"
    "${ProjDirPath}/../../../../../../../../../platform/devices/startup.c"
    "${ProjDirPath}/../../../../../../../../../platform/devices/startup.h"
)
SET_TARGET_PROPERTIES(host_cdc_serial_bm PROPERTIES OUTPUT_NAME "host_cdc_serial_bm.elf")

TARGET_LINK_LIBRARIES(host_cdc_serial_bm -Wl,--start-group)
# LIBRARIES
IF(CMAKE_BUILD_TYPE MATCHES Debug)
    TARGET_LINK_LIBRARIES(host_cdc_serial_bm ${ProjDirPath}/../../../../../../../../../usb/usb_core/host/lib/bm/armgcc/MK60D10/debug/libusbh_bm.a)
    TARGET_LINK_LIBRARIES(host_cdc_serial_bm ${ProjDirPath}/../../../../../../../../../lib/ksdk_platform_lib/armgcc/K60D10/debug/libksdk_platform.a)
ELSEIF(CMAKE_BUILD_TYPE MATCHES Release)
    TARGET_LINK_LIBRARIES(host_cdc_serial_bm ${ProjDirPath}/../../../../../../../../../usb/usb_core/host/lib/bm/armgcc/MK60D10/release/libusbh_bm.a)
    TARGET_LINK_LIBRARIES(host_cdc_serial_bm ${ProjDirPath}/../../../../../../../../../lib/ksdk_platform_lib/armgcc/K60D10/release/libksdk_platform.a)
ENDIF()

# SYSTEM LIBRARIES
TARGET_LINK_LIBRARIES(host_cdc_serial_bm m)
TARGET_LINK_LIBRARIES(host_cdc_serial_bm c)
TARGET_LINK_LIBRARIES(host_cdc_serial_bm gcc)
TARGET_LINK_LIBRARIES(host_cdc_serial_bm nosys)
TARGET_LINK_LIBRARIES(host_cdc_serial_bm -Wl,--end-group)

# MAP FILE
SET(CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS_DEBUG}  -Xlinker -Map=debug/host_cdc_serial_bm.map")
SET(CMAKE_EXE_LINKER_FLAGS_RELEASE "${CMAKE_EXE_LINKER_FLAGS_RELEASE}  -Xlinker -Map=release/host_cdc_serial_bm.map")

# BIN AND HEX
ADD_CUSTOM_COMMAND(TARGET host_cdc_serial_bm POST_BUILD COMMAND ${CMAKE_OBJCOPY} -Oihex ${EXECUTABLE_OUTPUT_PATH}/host_cdc_serial_bm.elf ${EXECUTABLE_OUTPUT_PATH}/host_cdc_serial_bm.hex)
ADD_CUSTOM_COMMAND(TARGET host_cdc_serial_bm POST_BUILD COMMAND ${CMAKE_OBJCOPY} -Obinary ${EXECUTABLE_OUTPUT_PATH}/host_cdc_serial_bm.elf ${EXECUTABLE_OUTPUT_PATH}/host_cdc_serial_bm.bin)
