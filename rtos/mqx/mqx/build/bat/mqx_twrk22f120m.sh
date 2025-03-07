#!/usr/bin/env bash

# expect forward slash paths
ROOTDIR="${1}"
OUTPUTDIR="${2}"
TOOL="${3}"

if [ "${TOOL}" = "armgcc" ]; then
mkdir -p "${OUTPUTDIR}"
mkdir -p "${OUTPUTDIR}/."
mkdir -p "${OUTPUTDIR}/../config"
cp -f "${ROOTDIR}/mqx/source/psp/cortex_m/compiler/gcc_arm/asm_mac.h" "${OUTPUTDIR}/asm_mac.h"
cp -f "${ROOTDIR}/mqx/source/psp/cortex_m/compiler/gcc_arm/comp.h" "${OUTPUTDIR}/comp.h"
cp -f "${ROOTDIR}/mqx/source/psp/cortex_m/psp.h" "${OUTPUTDIR}/psp.h"
cp -f "${ROOTDIR}/mqx/source/psp/cortex_m/psp_abi.h" "${OUTPUTDIR}/psp_abi.h"
cp -f "${ROOTDIR}/mqx/source/psp/cortex_m/psp_comp.h" "${OUTPUTDIR}/psp_comp.h"
cp -f "${ROOTDIR}/mqx/source/psp/cortex_m/psp_math.h" "${OUTPUTDIR}/psp_math.h"
cp -f "${ROOTDIR}/mqx/source/psp/cortex_m/psp_prv.h" "${OUTPUTDIR}/psp_prv.h"
cp -f "${ROOTDIR}/mqx/source/psp/cortex_m/psp_rev.h" "${OUTPUTDIR}/psp_rev.h"
cp -f "${ROOTDIR}/mqx/source/psp/cortex_m/psp_supp.h" "${OUTPUTDIR}/psp_supp.h"
cp -f "${ROOTDIR}/mqx/source/psp/cortex_m/psp_time.h" "${OUTPUTDIR}/psp_time.h"
cp -f "${ROOTDIR}/mqx/source/psp/cortex_m/psptypes.h" "${OUTPUTDIR}/psptypes.h"
cp -f "${ROOTDIR}/mqx/source/psp/cortex_m/psp_cpu.h" "${OUTPUTDIR}/psp_cpu.h"
cp -f "${ROOTDIR}/mqx/source/psp/cortex_m/cortex.h" "${OUTPUTDIR}/cortex.h"
cp -f "${ROOTDIR}/mqx/source/psp/cortex_m/kinetis_mpu.h" "${OUTPUTDIR}/kinetis_mpu.h"
cp -f "${ROOTDIR}/mqx/source/psp/cortex_m/nvic.h" "${OUTPUTDIR}/nvic.h"
cp -f "${ROOTDIR}/mqx/source/psp/cortex_m/kinetis.h" "${OUTPUTDIR}/kinetis.h"
cp -f "${ROOTDIR}/mqx/source/psp/cortex_m/cpu/kinetis_fcan.h" "${OUTPUTDIR}/kinetis_fcan.h"
cp -f "${ROOTDIR}/config/common/small_ram_config.h" "${OUTPUTDIR}/small_ram_config.h"
cp -f "${ROOTDIR}/config/common/lite_config.h" "${OUTPUTDIR}/lite_config.h"
cp -f "${ROOTDIR}/config/common/verif_enabled_config.h" "${OUTPUTDIR}/verif_enabled_config.h"
cp -f "${ROOTDIR}/config/common/mqx_cnfg.h" "${OUTPUTDIR}/mqx_cnfg.h"
cp -f "${ROOTDIR}/config/mcu/MK22F51212/mqx_sdk_config.h" "${OUTPUTDIR}/../config/mqx_sdk_config.h"
cp -f "${ROOTDIR}/config/board/twrk22f120m/user_config.h" "${OUTPUTDIR}/../config/user_config.h"
cp -f "${ROOTDIR}/mqx/source/include/gen_rev.h" "${OUTPUTDIR}/gen_rev.h"
cp -f "${ROOTDIR}/mqx/source/include/eds.h" "${OUTPUTDIR}/eds.h"
cp -f "${ROOTDIR}/mqx/source/include/edserial.h" "${OUTPUTDIR}/edserial.h"
cp -f "${ROOTDIR}/mqx/source/include/event.h" "${OUTPUTDIR}/event.h"
cp -f "${ROOTDIR}/mqx/source/include/charq.h" "${OUTPUTDIR}/charq.h"
cp -f "${ROOTDIR}/mqx/source/include/klog.h" "${OUTPUTDIR}/klog.h"
cp -f "${ROOTDIR}/mqx/source/include/log.h" "${OUTPUTDIR}/log.h"
cp -f "${ROOTDIR}/mqx/source/include/lwsem.h" "${OUTPUTDIR}/lwsem.h"
cp -f "${ROOTDIR}/mqx/source/include/lwevent.h" "${OUTPUTDIR}/lwevent.h"
cp -f "${ROOTDIR}/mqx/source/include/lwlog.h" "${OUTPUTDIR}/lwlog.h"
cp -f "${ROOTDIR}/mqx/source/include/lwmem.h" "${OUTPUTDIR}/lwmem.h"
cp -f "${ROOTDIR}/mqx/source/include/tlsf.h" "${OUTPUTDIR}/tlsf.h"
cp -f "${ROOTDIR}/mqx/source/include/tlsfbits.h" "${OUTPUTDIR}/tlsfbits.h"
cp -f "${ROOTDIR}/mqx/source/include/tlsf_adaptation.h" "${OUTPUTDIR}/tlsf_adaptation.h"
cp -f "${ROOTDIR}/mqx/source/include/lwmsgq.h" "${OUTPUTDIR}/lwmsgq.h"
cp -f "${ROOTDIR}/mqx/source/include/lwtimer.h" "${OUTPUTDIR}/lwtimer.h"
cp -f "${ROOTDIR}/mqx/source/include/message.h" "${OUTPUTDIR}/message.h"
cp -f "${ROOTDIR}/mqx/source/include/mmu.h" "${OUTPUTDIR}/mmu.h"
cp -f "${ROOTDIR}/mqx/source/include/mqx.h" "${OUTPUTDIR}/mqx.h"
cp -f "${ROOTDIR}/mqx/source/include/mqx_cpudef.h" "${OUTPUTDIR}/mqx_cpudef.h"
cp -f "${ROOTDIR}/mqx/source/include/mqx_inc.h" "${OUTPUTDIR}/mqx_inc.h"
cp -f "${ROOTDIR}/mqx/source/include/mqx_ioc.h" "${OUTPUTDIR}/mqx_ioc.h"
cp -f "${ROOTDIR}/mqx/source/include/mqx_str.h" "${OUTPUTDIR}/mqx_str.h"
cp -f "${ROOTDIR}/mqx/source/include/mqx_macros.h" "${OUTPUTDIR}/mqx_macros.h"
cp -f "${ROOTDIR}/mqx/source/include/mutex.h" "${OUTPUTDIR}/mutex.h"
cp -f "${ROOTDIR}/mqx/source/include/name.h" "${OUTPUTDIR}/name.h"
cp -f "${ROOTDIR}/mqx/source/include/partition.h" "${OUTPUTDIR}/partition.h"
cp -f "${ROOTDIR}/mqx/source/include/pcb.h" "${OUTPUTDIR}/pcb.h"
cp -f "${ROOTDIR}/mqx/source/include/psptypes_legacy.h" "${OUTPUTDIR}/psptypes_legacy.h"
cp -f "${ROOTDIR}/mqx/source/include/queue.h" "${OUTPUTDIR}/queue.h"
cp -f "${ROOTDIR}/mqx/source/include/sem.h" "${OUTPUTDIR}/sem.h"
cp -f "${ROOTDIR}/mqx/source/include/timer.h" "${OUTPUTDIR}/timer.h"
cp -f "${ROOTDIR}/mqx/source/include/watchdog.h" "${OUTPUTDIR}/watchdog.h"
cp -f "${ROOTDIR}/mqx/source/include/task.h" "${OUTPUTDIR}/task.h"
cp -f "${ROOTDIR}/mqx/source/nio/nio.h" "${OUTPUTDIR}/nio.h"
cp -f "${ROOTDIR}/mqx/source/nio/unistd.h" "${OUTPUTDIR}/unistd.h"
cp -f "${ROOTDIR}/mqx/source/nio/ioctl.h" "${OUTPUTDIR}/ioctl.h"
cp -f "${ROOTDIR}/mqx/source/nio/fcntl.h" "${OUTPUTDIR}/fcntl.h"
cp -f "${ROOTDIR}/mqx/source/nio/fs/fs_supp.h" "${OUTPUTDIR}/fs_supp.h"
cp -f "${ROOTDIR}/mqx/source/nio/drivers/nio_dummy/nio_dummy.h" "${OUTPUTDIR}/nio_dummy.h"
cp -f "${ROOTDIR}/mqx/source/nio/drivers/nio_mem/nio_mem.h" "${OUTPUTDIR}/nio_mem.h"
cp -f "${ROOTDIR}/mqx/source/nio/drivers/nio_null/nio_null.h" "${OUTPUTDIR}/nio_null.h"
cp -f "${ROOTDIR}/mqx/source/nio/drivers/nio_pipe/nio_pipe.h" "${OUTPUTDIR}/nio_pipe.h"
cp -f "${ROOTDIR}/mqx/source/nio/drivers/nio_serial/nio_serial.h" "${OUTPUTDIR}/nio_serial.h"
cp -f "${ROOTDIR}/mqx/source/nio/drivers/nio_tfs/nio_tfs.h" "${OUTPUTDIR}/nio_tfs.h"
cp -f "${ROOTDIR}/mqx/source/nio/drivers/nio_tty/nio_tty.h" "${OUTPUTDIR}/nio_tty.h"
cp -f "${ROOTDIR}/mqx/source/tad/tad.h" "${OUTPUTDIR}/tad.h"
cp -f "${ROOTDIR}/mqx/source/include/tlsf.h" "${OUTPUTDIR}/tlsf.h"
cp -f "${ROOTDIR}/mqx/source/include/tlsf_adaptation.h" "${OUTPUTDIR}/tlsf_adaptation.h"
cp -f "${ROOTDIR}/mqx/source/include/tlsfbits.h" "${OUTPUTDIR}/tlsfbits.h"
:
fi


if [ "${TOOL}" = "kds" ]; then
mkdir -p "${OUTPUTDIR}"
mkdir -p "${OUTPUTDIR}/."
mkdir -p "${OUTPUTDIR}/../config"
cp -f "${ROOTDIR}/mqx/source/psp/cortex_m/compiler/gcc_arm/asm_mac.h" "${OUTPUTDIR}/asm_mac.h"
cp -f "${ROOTDIR}/mqx/source/psp/cortex_m/compiler/gcc_arm/comp.h" "${OUTPUTDIR}/comp.h"
cp -f "${ROOTDIR}/mqx/source/psp/cortex_m/psp.h" "${OUTPUTDIR}/psp.h"
cp -f "${ROOTDIR}/mqx/source/psp/cortex_m/psp_abi.h" "${OUTPUTDIR}/psp_abi.h"
cp -f "${ROOTDIR}/mqx/source/psp/cortex_m/psp_comp.h" "${OUTPUTDIR}/psp_comp.h"
cp -f "${ROOTDIR}/mqx/source/psp/cortex_m/psp_math.h" "${OUTPUTDIR}/psp_math.h"
cp -f "${ROOTDIR}/mqx/source/psp/cortex_m/psp_prv.h" "${OUTPUTDIR}/psp_prv.h"
cp -f "${ROOTDIR}/mqx/source/psp/cortex_m/psp_rev.h" "${OUTPUTDIR}/psp_rev.h"
cp -f "${ROOTDIR}/mqx/source/psp/cortex_m/psp_supp.h" "${OUTPUTDIR}/psp_supp.h"
cp -f "${ROOTDIR}/mqx/source/psp/cortex_m/psp_time.h" "${OUTPUTDIR}/psp_time.h"
cp -f "${ROOTDIR}/mqx/source/psp/cortex_m/psptypes.h" "${OUTPUTDIR}/psptypes.h"
cp -f "${ROOTDIR}/mqx/source/psp/cortex_m/psp_cpu.h" "${OUTPUTDIR}/psp_cpu.h"
cp -f "${ROOTDIR}/mqx/source/psp/cortex_m/cortex.h" "${OUTPUTDIR}/cortex.h"
cp -f "${ROOTDIR}/mqx/source/psp/cortex_m/kinetis_mpu.h" "${OUTPUTDIR}/kinetis_mpu.h"
cp -f "${ROOTDIR}/mqx/source/psp/cortex_m/nvic.h" "${OUTPUTDIR}/nvic.h"
cp -f "${ROOTDIR}/mqx/source/psp/cortex_m/kinetis.h" "${OUTPUTDIR}/kinetis.h"
cp -f "${ROOTDIR}/mqx/source/psp/cortex_m/cpu/kinetis_fcan.h" "${OUTPUTDIR}/kinetis_fcan.h"
cp -f "${ROOTDIR}/config/common/small_ram_config.h" "${OUTPUTDIR}/small_ram_config.h"
cp -f "${ROOTDIR}/config/common/lite_config.h" "${OUTPUTDIR}/lite_config.h"
cp -f "${ROOTDIR}/config/common/verif_enabled_config.h" "${OUTPUTDIR}/verif_enabled_config.h"
cp -f "${ROOTDIR}/config/common/mqx_cnfg.h" "${OUTPUTDIR}/mqx_cnfg.h"
cp -f "${ROOTDIR}/config/mcu/MK22F51212/mqx_sdk_config.h" "${OUTPUTDIR}/../config/mqx_sdk_config.h"
cp -f "${ROOTDIR}/config/board/twrk22f120m/user_config.h" "${OUTPUTDIR}/../config/user_config.h"
cp -f "${ROOTDIR}/mqx/source/include/gen_rev.h" "${OUTPUTDIR}/gen_rev.h"
cp -f "${ROOTDIR}/mqx/source/include/eds.h" "${OUTPUTDIR}/eds.h"
cp -f "${ROOTDIR}/mqx/source/include/edserial.h" "${OUTPUTDIR}/edserial.h"
cp -f "${ROOTDIR}/mqx/source/include/event.h" "${OUTPUTDIR}/event.h"
cp -f "${ROOTDIR}/mqx/source/include/charq.h" "${OUTPUTDIR}/charq.h"
cp -f "${ROOTDIR}/mqx/source/include/klog.h" "${OUTPUTDIR}/klog.h"
cp -f "${ROOTDIR}/mqx/source/include/log.h" "${OUTPUTDIR}/log.h"
cp -f "${ROOTDIR}/mqx/source/include/lwsem.h" "${OUTPUTDIR}/lwsem.h"
cp -f "${ROOTDIR}/mqx/source/include/lwevent.h" "${OUTPUTDIR}/lwevent.h"
cp -f "${ROOTDIR}/mqx/source/include/lwlog.h" "${OUTPUTDIR}/lwlog.h"
cp -f "${ROOTDIR}/mqx/source/include/lwmem.h" "${OUTPUTDIR}/lwmem.h"
cp -f "${ROOTDIR}/mqx/source/include/tlsf.h" "${OUTPUTDIR}/tlsf.h"
cp -f "${ROOTDIR}/mqx/source/include/tlsfbits.h" "${OUTPUTDIR}/tlsfbits.h"
cp -f "${ROOTDIR}/mqx/source/include/tlsf_adaptation.h" "${OUTPUTDIR}/tlsf_adaptation.h"
cp -f "${ROOTDIR}/mqx/source/include/lwmsgq.h" "${OUTPUTDIR}/lwmsgq.h"
cp -f "${ROOTDIR}/mqx/source/include/lwtimer.h" "${OUTPUTDIR}/lwtimer.h"
cp -f "${ROOTDIR}/mqx/source/include/message.h" "${OUTPUTDIR}/message.h"
cp -f "${ROOTDIR}/mqx/source/include/mmu.h" "${OUTPUTDIR}/mmu.h"
cp -f "${ROOTDIR}/mqx/source/include/mqx.h" "${OUTPUTDIR}/mqx.h"
cp -f "${ROOTDIR}/mqx/source/include/mqx_cpudef.h" "${OUTPUTDIR}/mqx_cpudef.h"
cp -f "${ROOTDIR}/mqx/source/include/mqx_inc.h" "${OUTPUTDIR}/mqx_inc.h"
cp -f "${ROOTDIR}/mqx/source/include/mqx_ioc.h" "${OUTPUTDIR}/mqx_ioc.h"
cp -f "${ROOTDIR}/mqx/source/include/mqx_str.h" "${OUTPUTDIR}/mqx_str.h"
cp -f "${ROOTDIR}/mqx/source/include/mqx_macros.h" "${OUTPUTDIR}/mqx_macros.h"
cp -f "${ROOTDIR}/mqx/source/include/mutex.h" "${OUTPUTDIR}/mutex.h"
cp -f "${ROOTDIR}/mqx/source/include/name.h" "${OUTPUTDIR}/name.h"
cp -f "${ROOTDIR}/mqx/source/include/partition.h" "${OUTPUTDIR}/partition.h"
cp -f "${ROOTDIR}/mqx/source/include/pcb.h" "${OUTPUTDIR}/pcb.h"
cp -f "${ROOTDIR}/mqx/source/include/psptypes_legacy.h" "${OUTPUTDIR}/psptypes_legacy.h"
cp -f "${ROOTDIR}/mqx/source/include/queue.h" "${OUTPUTDIR}/queue.h"
cp -f "${ROOTDIR}/mqx/source/include/sem.h" "${OUTPUTDIR}/sem.h"
cp -f "${ROOTDIR}/mqx/source/include/timer.h" "${OUTPUTDIR}/timer.h"
cp -f "${ROOTDIR}/mqx/source/include/watchdog.h" "${OUTPUTDIR}/watchdog.h"
cp -f "${ROOTDIR}/mqx/source/include/task.h" "${OUTPUTDIR}/task.h"
cp -f "${ROOTDIR}/mqx/source/nio/nio.h" "${OUTPUTDIR}/nio.h"
cp -f "${ROOTDIR}/mqx/source/nio/unistd.h" "${OUTPUTDIR}/unistd.h"
cp -f "${ROOTDIR}/mqx/source/nio/ioctl.h" "${OUTPUTDIR}/ioctl.h"
cp -f "${ROOTDIR}/mqx/source/nio/fcntl.h" "${OUTPUTDIR}/fcntl.h"
cp -f "${ROOTDIR}/mqx/source/nio/fs/fs_supp.h" "${OUTPUTDIR}/fs_supp.h"
cp -f "${ROOTDIR}/mqx/source/nio/drivers/nio_dummy/nio_dummy.h" "${OUTPUTDIR}/nio_dummy.h"
cp -f "${ROOTDIR}/mqx/source/nio/drivers/nio_mem/nio_mem.h" "${OUTPUTDIR}/nio_mem.h"
cp -f "${ROOTDIR}/mqx/source/nio/drivers/nio_null/nio_null.h" "${OUTPUTDIR}/nio_null.h"
cp -f "${ROOTDIR}/mqx/source/nio/drivers/nio_pipe/nio_pipe.h" "${OUTPUTDIR}/nio_pipe.h"
cp -f "${ROOTDIR}/mqx/source/nio/drivers/nio_serial/nio_serial.h" "${OUTPUTDIR}/nio_serial.h"
cp -f "${ROOTDIR}/mqx/source/nio/drivers/nio_tfs/nio_tfs.h" "${OUTPUTDIR}/nio_tfs.h"
cp -f "${ROOTDIR}/mqx/source/nio/drivers/nio_tty/nio_tty.h" "${OUTPUTDIR}/nio_tty.h"
cp -f "${ROOTDIR}/mqx/source/tad/tad.h" "${OUTPUTDIR}/tad.h"
cp -f "${ROOTDIR}/mqx/source/include/tlsf.h" "${OUTPUTDIR}/tlsf.h"
cp -f "${ROOTDIR}/mqx/source/include/tlsf_adaptation.h" "${OUTPUTDIR}/tlsf_adaptation.h"
cp -f "${ROOTDIR}/mqx/source/include/tlsfbits.h" "${OUTPUTDIR}/tlsfbits.h"
:
fi




