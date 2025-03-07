/*HEADER**********************************************************************
*
* Copyright 2008 Freescale Semiconductor, Inc.
* Copyright 1989-2008 ARC International
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
*   This file contains the task template list for this processor.
*
*
*END************************************************************************/

#include <mqx.h>
#include <bsp.h>
#include "server.h"

/* User stack size */
uint8_t  Server_task_stack[SERVER_TASK_STACK_SIZE];
uint8_t  Client_task_stack[NUM_CLIENTS][CLIENT_TASK_STACK_SIZE];

/* Function prototype*/
void server_task (uint32_t initial_data);
void client_task (uint32_t initial_data);

/* EOF */
