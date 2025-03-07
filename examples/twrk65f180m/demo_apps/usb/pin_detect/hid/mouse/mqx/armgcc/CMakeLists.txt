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
set(CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS_DEBUG} -T${ProjDirPath}/../../../../../../../../../platform/devices/MK65F18/linker/gcc/MK65FN2M0xxx18_flash.ld  -static")

# RELEASE LINK FILE
set(CMAKE_EXE_LINKER_FLAGS_RELEASE "${CMAKE_EXE_LINKER_FLAGS_RELEASE} -T${ProjDirPath}/../../../../../../../../../platform/devices/MK65F18/linker/gcc/MK65FN2M0xxx18_flash.ld  -static")

# DEBUG ASM FLAGS
SET(CMAKE_ASM_FLAGS_DEBUG "${CMAKE_ASM_FLAGS_DEBUG} -g  -mcpu=cortex-m4  -mfloat-abi=hard  -mfpu=fpv4-sp-d16  -mthumb  -Wall  -fno-common  -ffunction-sections  -fdata-sections  -ffreestanding  -fno-builtin  -mapcs  -std=gnu99")

# DEBUG C FLAGS
SET(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -g  -O0  -Wno-format  -fno-strict-aliasing  -mcpu=cortex-m4  -mfloat-abi=hard  -mfpu=fpv4-sp-d16  -mthumb  -MMD  -MP  -Wall  -fno-common  -ffunction-sections  -fdata-sections  -ffreestanding  -fno-builtin  -mapcs  -std=gnu99")

# DEBUG LD FLAGS
SET(CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS_DEBUG} -g  -Xlinker --defsym=__ram_vector_table__=1  -Xlinker -z -Xlinker muldefs  -Xlinker -static  -Xlinker -cref  -nostartfiles  -Xlinker --undefined=__isr_vector  -lc  -lgcc    -mcpu=cortex-m4  -mfloat-abi=hard  -mfpu=fpv4-sp-d16    -lm  -Wall  -fno-common  -ffunction-sections  -fdata-sections  -ffreestanding  -fno-builtin  -mthumb  -mapcs  -Xlinker --gc-sections  -Xlinker -z  -Xlinker muldefs  -Xlinker --defsym=__stack_size__=0x4000  -Xlinker --defsym=__heap_size__=0x8000")

# RELEASE ASM FLAGS
SET(CMAKE_ASM_FLAGS_RELEASE "${CMAKE_ASM_FLAGS_RELEASE} -mcpu=cortex-m4  -mfloat-abi=hard  -mfpu=fpv4-sp-d16  -mthumb  -Wall  -fno-common  -ffunction-sections  -fdata-sections  -ffreestanding  -fno-builtin  -mapcs  -std=gnu99")

# RELEASE C FLAGS
SET(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -Os  -Wno-format  -fno-strict-aliasing  -mcpu=cortex-m4  -mfloat-abi=hard  -mfpu=fpv4-sp-d16  -mthumb  -MMD  -MP  -Wall  -fno-common  -ffunction-sections  -fdata-sections  -ffreestanding  -fno-builtin  -mapcs  -std=gnu99")

# RELEASE LD FLAGS
SET(CMAKE_EXE_LINKER_FLAGS_RELEASE "${CMAKE_EXE_LINKER_FLAGS_RELEASE} -Xlinker --defsym=__ram_vector_table__=1  -Xlinker -z -Xlinker muldefs  -Xlinker -static  -Xlinker -cref  -nostartfiles  -Xlinker --undefined=__isr_vector  -lc  -lgcc    -mcpu=cortex-m4  -mfloat-abi=hard  -mfpu=fpv4-sp-d16    -lm  -Wall  -fno-common  -ffunction-sections  -fdata-sections  -ffreestanding  -fno-builtin  -mthumb  -mapcs  -Xlinker --gc-sections  -Xlinker -z  -Xlinker muldefs  -Xlinker --defsym=__stack_size__=0x4000  -Xlinker --defsym=__heap_size__=0x8000")

# ASM MACRO
SET(CMAKE_ASM_FLAGS_DEBUG "${CMAKE_ASM_FLAGS_DEBUG}  -DDEBUG")

# C MACRO
SET(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG}  -D_DEBUG=1")
SET(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG}  -D_AEABI_LC_CTYPE=C")
SET(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG}  -D__STRICT_ANSI__=1")
SET(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG}  -DCPU_MK65FN2M0VMI18")
SET(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG}  -DFSL_RTOS_MQX")
SET(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG}  -DTWR_K65F180M")
SET(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG}  -DTOWER")
SET(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE}  -D_DEBUG=0")
SET(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE}  -D_AEABI_LC_CTYPE=C")
SET(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE}  -D__STRICT_ANSI__=1")
SET(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE}  -DCPU_MK65FN2M0VMI18")
SET(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE}  -DFSL_RTOS_MQX")
SET(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE}  -DTWR_K65F180M")
SET(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE}  -DTOWER")

# CXX MACRO

# INCLUDE_DIRECTORIES
IF(CMAKE_BUILD_TYPE MATCHES Debug)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../rtos/mqx/lib/twrk65f180m.armgcc/debug)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../rtos/mqx/lib/twrk65f180m.armgcc/debug/config)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../rtos/mqx/lib/twrk65f180m.armgcc/debug/mqx)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../rtos/mqx/lib/twrk65f180m.armgcc/debug/mqx_stdlib)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/osa/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../rtos)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/utilities/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/CMSIS/Include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/devices)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/devices/MK65F18/include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/devices/MK65F18/startup)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../..)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/adapter/sources)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/adapter/sources/sdk)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/device/include/MK65F18)
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
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/device/sources/controller/ehci)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/device/sources/controller)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/hal)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/include/MK65F18)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/sources/classes/audio)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/sources/classes/cdc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/sources/classes/hid)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/sources/classes/hub)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/sources/classes/msd)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/sources/classes/phdc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/sources/classes/printer)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/sources/controller/khci)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/sources/controller/ehci)
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
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/drivers/src/sai)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/drivers/src/i2c)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../rtos/mqx/config/mcu/MK65F18)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../rtos/mqx/config/board/twrk65f180m)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../..)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/devices/MK65F18/include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/devices/MK65F18/startup)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/system/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/hal/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/drivers/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/drivers/src/mpu)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/startup)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../rtos/mqx/config/common)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../rtos/mqx/mqx/source/bsp)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../rtos/mqx/mqx/source/include)
ELSEIF(CMAKE_BUILD_TYPE MATCHES Release)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../rtos/mqx/lib/twrk65f180m.armgcc/release)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../rtos/mqx/lib/twrk65f180m.armgcc/release/config)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../rtos/mqx/lib/twrk65f180m.armgcc/release/mqx)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../rtos/mqx/lib/twrk65f180m.armgcc/release/mqx_stdlib)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/osa/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../rtos)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/utilities/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/CMSIS/Include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/devices)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/devices/MK65F18/include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/devices/MK65F18/startup)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../..)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/adapter/sources)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/adapter/sources/sdk)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/device/include/MK65F18)
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
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/device/sources/controller/ehci)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/device/sources/controller)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/hal)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/include/MK65F18)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/sources/classes/audio)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/sources/classes/cdc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/sources/classes/hid)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/sources/classes/hub)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/sources/classes/msd)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/sources/classes/phdc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/sources/classes/printer)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/sources/controller/khci)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../usb/usb_core/host/sources/controller/ehci)
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
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/drivers/src/sai)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/drivers/src/i2c)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../rtos/mqx/config/mcu/MK65F18)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../rtos/mqx/config/board/twrk65f180m)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../..)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/devices/MK65F18/include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/devices/MK65F18/startup)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/system/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/hal/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/drivers/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/drivers/src/mpu)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../platform/startup)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../rtos/mqx/config/common)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../rtos/mqx/mqx/source/bsp)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../../../rtos/mqx/mqx/source/include)
ENDIF()

# ADD_EXECUTABLE
ADD_EXECUTABLE(pin_detect_hid_mouse_mqx 
    "${ProjDirPath}/../../../../../../../../../platform/utilities/src/fsl_misc_utilities.c"
    "${ProjDirPath}/../../dev_mouse.c"
    "${ProjDirPath}/../../dev_mouse.h"
    "${ProjDirPath}/../../dev_mouse_api.h"
    "${ProjDirPath}/../../host_mouse.c"
    "${ProjDirPath}/../../host_mouse.h"
    "${ProjDirPath}/../../host_mouse_api.h"
    "${ProjDirPath}/../../pin_detect_mouse.c"
    "${ProjDirPath}/../../pin_detect_mouse.h"
    "${ProjDirPath}/../../usb_descriptor.c"
    "${ProjDirPath}/../../usb_descriptor.h"
    "${ProjDirPath}/../../hardware_init.c"
    "${ProjDirPath}/../../../../../../../gpio_pins.c"
    "${ProjDirPath}/../../../../../../../gpio_pins.h"
    "${ProjDirPath}/../../../../../../../pin_mux.c"
    "${ProjDirPath}/../../../../../../../pin_mux.h"
    "${ProjDirPath}/../../../../../../../board.h"
    "${ProjDirPath}/../../../../../../../board.c"
    "${ProjDirPath}/../../../../../../../../../rtos/mqx/mqx/source/bsp/bsp.h"
    "${ProjDirPath}/../../../../../../../../../rtos/mqx/mqx/source/bsp/bsp_config.h"
    "${ProjDirPath}/../../../../../../../../../rtos/mqx/mqx/source/bsp/init_bsp.c"
    "${ProjDirPath}/../../../../../../../../../rtos/mqx/mqx/source/include/mqx.h"
    "${ProjDirPath}/../../../../../../../../../rtos/mqx/mqx/source/bsp/mqx_main.c"
    "${ProjDirPath}/../../../../../../../../../rtos/mqx/config/common/small_ram_config.h"
    "${ProjDirPath}/../../../../../../../../../rtos/mqx/config/common/verif_enabled_config.h"
    "${ProjDirPath}/../../../../../../../../../rtos/mqx/config/mcu/MK65F18/mqx_sdk_config.h"
    "${ProjDirPath}/../../../../../../../../../rtos/mqx/config/board/twrk65f180m/user_config.h"
    "${ProjDirPath}/../../../../../../../../../platform/utilities/src/fsl_debug_console.c"
    "${ProjDirPath}/../../../../../../../../../platform/utilities/inc/fsl_debug_console.h"
    "${ProjDirPath}/../../../../../../../../../platform/utilities/src/print_scan.c"
    "${ProjDirPath}/../../../../../../../../../platform/utilities/src/print_scan.h"
)
SET_TARGET_PROPERTIES(pin_detect_hid_mouse_mqx PROPERTIES OUTPUT_NAME "pin_detect_hid_mouse_mqx.elf")

TARGET_LINK_LIBRARIES(pin_detect_hid_mouse_mqx -Wl,--start-group)
# LIBRARIES
IF(CMAKE_BUILD_TYPE MATCHES Debug)
    TARGET_LINK_LIBRARIES(pin_detect_hid_mouse_mqx ${ProjDirPath}/../../../../../../../../../usb/usb_core/host/lib/mqx/armgcc/MK65F18/debug/libusbh_mqx.a)
    TARGET_LINK_LIBRARIES(pin_detect_hid_mouse_mqx ${ProjDirPath}/../../../../../../../../../usb/usb_core/device/lib/mqx/armgcc/MK65F18/debug/libusbd_mqx.a)
    TARGET_LINK_LIBRARIES(pin_detect_hid_mouse_mqx ${ProjDirPath}/../../../../../../../../../lib/ksdk_mqx_lib/armgcc/K65F18/debug/libksdk_platform_mqx.a)
    TARGET_LINK_LIBRARIES(pin_detect_hid_mouse_mqx ${ProjDirPath}/../../../../../../../../../rtos/mqx/lib/twrk65f180m.armgcc/debug/mqx/lib_mqx.a)
    TARGET_LINK_LIBRARIES(pin_detect_hid_mouse_mqx ${ProjDirPath}/../../../../../../../../../rtos/mqx/lib/twrk65f180m.armgcc/debug/mqx_stdlib/lib_mqx_stdlib.a)
ELSEIF(CMAKE_BUILD_TYPE MATCHES Release)
    TARGET_LINK_LIBRARIES(pin_detect_hid_mouse_mqx ${ProjDirPath}/../../../../../../../../../usb/usb_core/host/lib/mqx/armgcc/MK65F18/release/libusbh_mqx.a)
    TARGET_LINK_LIBRARIES(pin_detect_hid_mouse_mqx ${ProjDirPath}/../../../../../../../../../usb/usb_core/device/lib/mqx/armgcc/MK65F18/release/libusbd_mqx.a)
    TARGET_LINK_LIBRARIES(pin_detect_hid_mouse_mqx ${ProjDirPath}/../../../../../../../../../lib/ksdk_mqx_lib/armgcc/K65F18/release/libksdk_platform_mqx.a)
    TARGET_LINK_LIBRARIES(pin_detect_hid_mouse_mqx ${ProjDirPath}/../../../../../../../../../rtos/mqx/lib/twrk65f180m.armgcc/release/mqx/lib_mqx.a)
    TARGET_LINK_LIBRARIES(pin_detect_hid_mouse_mqx ${ProjDirPath}/../../../../../../../../../rtos/mqx/lib/twrk65f180m.armgcc/release/mqx_stdlib/lib_mqx_stdlib.a)
ENDIF()

# SYSTEM LIBRARIES
TARGET_LINK_LIBRARIES(pin_detect_hid_mouse_mqx m)
TARGET_LINK_LIBRARIES(pin_detect_hid_mouse_mqx c)
TARGET_LINK_LIBRARIES(pin_detect_hid_mouse_mqx gcc)
TARGET_LINK_LIBRARIES(pin_detect_hid_mouse_mqx nosys)
TARGET_LINK_LIBRARIES(pin_detect_hid_mouse_mqx -Wl,--end-group)

# MAP FILE
SET(CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS_DEBUG}  -Xlinker -Map=debug/pin_detect_hid_mouse_mqx.map")
SET(CMAKE_EXE_LINKER_FLAGS_RELEASE "${CMAKE_EXE_LINKER_FLAGS_RELEASE}  -Xlinker -Map=release/pin_detect_hid_mouse_mqx.map")

# BIN AND HEX
ADD_CUSTOM_COMMAND(TARGET pin_detect_hid_mouse_mqx POST_BUILD COMMAND ${CMAKE_OBJCOPY} -Oihex ${EXECUTABLE_OUTPUT_PATH}/pin_detect_hid_mouse_mqx.elf ${EXECUTABLE_OUTPUT_PATH}/pin_detect_hid_mouse_mqx.hex)
ADD_CUSTOM_COMMAND(TARGET pin_detect_hid_mouse_mqx POST_BUILD COMMAND ${CMAKE_OBJCOPY} -Obinary ${EXECUTABLE_OUTPUT_PATH}/pin_detect_hid_mouse_mqx.elf ${EXECUTABLE_OUTPUT_PATH}/pin_detect_hid_mouse_mqx.bin)
