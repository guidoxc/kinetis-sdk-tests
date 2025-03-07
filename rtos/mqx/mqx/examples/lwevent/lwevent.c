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
*   This file contains the source for the lwevent example program.
*
*
*END************************************************************************/

#include <stdio.h>
#include <mqx.h>
#include <bsp.h>
#include <lwevent.h>

/* Task IDs */
#define SERVICE_TASK 5
#define ISR_TASK     6

/* Function prototypes */
extern void simulated_ISR_task(uint32_t);
extern void service_task(uint32_t);

const TASK_TEMPLATE_STRUCT  MQX_template_list[] = 
{
   /* Task Index,   Function,           Stack,  Priority,   Name,            Attributes,          Param, Time Slice */
    { SERVICE_TASK, service_task,       1000,   8,          "service",       MQX_AUTO_START_TASK, 0,     0 },
    { ISR_TASK,     simulated_ISR_task, 1000,   8,          "simulated_ISR", 0,                   0,     0 },
    { 0 }
};

/* LW Event Definitions */
LWEVENT_STRUCT lwevent;

/*TASK*-----------------------------------------------------
* 
* Task Name    : simulated_ISR_task
* Comments     :
*    This task opens a connection to the event group. After
*    delaying, it sets the event bits.   
*END*-----------------------------------------------------*/

void simulated_ISR_task 
   (
      uint32_t initial_data
   )
{

   while (TRUE) {
      _time_delay_ticks(200);
      if (_lwevent_set(&lwevent,0x01) != MQX_OK) {
         printf("\nSet Event failed");
         _task_block();
      }
   }
}

/*TASK*-----------------------------------------------------
* 
* Task Name    : service_task
* Comments     :
*    This task creates an event group and the simulated_ISR_task 
*    task. It opens a connection to the event group and waits.
*    After the appropriate event bit has been set, it clears 
*    the event bit and prints "Tick."
*END*-----------------------------------------------------*/

void service_task 
   (
      uint32_t initial_data
   )
{
   _task_id second_task_id;
   _int_install_unexpected_isr();
   /* create lwevent group */
   if (_lwevent_create(&lwevent,0) != MQX_OK) {
      printf("\nMake event failed");
      _task_block();
   }

   /* Create the ISR task */
   second_task_id = _task_create(0, ISR_TASK, 0);
   if (second_task_id == MQX_NULL_TASK_ID) {
      printf("Could not create simulated_ISR_task \n");
      _task_block();
   }

   while (TRUE) {
      if (_lwevent_wait_ticks(&lwevent,1,TRUE,0) != MQX_OK) {
         printf("\nEvent Wait failed");
         _task_block();
      }

      if (_lwevent_clear(&lwevent,0x01) != MQX_OK) {
         printf("\nEvent Clear failed");
         _task_block();
      }
      printf(" Tick \n");
   }
}  

/* EOF */
