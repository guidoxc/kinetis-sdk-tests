/*HEADER**********************************************************************
*
* Copyright 2014 Freescale Semiconductor, Inc.
*
* This software is owned or controlled by Freescale Semiconductor.
* Use of this software is governed by the Freescale MQX RTOS License
* distributed with this Material.
* See the MQX_RTOS_LICENSE file distributed for more details.
*
* Brief License Summary:
* This software is provided in source form for you to use free of charge,
* but it is not open source software. You are allowed to use this software
* but you cannot redistribute it or derivative works of it in source form.
* The software may be used only in connection with a product containing
* a Freescale microprocessor, microcontroller, or digital signal processor.
* See license agreement file for full license terms including other
* restrictions.
*****************************************************************************
*
* Comments:
*
*   SDK RTOS adapter configuration.
*
*END************************************************************************/

#ifndef __mqx_sdk_config_h__
#define __mqx_sdk_config_h__

/*Configuration options*/
#define MQX_LITE_CONFIG       1
#define MQX_SMALL_RAM_CONFIG  2
#define MQX_MAXIMUM_CONFIG    3

/* Select initial MQX configuration */
#define MQX_COMMON_CONFIG    MQX_SMALL_RAM_CONFIG


#define CMSIS_ENABLED                       1

#define MQX_USE_IDLE_TASK                   1
#define MQXCFG_ENABLE_FP                    1
#define MQX_TASK_DESTRUCTION                1

// #undef MQX_DISABLE_CONFIG_CHECK

#ifndef MQX_USE_IO_OLD
  #define MQX_USE_IO_OLD 0
#elif MQX_USE_IO_OLD
  #error This version of MQX does not support legacy IO (FIO). Please force MQX_USE_IO_OLD to 0 in user_config.h
#endif


/* Select one of common configurations according to project settings. */
#if MQX_COMMON_CONFIG == MQX_LITE_CONFIG
    #include "lite_config.h"
#elif MQX_COMMON_CONFIG == MQX_SMALL_RAM_CONFIG
    #include "small_ram_config.h"
#elif MQX_COMMON_CONFIG == MQX_MAXIMUM_CONFIG
    #include "maximum_config.h"
#endif

/*
** When MQX_USE_LWEVENT is defined as 1,
** then mqx will compile in the support code for light weight events.
*/
#ifndef MQX_USE_LWEVENT
#define MQX_USE_LWEVENT         1
#endif

/*
** When MQX_USE_LWMSGQ is defined as 1,
** then mqx will compile in the support code for light weight message queues.
*/
#ifndef MQX_USE_LWMSGQ
#define MQX_USE_LWMSGQ          1
#endif

/*
** When MQX_USE_MESSAGES is defined as 1,
** then mqx will compile in the support code for messages.
*/
#ifndef MQX_USE_MESSAGES
#define MQX_USE_MESSAGES        1
#endif

/*
** When MQX_USE_MUTEXES is defined as 1,
** then mqx will compile in the support code for mutex component.
*/
#ifndef MQX_USE_MUTEXES
#define MQX_USE_MUTEXES         1
#endif

/*
** When MQX_USE_TIMER is defined as 1,
** then mqx will compile in the support code for timer component.
*/
#ifndef MQX_USE_TIMER
#define MQX_USE_TIMER           1
#endif


/*
** Define of timing project
*/
#ifndef MQX_USE_UNCACHED_MEM
#define MQX_USE_UNCACHED_MEM    0
#else
#undef MQX_USE_UNCACHED_MEM
#define MQX_USE_UNCACHED_MEM    0
#endif

#ifndef MQX_USE_SEMAPHORES
#define MQX_USE_SEMAPHORES      1
#else
#undef MQX_USE_SEMAPHORES
#define MQX_USE_SEMAPHORES      1
#endif

#ifndef MQX_USE_LOGS
#define MQX_USE_LOGS            1
#else
#undef MQX_USE_LOGS
#define MQX_USE_LOGS            1
#endif

#ifndef MQX_KERNEL_LOGGING
#define MQX_KERNEL_LOGGING      1
#else
#undef MQX_KERNEL_LOGGING
#define MQX_KERNEL_LOGGING      1
#endif

#define BSP_DEFAULT_MAX_MSGQS    (62L)

/*
** and enable verification checks in kernel
*/
#include "verif_enabled_config.h"

#endif /* __mqx_sdk_config_h__ */
