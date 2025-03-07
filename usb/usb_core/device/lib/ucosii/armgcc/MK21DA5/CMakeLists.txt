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

# DEBUG ASM FLAGS
SET(CMAKE_ASM_FLAGS_DEBUG "${CMAKE_ASM_FLAGS_DEBUG}  -g  -mcpu=cortex-m4  -mfloat-abi=soft  -mthumb  -Wall  -fno-common  -ffunction-sections  -fdata-sections  -ffreestanding  -fno-builtin  -mapcs  -std=gnu99 ")

# DEBUG C FLAGS
SET(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -g  -O0  -Wno-format  -fno-strict-aliasing  -mcpu=cortex-m4  -mfloat-abi=soft  -mthumb  -MMD  -MP  -Wall  -fno-common  -ffunction-sections  -fdata-sections  -ffreestanding  -fno-builtin  -mapcs  -std=gnu99")

# RELEASE ASM FLAGS
SET(CMAKE_ASM_FLAGS_RELEASE "${CMAKE_ASM_FLAGS_RELEASE}  -mcpu=cortex-m4  -mfloat-abi=soft  -mthumb  -Wall  -fno-common  -ffunction-sections  -fdata-sections  -ffreestanding  -fno-builtin  -mapcs  -std=gnu99 ")

# RELEASE C FLAGS
SET(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -Os  -Wno-format  -fno-strict-aliasing  -mcpu=cortex-m4  -mfloat-abi=soft  -mthumb  -MMD  -MP  -Wall  -fno-common  -ffunction-sections  -fdata-sections  -ffreestanding  -fno-builtin  -mapcs  -std=gnu99")

# ASM MACRO
SET(CMAKE_ASM_FLAGS_DEBUG "${CMAKE_ASM_FLAGS_DEBUG}  -DDEBUG")

# C MACRO
SET(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG}  -D_DEBUG=1")
SET(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG}  -DCPU_MK21DN512AVMC5")
SET(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG}  -DFSL_RTOS_UCOSII")
SET(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE}  -D_DEBUG=0")
SET(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE}  -DCPU_MK21DN512AVMC5")
SET(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE}  -DFSL_RTOS_UCOSII")

# CXX MACRO

# INCLUDE_DIRECTORIES
IF(CMAKE_BUILD_TYPE MATCHES Debug)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../rtos/uCOSII/src/uCOS-II/Ports/ARM-Cortex-M4/Generic/GNU)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../rtos/uCOSII/src/uC-CPU/ARM-Cortex-M4/GNU)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../rtos)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../rtos/uCOSII/src/uCOS-II/Source)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../rtos/uCOSII/src/config)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../adapter/sources)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../adapter/sources/sdk)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../sources/classes/audio)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../sources/classes/cdc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../sources/classes/common)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../sources/classes/composite)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../sources/classes/hid)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../sources/classes/include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../sources/classes/include/config)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../sources/classes/msd)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../sources/classes/phdc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../sources/classes/video)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../sources/controller)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../sources/controller/khci)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../sources/controller/ehci)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../hal)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../platform/osa/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../platform/utilities/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../platform/CMSIS/Include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../platform/devices)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../platform/system/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../platform/hal/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../platform/drivers/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../platform/devices/MK21DA5/include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../platform/devices/MK21DA5/startup)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../platform/devices/MK21DA5)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../include/MK21DA5)
ELSEIF(CMAKE_BUILD_TYPE MATCHES Release)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../rtos/uCOSII/src/uCOS-II/Ports/ARM-Cortex-M4/Generic/GNU)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../rtos/uCOSII/src/uC-CPU/ARM-Cortex-M4/GNU)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../rtos)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../rtos/uCOSII/src/uCOS-II/Source)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../rtos/uCOSII/src/config)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../adapter/sources)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../adapter/sources/sdk)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../sources/classes/audio)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../sources/classes/cdc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../sources/classes/common)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../sources/classes/composite)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../sources/classes/hid)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../sources/classes/include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../sources/classes/include/config)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../sources/classes/msd)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../sources/classes/phdc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../sources/classes/video)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../sources/controller)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../sources/controller/khci)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../sources/controller/ehci)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../hal)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../platform/osa/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../platform/utilities/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../platform/CMSIS/Include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../platform/devices)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../platform/system/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../platform/hal/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../platform/drivers/inc)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../platform/devices/MK21DA5/include)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../platform/devices/MK21DA5/startup)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../../../../platform/devices/MK21DA5)
    INCLUDE_DIRECTORIES(${ProjDirPath}/../../../../include/MK21DA5)
ENDIF()

# ADD_LIBRARY
ADD_LIBRARY(KsdkUsbDeviceUcosiiLib STATIC
    "${ProjDirPath}/../../../../../../adapter/sources/adapter.h"
    "${ProjDirPath}/../../../../../../adapter/sources/adapter_types.h"
    "${ProjDirPath}/../../../../../../adapter/sources/sdk/adapter_cfg.h"
    "${ProjDirPath}/../../../../../../adapter/sources/sdk/adapter_sdk.c"
    "${ProjDirPath}/../../../../../../adapter/sources/sdk/adapter_sdk.h"
    "${ProjDirPath}/../../../../../include/compiler.h"
    "${ProjDirPath}/../../../../../include/types.h"
    "${ProjDirPath}/../../../../../include/usb.h"
    "${ProjDirPath}/../../../../../include/usb_desc.h"
    "${ProjDirPath}/../../../../../include/usb_error.h"
    "${ProjDirPath}/../../../../../include/usb_misc.h"
    "${ProjDirPath}/../../../../../include/usb_opt.h"
    "${ProjDirPath}/../../../../../include/usb_types.h"
    "${ProjDirPath}/../../../../include/usb_device_stack_interface.h"
    "${ProjDirPath}/../../../../sources/classes/include/usb_class.h"
    "${ProjDirPath}/../../../../sources/classes/include/usb_class_audio.h"
    "${ProjDirPath}/../../../../sources/classes/include/usb_class_cdc.h"
    "${ProjDirPath}/../../../../sources/classes/include/usb_class_composite.h"
    "${ProjDirPath}/../../../../sources/classes/include/usb_class_hid.h"
    "${ProjDirPath}/../../../../sources/classes/include/usb_class_msc.h"
    "${ProjDirPath}/../../../../sources/classes/include/usb_class_phdc.h"
    "${ProjDirPath}/../../../../sources/classes/include/usb_class_video.h"
    "${ProjDirPath}/../../../../sources/classes/common/usb_class.c"
    "${ProjDirPath}/../../../../sources/classes/common/usb_class_internal.h"
    "${ProjDirPath}/../../../../sources/classes/audio/usb_audio.c"
    "${ProjDirPath}/../../../../sources/classes/audio/usb_audio.h"
    "${ProjDirPath}/../../../../sources/classes/cdc/usb_cdc.c"
    "${ProjDirPath}/../../../../sources/classes/cdc/usb_cdc.h"
    "${ProjDirPath}/../../../../sources/classes/cdc/usb_cdc_pstn.c"
    "${ProjDirPath}/../../../../sources/classes/cdc/usb_cdc_pstn.h"
    "${ProjDirPath}/../../../../sources/classes/composite/usb_composite.c"
    "${ProjDirPath}/../../../../sources/classes/composite/usb_composite.h"
    "${ProjDirPath}/../../../../sources/classes/hid/usb_hid.c"
    "${ProjDirPath}/../../../../sources/classes/hid/usb_hid.h"
    "${ProjDirPath}/../../../../sources/classes/msd/usb_msc.c"
    "${ProjDirPath}/../../../../sources/classes/msd/usb_msc.h"
    "${ProjDirPath}/../../../../sources/classes/msd/usb_msc_scsi.c"
    "${ProjDirPath}/../../../../sources/classes/msd/usb_msc_scsi.h"
    "${ProjDirPath}/../../../../sources/classes/phdc/usb_phdc.c"
    "${ProjDirPath}/../../../../sources/classes/phdc/usb_phdc.h"
    "${ProjDirPath}/../../../../sources/classes/video/usb_video.c"
    "${ProjDirPath}/../../../../sources/classes/video/usb_video.h"
    "${ProjDirPath}/../../../../sources/controller/usb_dev.c"
    "${ProjDirPath}/../../../../sources/controller/usb_dev.h"
    "${ProjDirPath}/../../../../sources/controller/usb_framework.c"
    "${ProjDirPath}/../../../../sources/controller/usb_framework.h"
    "${ProjDirPath}/../../../../sources/controller/khci/device_khci_interface.c"
    "${ProjDirPath}/../../../../sources/controller/khci/khci_dev.c"
    "${ProjDirPath}/../../../../sources/controller/khci/khci_dev.h"
    "${ProjDirPath}/../../../../sources/controller/khci/khci_dev_misc.h"
    "${ProjDirPath}/../../../../include/MK21DA5/usb_device_config.h"
    "${ProjDirPath}/../../../../sources/bsp/MK21DA5/usb_dev_bsp.c"
)

SET_TARGET_PROPERTIES(KsdkUsbDeviceUcosiiLib PROPERTIES OUTPUT_NAME "libusbd_ucosii.a")
