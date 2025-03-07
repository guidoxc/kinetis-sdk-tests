#/*HEADER**********************************************************************
#*
#* Copyright 2010 Freescale Semiconductor, Inc.
#*
#* This software is owned or controlled by Freescale Semiconductor.
#* Use of this software is governed by the Freescale MQX RTOS License
#* distributed with this Material.
#* See the MQX_RTOS_LICENSE file distributed for more details.
#*
#* Brief License Summary:
#* This software is provided in source form for you to use free of charge,
#* but it is not open source software. You are allowed to use this software
#* but you cannot redistribute it or derivative works of it in source form.
#* The software may be used only in connection with a product containing
#* a Freescale microprocessor, microcontroller, or digital signal processor.
#* See license agreement file for full license terms including other restrictions.
#*****************************************************************************
#*
#* Comments:
#* 19-sep-2014: sonnd7: Add kds support
#* 24-sep-2014: sonnd7: Add KSDK support
#*END************************************************************************/

$VERSION = "v3.8.1";

# default report content
$DUMP_ROM = 1;
$DUMP_RAM = 0;
$DUMP_PSP_COMPONENTS = 1;
$DUMP_BSP_COMPONENTS = 0;
$DUMP_SUMM_COMPONENTS = 1;
$DUMP_MFS_COMPONENTS = 1;
$DUMP_RTCS_COMPONENTS = 1;
$DUMP_USBH_COMPONENTS = 0;
$DUMP_USBD_COMPONENTS = 0;
$DUMP_KSDK_COMPONENTS = 1;

# dump breakdown of MQX Kernel objects
$DUMP_MQX_KERNEL_OBJECTS = 0;

# text dump too
$TEXT_DUMP = 0;

# enable warning messages
$WARNINGS_ENABLE = 0;
$WARNINGS_COUNT = 0;

# dump details
$DUMP_SYM_DETAILS = 0;
$DUMP_SECT_DETAILS = 0;

# input data
@MAPFILES = ();
%MAPFILE_FMT = ();

# output file name
$OUT_FILE = "";

# process options
while($o = shift)
{
    if($o =~ /^\-c$/)
    {
        $fmt = shift;
        next;
    }
    elsif($o =~ /^\-n$/)
    {
        $nm = shift;
        $nm =~ s/^\"(.*)\"$/$1/;
        next;
    }
    elsif($o =~ /^\-n2$/)
    {
        $nm2 = shift;
        $nm2 =~ s/^\"(.*)\"$/$1/;
        next;
    }
    elsif($o =~ /^\-n3$/)
    {
        $nm3 = shift;
        $nm3 =~ s/^\"(.*)\"$/$1/;
        next;
    }
    elsif($o =~ /^\-M$/)
    {
        $DUMP_SYM_DETAILS = 1;
        $DUMP_SECT_DETAILS = 1;
        next;
    }
    elsif($o =~ /^\-M1$/)
    {
        $DUMP_SYM_DETAILS = 1;
        next;
    }
    elsif($o =~ /^\-M2$/)
    {
        $DUMP_SECT_DETAILS = 1;
        next;
    }
    elsif($o =~ /^\-W$/)
    {
        $WARNINGS_ENABLE = 1;
        next;
    }
    elsif($o =~ /^\-K$/)
    {
        $DUMP_MQX_KERNEL_OBJECTS = 1;
        next;
    }
    elsif($o =~ /^\-o$/)
    {
        $OUT_FILE = shift;
        next;
    }
    elsif($o =~ /^-m$/)
    {
        # backw. compat only
        next;
    }
    elsif($o =~ /^-t$/)
    {
        $TEXT_DUMP = 1;
        next;
    }
    elsif($o =~ /^([+\-])ROM$/)
    {
        $DUMP_ROM = $1 eq "+" ? 1 : 0;
        next;
    }
    elsif($o =~ /^([+\-])RAM$/)
    {
        $DUMP_RAM = $1 eq "+" ? 1 : 0;
        next;
    }
    elsif($o =~ /^([+\-])BSP$/)
    {
        $DUMP_BSP_COMPONENTS = $1 eq "+" ? 1 : 0;
        next;
    }
    elsif($o =~ /^([+\-])PSP$/)
    {
        $DUMP_PSP_COMPONENTS = $1 eq "+" ? 1 : 0;
        next;
    }
    elsif($o =~ /^([+\-])SUMM$/)
    {
        $DUMP_SUMM_COMPONENTS = $1 eq "+" ? 1 : 0;
        next;
    }
    elsif($o =~ /^([+\-])MFS$/)
    {
        $DUMP_MFS_COMPONENTS = $1 eq "+" ? 1 : 0;
        next;
    }
    elsif($o =~ /^([+\-])RTCS$/)
    {
        $DUMP_RTCS_COMPONENTS = $1 eq "+" ? 1 : 0;
        next;
    }
    elsif($o =~ /^([+\-])USBD$/)
    {
        $DUMP_USBD_COMPONENTS = $1 eq "+" ? 1 : 0;
        next;
    }
    elsif($o =~ /^([+\-])USBH$/)
    {
        $DUMP_USBH_COMPONENTS = $1 eq "+" ? 1 : 0;
        next;
    }
    elsif($o =~ /^([+\-])SHELL$/)
    {
        $DUMP_KSDK_COMPONENTS = $1 eq "+" ? 1 : 0;
        next;
    }
    elsif($o =~ /^\-/)
    {
        printf STDERR "Unknown option $o specified\n\n";
        exit(1);
    }

    # the $o is the mapfile name and will use the $fmt format
    mydie("Please specify the format before the file name") if not $fmt;

    $o =~ s/^\"(.*)\"$/$1/;
    mydie("File not found: $o") if not -e $o;

    push @MAPFILES,$o;
    $MAPFILE_FMT{$o} = $fmt;

    # file name or friendly name will be used
    $o =~ /([^\\\/]*)$/;
    $MAPFILE_NAME{$o} = $nm ? $nm : $1;
    $MAPFILE_NAME2{$o} = $nm2;
    $MAPFILE_NAME3{$o} = $nm3;
    $nm = "";
    $nm2 = "";
    $nm3 = "";
}

if(not @MAPFILES)
{
    print_usage();
    exit(0);
}

if(@MAPFILES > 1 && $DUMP_SYM_DETAILS)
{
    mydie("Use just one file with -M option");
}

if(not $OUT_FILE)
{
    $OUT_FILE = @MAPFILES == 1 ? "$MAPFILES[0].html" : "codesize_report.html";
}

# probe output file before going for lenghty processing
# print "probing $OUT_FILE\n";

open OUTFILE, ">$OUT_FILE" or mydie("Can not write output file\n");
close OUTFILE;

# the list of components for the report, prepared bellow
@THE_REPORT = ();

# map section names or objectfile names to friendly names
# name may also be one or more regular expressions
# (multiple regular expressions may be used with & operator)
# if multiple expressions are used, all must be satisfied by symbol
# WARNING: "." (dot) is \-escaped when processing regexp

%MAP_COMMON = (
    # text sections go to ROM

    ".text|KERNEL|DISPATCH|IPSUM&mqx(_regabi)?(_d)?.a"  => "MQX_TEXT,MQX_ROM",
    ".text|KERNEL|DISPATCH|S_Dispatch|IPSUM&mqx.a|mqx_\\w+.a" => "MQX_TEXT,MQX_ROM",

    ".text&libksdk_platform_mqx(_regabi)?(_d)?.a" => "KSDK_ROM",
    ".text&mqx_stdlib(_regabi)?(_d)?.a" => "MQX_STD_ROM",

    ".text&rtcs(_regabi)?(_d)?.a" => "RTCS_TEXT,RTCS_ROM",
    ".text&rtcs.a|rtcs_\\w+.a"           => "RTCS_TEXT,RTCS_ROM",

    ".text&mfs(_regabi)?(_d)?.a" => "MFS_TEXT,MFS_ROM",
    ".text&mfs.a|mfs_\\w+.a"           => "MFS_TEXT,MFS_ROM",

    ".text&usb_hdk(_regabi)?(_d)?.a" => "USBH_TEXT,USBH_ROM",
    ".text&usbh.a|usb_hdk_\\w+.a"           => "USBH_TEXT,USBH_ROM",

    ".text&usb_ddk(_regabi)?(_d)?.a" => "USBD_TEXT,USBD_ROM",
    ".text&usbd.a|usb_ddk_\\w+.a"           => "USBD_TEXT,USBD_ROM",

    ".text&shell(_regabi)?(_d)?.a" => "SHELL_TEXT,SHELL_ROM",
    ".text&shell.a|shell_\\w+.a"           => "SHELL_TEXT,SHELL_ROM",

    ".text&nshell(_regabi)?(_d)?.a" => "SHELL_TEXT,SHELL_ROM",
    ".text&nshell.a|nshell_\\w+.a"           => "SHELL_TEXT,SHELL_ROM",

    ".text&(twrmcf|twrmpc|m)5[124]\\w*.a" => "BSP_TEXT,BSP_ROM",
    ".text&bsp.a|bsp_\\w+.a"             => "BSP_TEXT,BSP_ROM",

    ".init&(twrmcf|twrmpc|m)5[124]\\w*.a" => "BSP_INIT,BSP_ROM",
    ".init&bsp.a|bsp_\\w+.a"             => "BSP_INIT,BSP_ROM",

    ".bootstrap\\w*&(twrmcf|twrmpc|m)5[124]\\w*.a"               => "BSP_BOOTSTRAP_ROM,BSP_ROM",
    ".bootstrap\\w*&bsp.a|bsp_\\w+.a"                            => "BSP_BOOTSTRAP_ROM,BSP_ROM",
    "boot.o"                                                     => "BSP_BOOTSTRAP_ROM,BSP_ROM",

    ".cfmconfig&_cfm" => "BSP_ROM",
    ".usb_bdt&bdt" => "USBH_ROM",

    # constants go to ROM
    ".rodata&mqx(_regabi)?(_d)?.a" => "MQX_RODATA,MQX_ROM",
    ".rodata&mqx.a|mqx_\\w+.a"           => "MQX_RODATA,MQX_ROM",

    ".rodata&libksdk_platform_mqx(_regabi)?(_d)?.a" => "KSDK_RODATA,KSDK_ROM",
    ".rodata&mqx_stdlib(_regabi)?(_d)?.a" => "MQX_STD_RODATA,MQX_STD_ROM",

    ".rodata&rtcs(_regabi)?(_d)?.a" => "RTCS_RODATA,RTCS_ROM",
    ".rodata&rtcs.a|rtcs_\\w+.a"           => "RTCS_RODATA,RTCS_ROM",

    ".rodata&mfs(_regabi)?(_d)?.a" => "MFS_RODATA,MFS_ROM",
    ".rodata&mfs.a|mfs_\\w+.a"           => "MFS_RODATA,MFS_ROM",

    ".rodata&usb_hdk(_regabi)?(_d)?.a" => "USBH_RODATA,USBH_ROM",
    ".rodata&usbh.a|usb_hdk_\\w+.a"           => "USBH_RODATA,USBH_ROM",

    ".rodata&usb_ddk(_regabi)?(_d)?.a" => "USBD_RODATA,USBD_ROM",
    ".rodata&usbd.a|usb_ddk_\\w+.a"           => "USBD_RODATA,USBD_ROM",

    ".rodata&shell(_regabi)?(_d)?.a" => "SHELL_RODATA,SHELL_ROM",
    ".rodata&shell.a|shell_\\w+.a"           => "SHELL_RODATA,SHELL_ROM",

    ".rodata&(twrmcf|twrmpc|m)5[124]\\w*.a" => "BSP_RODATA,BSP_ROM,BSP_RAM",
    ".rodata&bsp.a|bsp_\\w+.a"             => "BSP_RODATA,BSP_ROM,BSP_RAM",

    # data go to both ROM and RAM
    ".data&mqx(_regabi)?(_d)?.a" => "MQX_RODATA,MQX_ROM,MQX_RAM",
    ".data&mqx.a|mqx_\\w+.a"           => "MQX_RODATA,MQX_ROM,MQX_RAM",

    ".data&libksdk_platform_mqx(_regabi)?(_d)?.a" => "KSDK_RODATA,KSDK_ROM,KSDK_RAM",
    ".data&mqx_stdlib(_regabi)?(_d)?.a" => "MQX_STD_RODATA,MQX_STD_ROM,MQX_STD_RAM",

    ".data&rtcs(_regabi)?(_d)?.a" => "RTCS_RODATA,RTCS_ROM,RTCS_RAM",
    ".data&rtcs.a|rtcs_\\w+.a"           => "RTCS_RODATA,RTCS_ROM,RTCS_RAM",

    ".data&mfs(_regabi)?(_d)?.a" => "MFS_RODATA,MFS_ROM,MFS_RAM",
    ".data&mfs.a|mfs_\\w+.a"           => "MFS_RODATA,MFS_ROM,MFS_RAM",

    ".data&usb_hdk(_regabi)?(_d)?.a" => "USBH_RODATA,USBH_ROM,USBH_RAM",
    ".data&usbh.a|usb_hdk_\\w+.a"           => "USBH_RODATA,USBH_ROM,USBH_RAM",
    "bdt&usbh.a|usb_hdk_\\w+.a"             => "USBH_RAM",

    ".data&usb_ddk(_regabi)?(_d)?.a" => "USBD_RODATA,USBD_ROM,USBD_RAM",
    ".data&usbd.a|usb_ddk_\\w+.a"           => "USBD_RODATA,USBD_ROM,USBD_RAM",

    ".data&shell(_regabi)?(_d)?.a" => "SHELL_RODATA,SHELL_ROM,SHELL_RAM",
    ".data&shell.a|shell_\\w+.a"           => "SHELL_RODATA,SHELL_ROM,SHELL_RAM",

    ".data&(twrmcf|twrmpc|m)5[124]\\w*.a" => "BSP_RODATA,BSP_ROM,BSP_RAM",
    ".data&bsp.a|bsp_\\w+.a"             => "BSP_RODATA,BSP_ROM,BSP_RAM",

    # bss go to RAM only
    ".bss&mqx(_regabi)?(_d)?.a" => "MQX_RAM",
    ".bss&mqx.a|mqx_\\w+.a"           => "MQX_RAM",

    ".bss&libksdk_platform_mqx(_regabi)?(_d)?.a" => "KSDK_RAM",

    ".bss&rtcs(_regabi)?(_d)?.a" => "RTCS_RAM",
    ".bss&rtcs.a|rtcs_\\w+.a"           => "RTCS_RAM",

    ".bss&mfs(_regabi)?(_d)?.a" => "MFS_RAM",
    ".bss&mfs.a|mfs_\\w+.a"           => "MFS_RAM",

    ".bss&usb_hdk(_regabi)?(_d)?.a" => "USBH_RAM",
    ".bss&usbh.a|usb_hdk_\\w+.a"           => "USBH_RAM",

    ".bss&usb_ddk(_regabi)?(_d)?.a" => "USBD_RAM",
    ".bss&usbd.a|usb_ddk_\\w+.a"           => "USBD_RAM",

    ".bss&shell(_regabi)?(_d)?.a" => "SHELL_RAM",
    ".bss&shell.a|shell_\\w+.a"           => "SHELL_RAM",

    ".bss|VECTORS&(twrmcf|twrmpc|m)5[124]\\w*.a" => "BSP_RAM",
    ".bss|VECTORS&bsp.a|bsp_\\w+.a"             => "BSP_RAM",

    # fake item to cath "static initializers"
    "static&initializer" => "MSL_ROM",

    # application-specific (the only files with .c extension in the MAP file)
    ".rodata&tfs_\\w+.(c|obj)" => "APP_ROM,APP_TFS",
    ".(rodata|data|text)&\\w*.(c|obj)" => "APP_ROM",
    ".(bss|data)&\\w*.(c|obj)" => "APP_RAM",

#
# NOTE:  We want to match &mqx\\w*.o, but codewarrior sometimes
# truncates the .o if the symbol is too long (> 15 chars)
#
#
    # MQX Core
    ".(text|rodata|data)&mqx(_regabi)?(_d)?.a&mqx\\w*.o" => "CORE_ROM",
    ".(text|rodata|data)&mqx.a|mqx_\\w+.a&mqx\\w*.o"           => "CORE_ROM",
    ".(data|bss|kernel_data)&mqx(_regabi)?(_d)?.a&mqx\\w*.o" => "CORE_RAM",
    ".(data|bss|kernel_data)&mqx.a|mqx_\\w+.a&mqx\\w*.o"           => "CORE_RAM",

    # Scheduler
    "(.text|.rodata|.data|KERNEL|DISPATCH)&mqx(_regabi)?(_d)?.a&(dispatch|sc_)\\w*.o" => "SCHED_ROM",
    "(.text|.rodata|.data|KERNEL|DISPATCH)&mqx_\\w+.a&(dispatch|sc_)\\w*.o"           => "SCHED_ROM",
    ".(data|bss)&mqx(_regabi)?(_d)?.a&(dispatch|sc_)\\w*.o" => "SCHED_RAM",
    ".(data|bss)&mqx_\\w+.a&(dispatch|sc_)\\w*.o"           => "SCHED_RAM",
    # MQX 4.0
    "(.text|.rodata|.data|KERNEL|DISPATCH)&mqx.a&(dispatch|sched)\\w*.o"           => "SCHED_ROM",
    ".(data|bss)&mqx.a|mqx_\\w+.a&(dispatch|sched)\\w*.o"           => "SCHED_RAM",

    # Tasking
    ".(text|rodata|data)&mqx(_regabi)?(_d)?.a&(ta_|td_|stack_)\\w*.o" => "TASK_ROM",
    ".(text|rodata|data)&mqx_\\w+.a&(ta_|td_|stack_)\\w*.o"           => "TASK_ROM",
    ".(data|bss)&mqx(_regabi)?(_d)?.a&(ta_|td_|stack_)\\w*.o" => "TASK_RAM",
    ".(data|bss)&mqx_\\w+.a&(ta_|td_|stack_)\\w*.o"           => "TASK_RAM",
    # MQX 4.0
    ".(text|rodata|data)&mqx.a&((task)|(stack\\w*)).o"           => "TASK_ROM",
    ".(data|bss)&mqx.a&((task)|(stack\\w*)).o"                   => "TASK_RAM",

    # Queues
    ".(text|rodata|data)&mqx(_regabi)?(_d)?.a&qu_\\w*.o" => "QUEUE_ROM",
    ".(text|rodata|data)&mqx_\\w+.a&qu_\\w*.o"           => "QUEUE_ROM",
    ".(data|bss)&mqx(_regabi)?(_d)?.a&qu_\\w*.o" => "QUEUE_RAM",
    ".(data|bss)&mqx_\\w+.a&qu_\\w*.o"           => "QUEUE_RAM",
    # MQX 4.0
    ".(text|rodata|data)&mqx.a&queue.o"           => "QUEUE_ROM",
    ".(data|bss)&mqx.a&queue.o"                   => "QUEUE_RAM",

    # Time
    ".(text|rodata|data)&mqx(_regabi)?(_d)?.a&ti_\\w*.o" => "TIME_ROM",
    ".(text|rodata|data)&mqx_\\w+.a&ti_\\w*.o"           => "TIME_ROM",
    ".(data|bss)&mqx(_regabi)?(_d)?.a&ti_\\w*.o" => "TIME_RAM",
    ".(data|bss)&mqx_\\w+.a&ti_\\w*.o"           => "TIME_RAM",
    # MQX 4.0
    ".(text|rodata|data)&mqx.a&time\\w*.o"       => "TIME_ROM",
    ".(data|bss)&mqx.a&time\\w*.o"               => "TIME_RAM",

    # Task Queues
    ".(text|rodata|data)&mqx(_regabi)?(_d)?.a&tq_\\w*.o" => "TQ_ROM",
    ".(text|rodata|data)&mqx_\\w+.a&tq_\\w*.o"           => "TQ_ROM",
    ".(data|bss)&mqx(_regabi)?(_d)?.a&tq_\\w*.o" => "TQ_RAM",
    ".(data|bss)&mqx_\\w+.a&tq_\\w*.o"           => "TQ_RAM",
    # MQX 4.0
    ".(text|rodata|data)&mqx.a&taskq.o"           => "TQ_ROM",
    ".(data|bss)&mqx.a&taskq.o"                   => "TQ_RAM",

    # Interrupts
    ".(text|rodata|data)&mqx(_regabi)?(_d)?.a&int_\\w*.o" => "INT_ROM",
    ".(text|rodata|data)&mqx_\\w+.a&int_\\w*.o"           => "INT_ROM",
    ".(data|bss)&mqx(_regabi)?(_d)?.a&int_\\w*.o" => "INT_RAM",
    ".(data|bss)&mqx_\\w+.a&int_\\w*.o"           => "INT_RAM",
    # MQX 4.0
    ".(text|rodata|data)&mqx.a&int\\w*.o"           => "INT_ROM",
    ".(data|bss)&mqx.a&int\\w*.o"                   => "INT_RAM",

    # LW MEM
    ".(text|rodata|data)&mqx(_regabi)?(_d)?.a&lwm_\\w*.o" => "LWMEM_ROM",
    ".(text|rodata|data)&mqx_\\w+.a&lwm_\\w*.o"           => "LWMEM_ROM",
    ".(data|bss)&mqx(_regabi)?(_d)?.a&lwm_\\w*.o" => "LWMEM_RAM",
    ".(data|bss)&mqx_\\w+.a&lwm_\\w*.o"           => "LWMEM_RAM",
    # MQX 4.0
    ".(text|rodata|data)&mqx.a&lwmem.o"           => "LWMEM_ROM",
    ".(data|bss)&mqx.a&lwmem.o"                   => "LWMEM_RAM",

    # MEM
    ".(text|rodata|data)&mqx(_regabi)?(_d)?.a&mem_\\w*.o" => "MEM_ROM",
    ".(text|rodata|data)&mqx_\\w+.a&mem_\\w*.o"           => "MEM_ROM",
    ".(data|bss)&mqx(_regabi)?(_d)?.a&mem_\\w*.o" => "MEM_RAM",
    ".(data|bss)&mqx_\\w+.a&mem_\\w*.o"           => "MEM_RAM",
    # MQX 4.0
    ".(text|rodata|data)&mqx.a&mem.o"           => "MEM_ROM",
    ".(data|bss)&mqx.a&mem.o"                   => "MEM_RAM",

    # LW SEM
    ".(text|rodata|data)&mqx(_regabi)?(_d)?.a&lws_\\w*.o" => "LWSEM_ROM",
    ".(text|rodata|data)&mqx_\\w+.a&lws_\\w*.o"           => "LWSEM_ROM",
    ".(data|bss)&mqx(_regabi)?(_d)?.a&lws_\\w*.o" => "LWSEM_RAM",
    ".(data|bss)&mqx_\\w+.a&lws_\\w*.o"           => "LWSEM_RAM",
    # MQX 4.0
    ".(text|rodata|data)&mqx.a&lwsem.o"           => "LWSEM_ROM",
    ".(data|bss)&mqx.a&lwsem.o"                   => "LWSEM_RAM",

    # LW Events
    ".(text|rodata|data)&mqx(_regabi)?(_d)?.a&lwe_\\w*.o" => "LWEVENT_ROM",
    ".(text|rodata|data)&mqx_\\w+.a&lwe_\\w*.o"           => "LWEVENT_ROM",
    ".(data|bss)&mqx(_regabi)?(_d)?.a&lwe_\\w*.o" => "LWEVENT_RAM",
    ".(data|bss)&mqx_\\w+.a&lwe_\\w*.o"           => "LWEVENT_RAM",
    # MQX 4.0
    ".(text|rodata|data)&mqx.a&lwevent.o"         => "LWEVENT_ROM",
    ".(data|bss)&mqx.a&lwevent.o"                 => "LWEVENT_RAM",

    # Events
    ".(text|rodata|data)&mqx(_regabi)?(_d)?.a&ev_\\w*.o" => "EVENT_ROM",
    ".(text|rodata|data)&mqx_\\w+.a&ev_\\w*.o"           => "EVENT_ROM",
    ".(data|bss)&mqx(_regabi)?(_d)?.a&ev_\\w*.o" => "EVENT_RAM",
    ".(data|bss)&mqx_\\w+.a&ev_\\w*.o"           => "EVENT_RAM",
    # MQX 4.0
    ".(text|rodata|data)&mqx.a&event.o"           => "EVENT_ROM",
    ".(data|bss)&mqx.a&event.o"                   => "EVENT_RAM",

    # Kernel Log
    ".(text|rodata|data)&mqx(_regabi)?(_d)?.a&kl_\\w*.o" => "KLOG_ROM",
    ".(text|rodata|data)&mqx_\\w+.a&kl_\\w*.o"           => "KLOG_ROM",
    ".(data|bss)&mqx(_regabi)?(_d)?.a&kl_\\w*.o" => "KLOG_RAM",
    ".(data|bss)&mqx_\\w+.a&kl_\\w*.o"           => "KLOG_RAM",
    # MQX 4.0
    ".(text|rodata|data)&mqx.a&klog.o"           => "KLOG_ROM",
    ".(data|bss)&mqx.a&klog.o"                   => "KLOG_RAM",

    # Log
    ".(text|rodata|data)&mqx(_regabi)?(_d)?.a&lo_\\w*.o" => "LOG_ROM",
    ".(text|rodata|data)&mqx_\\w+.a&lo_\\w*.o"           => "LOG_ROM",
    ".(data|bss)&mqx(_regabi)?(_d)?.a&lo_\\w*.o" => "LOG_RAM",
    ".(data|bss)&mqx_\\w+.a&lo_\\w*.o"           => "LOG_RAM",
    # MQX 4.0
    ".(text|rodata|data)&mqx.a&log.o"           => "LOG_ROM",
    ".(data|bss)&mqx.a&log.o"                   => "LOG_RAM",

    # LW Log
    ".(text|rodata|data)&mqx(_regabi)?(_d)?.a&lwl_\\w*.o" => "LWLOG_ROM",
    ".(text|rodata|data)&mqx_\\w+.a&lwl_\\w*.o"           => "LWLOG_ROM",
    ".(data|bss)&mqx(_regabi)?(_d)?.a&lwl_\\w*.o" => "LWLOG_RAM",
    ".(data|bss)&mqx_\\w+.a&lwl_\\w*.o"           => "LWLOG_RAM",
    # MQX 4.0
    ".(text|rodata|data)&mqx.a&lwlog.o"           => "LWLOG_ROM",
    ".(data|bss)&mqx.a&lwlog.o"        => "LWLOG_RAM",

    # LW Messages
    ".(text|rodata|data)&mqx(_regabi)?(_d)?.a&lwmsg\\w*.o" => "LWMSG_ROM",
    ".(text|rodata|data)&mqx_\\w+.a&lwmsg\\w*.o"           => "LWMSG_ROM",
    ".(data|bss)&mqx(_regabi)?(_d)?.a&lwmsg\\w*.o" => "LWMSG_RAM",
    ".(data|bss)&mqx_\\w+.a&lwmsg\\w*.o"           => "LWMSG_RAM",
    # MQX 4.0
    ".(text|rodata|data)&mqx.a&lwmsgq.o"           => "LWMSG_ROM",
    ".(data|bss)&mqx.a&lwmsgq.o"                   => "LWMSG_RAM",

    # LW Timers
    ".(text|rodata|data)&mqx(_regabi)?(_d)?.a&lwt_\\w*.o" => "LWTIMER_ROM",
    ".(text|rodata|data)&mqx_\\w+.a&lwt_\\w*.o"           => "LWTIMER_ROM",
    ".(data|bss)&mqx(_regabi)?(_d)?.a&lwt_\\w*.o" => "LWTIMER_RAM",
    ".(data|bss)&mqx_\\w+.a&lwt_\\w*.o"           => "LWTIMER_RAM",
    # MQX 4.0
    ".(text|rodata|data)&mqx.a&lwtimer.o"           => "LWTIMER_ROM",
    ".(data|bss)&mqx.a&lwtimer.o"                   => "LWTIMER_RAM",

    # Messages
    ".(text|rodata|data)&mqx(_regabi)?(_d)?.a&ms_\\w*.o" => "MSG_ROM",
    ".(text|rodata|data)&mqx_\\w+.a&ms_\\w*.o"           => "MSG_ROM",
    ".(data|bss)&mqx(_regabi)?(_d)?.a&ms_\\w*.o" => "MSG_RAM",
    ".(data|bss)&mqx_\\w+.a&ms_\\w*.o"           => "MSG_RAM",
    # MQX 4.0
    ".(text|rodata|data)&mqx.a&msg\\w*.o"        => "MSG_ROM",
    ".(data|bss)&mqx.a&msg\\w*.o"                => "MSG_RAM",

    # Mutexes
    ".(text|rodata|data)&mqx(_regabi)?(_d)?.a&mu_\\w*.o" => "MUTEX_ROM",
    ".(text|rodata|data)&mqx_\\w+.a&mu_\\w*.o"           => "MUTEX_ROM",
    ".(data|bss)&mqx(_regabi)?(_d)?.a&mu_\\w*.o" => "MUTEX_RAM",
    ".(data|bss)&mqx_\\w+.a&mu_\\w*.o"           => "MUTEX_RAM",
    # MQX 4.0
    ".(text|rodata|data)&mqx.a&mutex.o"           => "MUTEX_ROM",
    ".(data|bss)&mqx.a&mutex.o"                   => "MUTEX_RAM",

    # Names
    ".(text|rodata|data)&mqx(_regabi)?(_d)?.a&na_\\w*.o" => "NAME_ROM",
    ".(text|rodata|data)&mqx_\\w+.a&na_\\w*.o"           => "NAME_ROM",
    ".(data|bss)&mqx(_regabi)?(_d)?.a&na_\\w*.o" => "NAME_RAM",
    ".(data|bss)&mqx_\\w+.a&na_\\w*.o"           => "NAME_RAM",
    # MQX 4.0
    ".(text|rodata|data)&mqx.a&name.o"           => "NAME_ROM",
    ".(data|bss)&mqx.a&name.o"                   => "NAME_RAM",

    # Partitions
    ".(text|rodata|data)&mqx(_regabi)?(_d)?.a&pa_\\w*.o" => "PART_ROM",
    ".(text|rodata|data)&mqx_\\w+.a&pa_\\w*.o"           => "PART_ROM",
    ".(data|bss)&mqx(_regabi)?(_d)?.a&pa_\\w*.o" => "PART_RAM",
    ".(data|bss)&mqx_\\w+.a&pa_\\w*.o"           => "PART_RAM",
    # MQX 4.0
    ".(text|rodata|data)&mqx.a&partition.o"      => "PART_ROM",
    ".(data|bss)&mqx.a&partition.o"              => "PART_RAM",

    # Semaphores
    ".(text|rodata|data)&mqx(_regabi)?(_d)?.a&se_\\w*.o" => "SEM_ROM",
    ".(text|rodata|data)&mqx_\\w+.a&se_\\w*.o"           => "SEM_ROM",
    ".(data|bss)&mqx(_regabi)?(_d)?.a&se_\\w*.o" => "SEM_RAM",
    ".(data|bss)&mqx_\\w+.a&se_\\w*.o"           => "SEM_RAM",
    # MQX 4.0
    ".(text|rodata|data)&mqx.a&sem.o"           => "SEM_ROM",
    ".(data|bss)&mqx.a&sem.o"                   => "SEM_RAM",

    # Watchdogs
    ".(text|rodata|data)&mqx(_regabi)?(_d)?.a&wa_\\w*.o" => "WDOG_ROM",
    ".(text|rodata|data)&mqx_\\w+.a&wa_\\w*.o"           => "WDOG_ROM",
    ".(data|bss)&mqx(_regabi)?(_d)?.a&wa_\\w*.o" => "WDOG_RAM",
    ".(data|bss)&mqx_\\w+.a&wa_\\w*.o"           => "WDOG_RAM",
    # MQX 4.0
    ".(text|rodata|data)&mqx.a&watchdog.o"       => "WDOG_ROM",
    ".(data|bss)&mqx.a&watchdog.o"               => "WDOG_RAM",

    # IdleTask
    ".(text|rodata|data)&mqx(_regabi)?(_d)?.a&idletas\\w*.o" => "IDLE_ROM",
    ".(text|rodata|data)&mqx_\\w+.a&idletas\\w*.o"           => "IDLE_ROM",
    ".(data|bss)&mqx(_regabi)?(_d)?.a&idletask\\w*.o" => "IDLE_RAM",
    ".(data|bss)&mqx_\\w+.a&idletask\\w*.o"           => "IDLE_RAM",
    # MQX 4.0
    ".(text|rodata|data)&mqx.a&idletask.o"           => "IDLE_ROM",
    ".(data|bss)&mqx.a&idletask.o"                   => "IDLE_RAM",

    # I/O
    ".(text|rodata|data)&mqx(_regabi)?(_d)?.a&nio_\\w*.o" => "IO_ROM",
    ".(text|rodata|data)&mqx.a|mqx_\\w+.a&nio_\\w*.o"           => "IO_ROM",
    ".(data|bss)&mqx(_regabi)?(_d)?.a&nio_\\w*.o" => "IO_RAM",
    ".(data|bss)&mqx.a|mqx_\\w+.a&nio_\\w*.o"           => "IO_RAM",
    # MQX 4.0 ... covered above

    # MQX string
    ".(text|rodata|data)&mqx(_regabi)?(_d)?.a&str\\w*.o" => "STRING_ROM",
    ".(text|rodata|data)&mqx.a|mqx_\\w+.a&str\\w*.o"           => "STRING_ROM",
    ".(data|bss)&mqx(_regabi)?(_d)?.a&str\\w*.o" => "STRING_RAM",
    ".(data|bss)&mqx.a|mqx_\\w+.a&str\\w*.o"           => "STRING_RAM",
    # MQX 4.0 ... covered above

    # MQX 4.0 ... covered above

    # MPU support (kinetis only)
    ".(text|rodata|data)&mqx.a|mqx_\\w+.a&kinetis_mpu.o"        => "MPU_ROM",
    ".(data|bss)&mqx.a|mqx_\\w+.a&kinetis_mpu.o"           => "MPU_RAM",
    # MQX 4.0 ... covered above
);


#
# BSP (note: can not add .o to the end as some longer filenames are truncated)
#

%MAP_BSP =
(
    # ADC
    ".(text|rodata|data)&(twrmcf|twrmpc|m)5[124]\\w*.a&ad[ct]\\w*.?o?" => "ADC_ROM",
    ".(text|rodata|data)&bsp.a|bsp_\\w+.a&ad[ct]\\w*.?o?"             => "ADC_ROM",
    ".(data|bss)&(twrmcf|twrmpc|m)5[124]\\w*.a&ad[ct]\\w*.?o?" => "ADC_RAM",
    ".(data|bss)&bsp.a|bsp_\\w+.a&ad[ct]\\w*.?o?"             => "ADC_RAM",

    # APC
    ".(text|rodata|data)&(twrmcf|twrmpc|m)5[124]\\w*.a&apcflash\\w*.?o?" => "APCFLASH_ROM",
    ".(text|rodata|data)&bsp.a|bsp_\\w+.a&apcflash\\w*.?o?"             => "APCFLASH_ROM",
    ".(data|bss)&(twrmcf|twrmpc|m)5[124]\\w*.a&apcflash\\w*.?o?" => "APCFLASH_RAM",
    ".(data|bss)&bsp.a|bsp_\\w+.a&apcflash\\w*.?o?"             => "APCFLASH_RAM",

    # FlexCAN
    ".(text|rodata|data)&(twrmcf|twrmpc|m)5[124]\\w*.a&[Ff][Ll][Ee][Xx][Cc][Aa][Nn]_\\w*.?o?" => "FlexCAN_ROM",
    ".(text|rodata|data)&bsp.a|bsp_\\w+.a&[Ff][Ll][Ee][Xx][Cc][Aa][Nn]_\\w*.?o?"             => "FlexCAN_ROM",
    ".(data|bss)&(twrmcf|twrmpc|m)5[124]\\w*.a&[Ff][Ll][Ee][Xx][Cc][Aa][Nn]_\\w*.?o?" => "FlexCAN_RAM",
    ".(data|bss)&bsp.a|bsp_\\w+.a&[Ff][Ll][Ee][Xx][Cc][Aa][Nn]_\\w*.?o?"             => "FlexCAN_RAM",

    # msCAN
    ".(text|rodata|data)&(twrmcf|twrmpc|m)5[124]\\w*.a&[Mm][Ss][Cc][Aa][Nn]_\\w*.?o?" => "msCAN_ROM",
    ".(text|rodata|data)&bsp.a|bsp_\\w+.a&[Mm][Ss][Cc][Aa][Nn]_\\w*.?o?"             => "msCAN_ROM",
    ".(data|bss)&(twrmcf|twrmpc|m)5[124]\\w*.a&[Mm][Ss][Cc][Aa][Nn]_\\w*.?o?" => "msCAN_RAM",
    ".(data|bss)&bsp.a|bsp_\\w+.a&[Mm][Ss][Cc][Aa][Nn]_\\w*.?o?"             => "msCAN_RAM",

    # Dispaly
    ".(text|rodata|data)&(twrmcf|twrmpc|m)5[124]\\w*.a&display_\\w*.?o?" => "Display_ROM",
    ".(text|rodata|data)&bsp.a|bsp_\\w+.a&display_\\w*.?o?"             => "Display_ROM",
    ".(data|bss)&(twrmcf|twrmpc|m)5[124]\\w*.a&display_\\w*.?o?" => "Display_RAM",
    ".(data|bss)&bsp.a|bsp_\\w+.a&display_\\w*.?o?"             => "Display_RAM",

    # DIU
    ".(text|rodata|data)&(twrmcf|twrmpc|m)5[124]\\w*.a&diu_\\w*.?o?" => "DIU_ROM",
    ".(text|rodata|data)&bsp.a|bsp_\\w+.a&diu_\\w*.?o?"             => "DIU_ROM",
    ".(data|bss)&(twrmcf|twrmpc|m)5[124]\\w*.a&diu_\\w*.?o?" => "DIU_RAM",
    ".(data|bss)&bsp.a|bsp_\\w+.a&diu_\\w*.?o?"             => "DIU_RAM",

    # ENET
    ".(text|rodata|data)&(twrmcf|twrmpc|m)5[124]\\w*.a&en\\w*.o" => "ENET_ROM",
    ".(text|rodata|data)&bsp.a|bsp_\\w+.a&en\\w*.o"             => "ENET_ROM",
    ".(data|bss)&(twrmcf|twrmpc|m)5[124]\\w*.a&en\\w*.o" => "ENET_RAM",
    ".(data|bss)&bsp.a|bsp_\\w+.a&en\\w*.o"             => "ENET_RAM",

    # Phy
    ".(text|rodata|data)&(twrmcf|twrmpc|m)5[124]\\w*.a&phy_\\w*.?o?" => "ENET_PHY_ROM",
    ".(text|rodata|data)&bsp.a|bsp_\\w+.a&phy_\\w*.?o?"             => "ENET_PHY_ROM",
    ".(data|bss)&(twrmcf|twrmpc|m)5[124]\\w*.a&phy_\\w*.?o?" => "ENET_PHY_RAM",
    ".(data|bss)&bsp.a|bsp_\\w+.a&phy_\\w*.?o?"             => "ENET_PHY_RAM",

    # FEC
    ".(text|rodata|data)&(twrmcf|twrmpc|m)5[124]\\w*.a&(mcf5xxx_fec_|mpc\\w+_fec|mcf5[0-9]*_fec)\\w*.?o?" => "ENET_FEC_ROM",
    ".(text|rodata|data)&bsp.a|bsp_\\w+.a&(mcf5xxx_fec_|mpc\\w+_fec|mcf5[0-9]*_fec|MACNET_)\\w*.?o?"             => "ENET_FEC_ROM",
    ".(data|bss)&(twrmcf|twrmpc|m)5[124]\\w*.a&(mcf5xxx_fec_|mpc\\w+_fec|mcf5[0-9]*_fec)\\w*.?o?" => "ENET_FEC_RAM",
    ".(data|bss)&bsp.a|bsp_\\w+.a&(mcf5xxx_fec_|mpc\\w+_fec|mcf5[0-9]*_fec|MACNET_)\\w*.?o?"             => "ENET_FEC_RAM",

    # Flash
    ".(text|rodata|data)&(twrmcf|twrmpc|m)5[124]\\w*.a&flash\\w*.?o?" => "FLASH_ROM",
    ".(text|rodata|data)&bsp.a|bsp_\\w+.a&flash\\w*.?o?"             => "FLASH_ROM",
    ".(data|bss)&(twrmcf|twrmpc|m)5[124]\\w*.a&flash\\w*.?o?" => "FLASH_RAM",
    ".(data|bss)&bsp.a|bsp_\\w+.a&flash\\w*.?o?"             => "FLASH_RAM",

    # GPIO
    ".(text|rodata|data)&(twrmcf|twrmpc|m)5[124]\\w*.a&io_gpio\\w*.?o?" => "GPIO_ROM",
    ".(text|rodata|data)&bsp.a|bsp_\\w+.a&io_gpio\\w*.?o?"             => "GPIO_ROM",
    ".(data|bss)&(twrmcf|twrmpc|m)5[124]\\w*.a&io_gpio\\w*.?o?" => "GPIO_RAM",
    ".(data|bss)&bsp.a|bsp_\\w+.a&io_gpio\\w*.?o?"             => "GPIO_RAM",

    # LWGPIO -> GPIO
    ".(text|rodata|data)&(twrmcf|twrmpc|m)5[124]\\w*.a&lwgpio\\w*.?o?" => "GPIO_ROM",
    ".(text|rodata|data)&bsp.a|bsp_\\w+.a&lwgpio\\w*.?o?"             => "GPIO_ROM",
    ".(data|bss)&(twrmcf|twrmpc|m)5[124]\\w*.a&lwgpio\\w*.?o?" => "GPIO_RAM",
    ".(data|bss)&bsp.a|bsp_\\w+.a&lwgpio\\w*.?o?"             => "GPIO_RAM",

    # I2C
    ".(text|rodata|data)&(twrmcf|twrmpc|m)5[124]\\w*.a&i2c_\\w*.?o?" => "I2C_ROM",
    ".(text|rodata|data)&bsp.a|bsp_\\w+.a&i2c_\\w*.?o?"             => "I2C_ROM",
    ".(data|bss)&(twrmcf|twrmpc|m)5[124]\\w*.a&i2c_\\w*.?o?" => "I2C_RAM",
    ".(data|bss)&bsp.a|bsp_\\w+.a&i2c_\\w*.?o?"             => "I2C_RAM",

    # Interrupts
    ".(text|rodata|data)&(twrmcf|twrmpc|m)5[124]\\w*.a&int_\\w*.?o?" => "BSP_INT_ROM",
    ".(text|rodata|data)&bsp.a|bsp_\\w+.a&int_\\w*.?o?"             => "BSP_INT_ROM",
    ".(data|bss)&(twrmcf|twrmpc|m)5[124]\\w*.a&int_\\w*.?o?" => "BSP_INT_RAM",
    ".(data|bss)&bsp.a|bsp_\\w+.a&int_\\w*.?o?"             => "BSP_INT_RAM",

    # PC Card
    ".(text|rodata|data)&(twrmcf|twrmpc|m)5[124]\\w*.a&pccard\\w*.?o?" => "PCCARD_ROM",
    ".(text|rodata|data)&bsp.a|bsp_\\w+.a&pccard\\w*.?o?"             => "PCCARD_ROM",
    ".(data|bss)&(twrmcf|twrmpc|m)5[124]\\w*.a&pccard\\w*.?o?" => "PCCARD_RAM",
    ".(data|bss)&bsp.a|bsp_\\w+.a&pccard\\w*.?o?"             => "PCCARD_RAM",

    # RTC, IRTC, KRTC
    ".(text|rodata|data)&(twrmcf|twrmpc|m)5[124]\\w*.a&[ik]?rtc\\w*.?o?" => "RTC_ROM",
    ".(text|rodata|data)&bsp.a|bsp_\\w+.a&[ik]?rtc\\w*.?o?"             => "RTC_ROM",
    ".(data|bss)&(twrmcf|twrmpc|m)5[124]\\w*.a&[ik]?rtc\\w*.?o?" => "RTC_RAM",
    ".(data|bss)&bsp.a|bsp_\\w+.a&[ik]?rtc\\w*.?o?"             => "RTC_RAM",

    # Serial
    ".(text|rodata|data)&(twrmcf|twrmpc|m)5[124]\\w*.a&(serl_|io_sinit)\\w*.?o?" => "Serial_ROM",
    ".(text|rodata|data)&bsp.a|bsp_\\w+.a&(serl_|io_sinit)\\w*.?o?"             => "Serial_ROM",
    ".(data|bss)&(twrmcf|twrmpc|m)5[124]\\w*.a&(serl_|io_sinit)\\w*.?o?" => "Serial_RAM",
    ".(data|bss)&bsp.a|bsp_\\w+.a&(serl_|io_sinit)\\w*.?o?"             => "Serial_RAM",

    # SPI
    ".(text|rodata|data)&(twrmcf|twrmpc|m)5[124]\\w*.a&spi_\\w*.?o?" => "SPI_ROM",
    ".(text|rodata|data)&bsp.a|bsp_\\w+.a&spi_\\w*.?o?"             => "SPI_ROM",
    ".(data|bss)&(twrmcf|twrmpc|m)5[124]\\w*.a&spi_\\w*.?o?" => "SPI_RAM",
    ".(data|bss)&bsp.a|bsp_\\w+.a&spi_\\w*.?o?"             => "SPI_RAM",

    # NAND
    ".(text|rodata|data)&(twrmcf|twrmpc|m)5[124]\\w*.a&nandflash_\\w*.?o?" => "NAND_ROM",
    ".(text|rodata|data)&bsp.a|bsp_\\w+.a&nandflash_\\w*.?o?"             => "NAND_ROM",
    ".(data|bss)&(twrmcf|twrmpc|m)5[124]\\w*.a&nandflash_\\w*.?o?" => "NAND_RAM",
    ".(data|bss)&bsp.a|bsp_\\w+.a&nandflash_\\w*.?o?"             => "NAND_RAM",

    ".(text|rodata|data)&(twrmcf|twrmpc|m)5[124]\\w*.a&nfc_\\w*.?o?" => "NAND_ROM",
    ".(text|rodata|data)&bsp.a|bsp_\\w+.a&nfc_\\w*.?o?"             => "NAND_ROM",
    ".(data|bss)&(twrmcf|twrmpc|m)5[124]\\w*.a&nfc_\\w*.?o?" => "NAND_RAM",
    ".(data|bss)&bsp.a|bsp_\\w+.a&nfc_\\w*.?o?"             => "NAND_RAM",

    # TFS
    ".(text|rodata|data)&(twrmcf|twrmpc|m)5[124]\\w*.a&tfs\\w*.?o?" => "TFS_ROM",
    ".(text|rodata|data)&bsp.a|bsp_\\w+.a&tfs\\w*.?o?"             => "TFS_ROM",
    ".(data|bss)&(twrmcf|twrmpc|m)5[124]\\w*.a&tfs\\w*.?o?" => "TFS_RAM",
    ".(data|bss)&bsp.a|bsp_\\w+.a&tfs\\w*.?o?"             => "TFS_RAM",

    # Timer
    ".(text|rodata|data)&(twrmcf|twrmpc|m)5[124]\\w*.a&timer_\\w*.?o?" => "TIMER_ROM",
    ".(text|rodata|data)&bsp.a|bsp_\\w+.a&timer_\\w*.?o?"             => "TIMER_ROM",
    ".(data|bss)&(twrmcf|twrmpc|m)5[124]\\w*.a&timer_\\w*.?o?" => "TIMER_RAM",
    ".(data|bss)&bsp.a|bsp_\\w+.a&timer_\\w*.?o?"             => "TIMER_RAM",

    # SDCARD
    ".(text|rodata|data)&(twrmcf|twrmpc|m)5[124]\\w*.a&sdcard\\w*.?o?" => "SDCARD_ROM",
    ".(text|rodata|data)&bsp.a|bsp_\\w+.a&sdcard\\w*.?o?"             => "SDCARD_ROM",
    ".(data|bss)&(twrmcf|twrmpc|m)5[124]\\w*.a&sdcard\\w*.?o?" => "SDCARD_RAM",
    ".(data|bss)&bsp.a|bsp_\\w+.a&sdcard\\w*.?o?"             => "SDCARD_RAM",

    # ESDHC
    ".(text|rodata|data)&(twrmcf|twrmpc|m)5[124]\\w*.a&e?sdhc\\w*.?o?" => "ESDHC_ROM",
    ".(text|rodata|data)&bsp.a|bsp_\\w+.a&e?sdhc\\w*.?o?"             => "ESDHC_ROM",
    ".(data|bss)&(twrmcf|twrmpc|m)5[124]\\w*.a&e?sdhc\\w*.?o?" => "ESDHC_RAM",
    ".(data|bss)&bsp.a|bsp_\\w+.a&e?sdhc\\w*.?o?"             => "ESDHC_RAM",

    # Clock management
    ".(text|rodata|data)&(twrmcf|twrmpc|m)5[124]\\w*.a&(bsp_)?cm\\w*.?o?" => "CM_ROM",
    ".(text|rodata|data)&bsp.a|bsp_\\w+.a&(bsp_)?cm\\w*.?o?"             => "CM_ROM",
    ".(data|bss)&(twrmcf|twrmpc|m)5[124]\\w*.a&(bsp_)?cm\\w*.?o?"  => "CM_RAM",
    ".(data|bss)&bsp.a|bsp_\\w+.a&e?(bsp_)?cm\\w*.?o?"                   => "CM_RAM",

    # Low Power management
    ".(text|rodata|data)&(twrmcf|twrmpc|m)5[124]\\w*.a&lpm\\w*.?o?" => "LPM_ROM",
    ".(text|rodata|data)&bsp.a|bsp_\\w+.a&(bsp_)?lpm\\w*.?o?"             => "LPM_ROM",
    ".(data|bss)&(twrmcf|twrmpc|m)5[124]\\w*.a&(bsp_)?lpm\\w*.?o?"  => "LPM_RAM",
    ".(data|bss)&bsp.a|bsp_\\w+.a&(bsp_)?lpm\\w*.?o?"                   => "LPM_RAM",

    # BSP Initialization
    ".(text|rodata|data)&(twrmcf|twrmpc|m)5[124]\\w*.a&init_(bsp|hw).o" => "BSP_INIT_ROM",
    ".(text|rodata|data)&bsp.a|bsp_\\w+.a&init_(bsp|hw).o"             => "BSP_INIT_ROM",
    ".(data|bss)&(twrmcf|twrmpc|m)5[124]\\w*.a&init_(bsp|hw).o"  => "BSP_INIT_RAM",
    ".(data|bss)&bsp.a|bsp_\\w+.a&init_(bsp|hw).o"                     => "BSP_INIT_RAM",

    # Kernel Objects
    ".bss&main.o" => "KERNEL_OBJECTS_RAM",
);

%MAP_KSDK =
(
    #TODO:
);

%MAP_CW_any = (
    # MSL system libraries
    ".rodata&\\w+(_MSL|_Runtime|fp_coldfire).[ao]" => "MSL_RODATA,MSL_ROM",
    ".text&\\w+(_MSL|_Runtime|_coldfire).[ao]" => "MSL_TEXT,MSL_ROM",
    ".s?data&\\w+(_MSL|_Runtime|_coldfire).[ao]" => "MSL_ROM,MSL_RAM",
    ".s?bss&\\w+(_MSL|_Runtime|_coldfire).[ao]" => "MSL_RAM",

    # EWL system libraries
    ".rodata&(libc|librt|libm)[0-9A-Za-z_]*.a" => "MSL_RODATA,MSL_ROM",
    ".text&(libc|librt|libm)[0-9A-Za-z_]*.a" => "MSL_TEXT,MSL_ROM",
    ".s?data&(libc|librt|libm)[0-9A-Za-z_]*.a" => "MSL_ROM,MSL_RAM",
    ".s?bss&(libc|librt|libm)[0-9A-Za-z_]*.a" => "MSL_RAM",

    ".vectors_rom&rom_vector" => "BSP_ROM",
    ".vectors_ram&ram_vector" => "BSP_RAM",
    ".vectors_rom&rom_vector&bsp\\w*.a" => "BSP_VECT_ROM",
    ".vectors_rom&ram_vector&bsp\\w*.a" => "BSP_VECT_RAM",
);

%MAP_CWMCF = (
    ".rodata|VECTORS&(twrmcf|m)5[124]\\w*.a" => "BSP_RODATA,BSP_ROM",
    ".rodata|VECTORS&bsp.a|bsp_\\w+.a"             => "BSP_RODATA,BSP_ROM",

    ".vectors_rom&rom_vector&(twrmcf|m)5[124]\\w*.a" => "BSP_VECT_ROM",

    %MAP_CW_any,
);

%MAP_CWARM = (

    %MAP_CW_any,
);

%MAP_CWMPC = (
    "Linker" => "dont_use_BSP_VECT_ROM",
    ".vector[0-9A-Fa-f_]+" => "dont_use_BSP_VECT_ROM",
    "__system_reset" => "dont_use_BSP_VECT_ROM",

    # for PPC
    ".rodata&(MSL_C|Runtime).PPCEABI(.\\w+)*.[ao]" => "MSL_RODATA,MSL_ROM",
    ".text|.text_vle|.init&(MSL_C|Runtime).PPCEABI(.\\w+)*.[ao]" => "MSL_TEXT,MSL_ROM",
    ".s?data&(MSL_C|Runtime).PPCEABI(.\\w+)*.[ao]" => "MSL_ROM,MSL_RAM",
    ".s?bss&(MSL_C|Runtime).PPCEABI(.\\w+)*.[ao]" => "MSL_RAM",
    "(.init|.ctors|.dtors|.text_vle)(\\\$\\d+)?&(libc|librt|libm)[0-9A-Za-z_]*.a" => "MSL_TEXT,MSL_ROM",

    "(.ivor|.__bam|.__exception_handlers)(\\w*)" => "BSP_VECT_ROM",

    %MAP_CW_any,
);

%MAP_IARARM = (
    "ICODE|vectors.o&bsp.a|bsp_\\w+.a"               => "BSP_ROM,BSP_VECT_ROM",
    ".intvec|vectors.o&bsp.a|bsp_\\w+.a"             => "BSP_RODATA,BSP_ROM,BSP_VECT_ROM",

    # ARM system libraries
    ".rodata&(rt|dl|m)[67]M_t[bl]\\w*.a" => "MSL_RODATA,MSL_ROM",
    ".text&(rt|dl|m)[67]M_t[bl]\\w*.a" => "MSL_TEXT,MSL_ROM",
    ".s?data&(rt|dl|m)[67]M_t[bl]\\w*.a" => "MSL_ROM,MSL_RAM",
    ".s?bss&(rt|dl|m)[67]M_t[bl]\\w*.a" => "MSL_RAM",

    ".rodata&sh[bis]_[bl].a" => "MSL_RODATA,MSL_ROM",
    ".text&sh[bis]_[bl].a" => "MSL_TEXT,MSL_ROM",
    ".s?data&sh[bis]_[bl].a" => "MSL_ROM,MSL_RAM",
    ".s?bss&sh[bis]_[bl].a" => "MSL_RAM",

    # special case (data not in .data section)
    "__iar_Errno&(rt|dl|m)[67]M_t[bl]\\w*.a" => "MSL_RAM",
);

###############################################################
#
# Standard section lists for report generation
#

@MQX_KERNEL_OBJECTS = (
    ":---\n### MQX KERNEL (RAM) ###",
    "MQX_QUEUE_STRUCT",
    "MQX_LWSEM_STRUCT",
    "MQX_QUEUE_ELEMENT_STRUCT",
    "MQX_TASK_QUEUE_STRUCT",
    "MQX_KERNEL_DATA_STRUCT",
    "MQX_TD_STRUCT",
    "MQX_READY_Q_STRUCT",
    "MQX_NAME_STRUCT",
    "MQX_NAME_COMPONENT_STRUCT",
    "MQX_EVENT_COMPONENT_STRUCT",
    "MQX_EVENT_STRUCT",
    "MQX_EVENT_CONNECTION_STRUCT",
    "MQX_FILE",
    "MQX_IO_DEVICE_STRUCT",
    "MQX_LOG_HEADER_STRUCT",
    "MQX_LOG_COMPONENT_STRUCT",
    "MQX_LWEVENT_STRUCT",
    "MQX_LWLOG_ENTRY_STRUCT",
    "MQX_LWLOG_HEADER_STRUCT",
    "MQX_LWLOG_COMPONENT_STRUCT",
    "MQX_LWMEM_POOL_STRUCT",
    "MQX_LWMEM_BLOCK_STRUCT",
    "MQX_LWMSGQ_STRUCT",
    "MQX_LWTIMER_STRUCT",
    "MQX_LWTIMER_PERIOD_STRUCT",
    "MQX_MESSAGE_HEADER_STRUCT",
    "MQX_MSGPOOL_BLOCK_STRUCT",
    "MQX_MSGPOOL_STRUCT",
    "MQX_INTERNAL_MESSAGE_STRUCT",
    "MQX_MSGQ_STRUCT",
    "MQX_MSG_COMPONENT_STRUCT",
    "MQX_MUTEX_ATTR_STRUCT",
    "MQX_MUTEX_STRUCT",
    "MQX_MUTEX_COMPONENT_STRUCT",
    "MQX_PARTPOOL_BLOCK_STRUCT",
    "MQX_PARTPOOL_STRUCT",
    "MQX_INTERNAL_PARTITION_BLOCK_STRUCT",
    "MQX_PARTITION_COMPONENT_STRUCT",
    "MQX_SEM_COMPONENT_STRUCT",
    "MQX_SEM_STRUCT",
    "MQX_SEM_CONNECTION_STRUCT",
    "MQX_TIMER_ENTRY_STRUCT",
    "MQX_TIMER_COMPONENT_STRUCT",
    "MQX_WATCHDOG_ALARM_TABLE_STRUCT",
    "MQX_WATCHDOG_COMPONENT_STRUCT",
);

###############################################################
#
# Standard section lists for report generation
#

@PSP_ROM_COMPONENTS = (
    ":---\n### MQX Core Components Code (ROM) ###",
    "CORE_ROM",
    "STRING_ROM",
    "SCHED_ROM",
    "INT_ROM",
    "LWMEM_ROM",
    "LWSEM_ROM",
    "MEM_ROM",
    "QUEUE_ROM",
    "TASK_ROM",
    "TIME_ROM",
    "TQ_ROM",
    ":### MQX Optional Components ###",
    "EVENT_ROM",
    "IDLE_ROM",
    "IO_ROM",
    "KLOG_ROM",
    "LWEVENT_ROM",
    "LWLOG_ROM",
    "LWMSG_ROM",
    "LWTIMER_ROM",
    "LOG_ROM",
    "MSG_ROM",
    "MUTEX_ROM",
    "SEM_ROM",
    "NAME_ROM",
    "PART_ROM",
    "MPU_ROM",
);

@PSP_ROM_COMPONENTS2 =
(
    "+MQX_ROM", ### other + subtotal
);

@PSP_RAM_COMPONENTS = (
    ":---\n### MQX Core Components Global Data (RAM) ###",
    "CORE_RAM",
    "STRING_RAM",
    "SCHED_RAM",
    "INT_RAM",
    "LWMEM_RAM",
    "LWSEM_RAM",
    "MEM_RAM",
    "QUEUE_RAM",
    "TASK_RAM",
    "TIME_RAM",
    "TQ_RAM",
    ":### MQX Optional Components ###",
    "EVENT_RAM",
    "IDLE_RAM",
    "IO_RAM",
    "KLOG_RAM",
    "LWEVENT_RAM",
    "LWLOG_RAM",
    "LWMSG_RAM",
    "LWTIMER_RAM",
    "LOG_RAM",
    "MSG_RAM",
    "MUTEX_RAM",
    "SEM_RAM",
    "NAME_RAM",
    "PART_RAM",
    "MPU_RAM",

    "+MQX_RAM", ### other + subtotal
);

@BSP_ROM_COMPONENTS = (
    ":---\n### MQX BSP Code (ROM) ###",
    "BSP_VECT_ROM",
    "BSP_BOOTSTRAP_ROM",
    "BSP_INIT_ROM",
    "BSP_INT_ROM",
    "CM_ROM",
    "LPM_ROM",
    "ADC_ROM",
    "APCFLASH_ROM",
    "ENET_ROM",
    "ENET_PHY_ROM",
    "ENET_FEC_ROM",
    "NAND_ROM",
    "FLASH_ROM",
    "GPIO_ROM",
    "I2C_ROM",
    "PCCARD_ROM",
    "RTC_ROM",
    "Serial_ROM",
    "SPI_ROM",
    "FlexCAN_ROM",
    "msCAN_ROM",
    "Display_ROM",
    "DIU_ROM",
    "TFS_ROM",
    "TIMER_ROM",
    "SDCARD_ROM",
    "ESDHC_ROM",
);

@BSP_ROM_COMPONENTS2 = (
    "+BSP_ROM", ### other + subtotal
);

@BSP_RAM_COMPONENTS = (
    ":---\n### MQX BSP Global Data (RAM) ###",
    "BSP_VECT_RAM",
    "BSP_INT_RAM",
    "BSP_INIT_RAM",
    "CM_RAM",
    "LPM_RAM",
    "ADC_RAM",
    "APCFLASH_RAM",
    "ENET_RAM",
    "ENET_PHY_RAM",
    "ENET_FEC_RAM",
    "NAND_RAM",
    "FLASH_RAM",
    "GPIO_RAM",
    "I2C_RAM",
    "PCCARD_RAM",
    "RTC_RAM",
    "Serial_RAM",
    "SPI_RAM",
    "FlexCAN_RAM",
    "msCAN_RAM",
    "Display_RAM",
    "DIU_RAM",
    "TFS_RAM",
    "TIMER_RAM",
    "SDCARD_RAM",
    "ESDHC_RAM",
    "+BSP_RAM", ### other + subtotal
);

@SUMM_ROM_COMPONENTS = (
    ":---\n### Summary of MQX Libraries Code (ROM) ###",
    "MQX_ROM",
    "BSP_ROM",
    "MFS_ROM",
    "RTCS_ROM",
    "USBH_ROM",
    "USBD_ROM",
    "KSDK_ROM",
    "MQX_STD_ROM",
    "SHELL_ROM",
    ":### System Libraries Code (ROM) ###",
    "MSL_ROM",
    ":### User Application-related Code (ROM) ###",
    "APP_ROM",
    ":---\n### Overall Total ###",
    "_TOTAL_ROM",
);

@SUMM_RAM_COMPONENTS = (
    ":---\n### Summary of MQX Libraries Global Data (RAM) ###",
    "MQX_RAM",
    "BSP_RAM",
    "MFS_RAM",
    "RTCS_RAM",
    "USBH_RAM",
    "USBD_RAM",
    "SHELL_RAM",
    ":### System Libraries (RAM) ###",
    "MSL_RAM",
    ":### User Application-related (RAM) ###",
    "APP_RAM",
    ":---\n### Overall Total ###",
    "_TOTAL_RAM",
);

@KSDK_ROM_COMPONENTS = (
    ":---\n### MQX KSDK Code (ROM) ###",
);

#####################################
#
# MFS-related maps
#

%MAP_MFS =
(
    #PARSER
    ".(text|rodata|data)&Shell(_regabi)?(_d)?.a&(dir_read|mfs_dir_entry|mfs_directory)\\w*.o" => "SHELL_PARSER",
    ".(text|rodata|data)&shell.a|mfs_\\w+.a&(dir_read|mfs_dir_entry|mfs_directory)\\w*.o"           => "MFS_DIR_ROM",
    ".(data|bss)&shell(_regabi)?(_d)?.a&(dir_read|mfs_dir_entry|mfs_directory)\\w*.o" => "MFS_DIR_RAM",
    ".(data|bss)&shell.a|mfs_\\w+.a&(dir_read|mfs_dir_entry|mfs_directory)\\w*.o"           => "MFS_DIR_RAM",

    #DIRECTORY
    ".(text|rodata|data)&mfs(_regabi)?(_d)?.a&(dir_read|mfs_dir_entry|mfs_directory)\\w*.o" => "MFS_DIR_ROM",
    ".(text|rodata|data)&mfs.a|mfs_\\w+.a&(dir_read|mfs_dir_entry|mfs_directory)\\w*.o"           => "MFS_DIR_ROM",
    ".(data|bss)&mfs(_regabi)?(_d)?.a&(dir_read|mfs_dir_entry|mfs_directory)\\w*.o" => "MFS_DIR_RAM",
    ".(data|bss)&mfs.a|mfs_\\w+.a&(dir_read|mfs_dir_entry|mfs_directory)\\w*.o"           => "MFS_DIR_RAM",

    #ATTRIBUTE
    ".(text|rodata|data)&mfs(_regabi)?(_d)?.a&(mfs_attribute)\\w*.o" => "MFS_ATTRI_ROM",
    ".(text|rodata|data)&mfs.a|mfs_\\w+.a&(mfs_attributey)\\w*.o"          => "MFS_ATTRI_ROM",
    ".(data|bss)&mfs(_regabi)?(_d)?.a&(mfs_attribute)\\w*.o" => "MFS_ATTRI_RAM",
    ".(data|bss)&mfs.a|mfs_\\w+.a&(mfs_attribute)\\w*.o"           => "MFS_ATTRI_RAM",

    #CLUSTER
    ".(text|rodata|data)&mfs(_regabi)?(_d)?.a&(mfs_cluster)\\w*.o" => "MFS_CLUS_ROM",
    ".(text|rodata|data)&mfs.a|mfs_\\w+.a&(mfs_cluster)\\w*.o"           => "MFS_CLUS_ROM",
    ".(data|bss)&mfs(_regabi)?(_d)?.a&(mfs_cluster)\\w*.o" => "MFS_CLUS_RAM",
    ".(data|bss)&mfs.a|mfs_\\w+.a&(mfs_cluster)\\w*.o"           => "MFS_CLUS_RAM",

    #DELETE
    ".(text|rodata|data)&mfs(_regabi)?(_d)?.a&(mfs_delete)\\w*.o" => "MFS_DEL_ROM",
    ".(text|rodata|data)&mfs.a|mfs_\\w+.a&(mfs_delete)\\w*.o"           => "MFS_DEL_ROM",
    ".(data|bss)&mfs(_regabi)?(_d)?.a&(mfs_delete)\\w*.o" => "MFS_DEL_RAM",
    ".(data|bss)&mfs.a|mfs_\\w+.a&(mfs_delete)\\w*.o"           => "MFS_DEL_RAM",

    #FAT
    ".(text|rodata|data)&mfs(_regabi)?(_d)?.a&(mfs_fat)\\w*.o" => "MFS_FAT_ROM",
    ".(text|rodata|data)&mfs.a|mfs_\\w+.a&(mfs_fat)\\w*.o"           => "MFS_FAT_ROM",
    ".(data|bss)&mfs(_regabi)?(_d)?.a&(mfs_fat)\\w*.o" => "MFS_FAT_RAM",
    ".(data|bss)&mfs.a|mfs_\\w+.a&(mfs_fat)\\w*.o"           => "MFS_FAT_RAM",

    #FORMAT
    ".(text|rodata|data)&mfs(_regabi)?(_d)?.a&(mfs_format)\\w*.o" => "MFS_FORMA_ROM",
    ".(text|rodata|data)&mfs.a|mfs_\\w+.a&(mfs_format)\\w*.o"           => "MFS_FORMA_ROM",
    ".(data|bss)&mfs(_regabi)?(_d)?.a&(mfs_format)\\w*.o" => "MFS_FORMA_RAM",
    ".(data|bss)&mfs.a|mfs_\\w+.a&(mfs_format)\\w*.o"           => "MFS_FORMA_RAM",

    #HANDLE
    ".(text|rodata|data)&mfs(_regabi)?(_d)?.a&(mfs_handle)\\w*.o" => "MFS_HANDLE_ROM",
    ".(text|rodata|data)&mfs.a|mfs_\\w+.a&(mfs_handle)\\w*.o"           => "MFS_HANDLE_ROM",
    ".(data|bss)&mfs(_regabi)?(_d)?.a&(mfs_handle)\\w*.o" => "MFS_HANDLE_RAM",
    ".(data|bss)&mfs.a|mfs_\\w+.a&(mfs_handle)\\w*.o"           => "MFS_HANDLE_RAM",

    #LONG_FILE_NAME
    ".(text|rodata|data)&mfs(_regabi)?(_d)?.a&(mfs_lfn)\\w*.o" => "MFS_LFN_ROM",
    ".(text|rodata|data)&mfs.a|mfs_\\w+.a&(mfs_lfn)\\w*.o"           => "MFS_LFN_ROM",
    ".(data|bss)&mfs(_regabi)?(_d)?.a&(mfs_lfn)\\w*.o" => "MFS_LFN_RAM",
    ".(data|bss)&mfs.a|mfs_\\w+.a&(mfs_lfn)\\w*.o"           => "MFS_LFN_RAM",

    #RENAME
    ".(text|rodata|data)&mfs(_regabi)?(_d)?.a&(mfs_rename)\\w*.o" => "MFS_RENAME_ROM",
    ".(text|rodata|data)&mfs.a|mfs_\\w+.a&(mfs_rename)\\w*.o"           => "MFS_RENAME_ROM",
    ".(data|bss)&mfs(_regabi)?(_d)?.a&(mfs_rename)\\w*.o" => "MFS_RENAME_RAM",
    ".(data|bss)&mfs.a|mfs_\\w+.a&(mfs_rename)\\w*.o"           => "MFS_RENAME_RAM",

    #MISC
    ".(text|rodata|data)&mfs(_regabi)?(_d)?.a&(mfs_misc)\\w*.o" => "MFS_MISC_ROM",
    ".(text|rodata|data)&mfs.a|mfs_\\w+.a&(mfs_misc)\\w*.o"           => "MFS_MISC_ROM",
    ".(data|bss)&mfs(_regabi)?(_d)?.a&(mfs_misc)\\w*.o" => "MFS_MISC_RAM",
    ".(data|bss)&mfs.a|mfs_\\w+.a&(mfs_misc)\\w*.o"           => "MFS_MISC_RAM",

    #OPEN
    ".(text|rodata|data)&mfs(_regabi)?(_d)?.a&(mfs_open)\\w*.o" => "MFS_OPEN_ROM",
    ".(text|rodata|data)&mfs.a|mfs_\\w+.a&(mfs_open)\\w*.o"           => "MFS_OPEN_ROM",
    ".(data|bss)&mfs(_regabi)?(_d)?.a&(mfs_open)\\w*.o" => "MFS_OPEN_RAM",
    ".(data|bss)&mfs.a|mfs_\\w+.a&(mfs_open)\\w*.o"           => "MFS_OPEN_RAM",

    #READ_WRITE
    ".(text|rodata|data)&mfs(_regabi)?(_d)?.a&(mfs_rw|mfs_read|mfs_write)\\w*.o" => "MFS_RW_ROM",
    ".(text|rodata|data)&mfs.a|mfs_\\w+.a&(mfs_rw|mfs_read|mfs_write)\\w*.o"           => "MFS_RW_ROM",
    ".(data|bss)&mfs(_regabi)?(_d)?.a&(mfs_rw|mfs_read|mfs_write)\\w*.o" => "MFS_RW_RAM",
    ".(data|bss)&mfs.a|mfs_\\w+.a&(mfs_rw|mfs_read|mfs_write)\\w*.o"           => "MFS_RW_RAM",

    #PARSE
    ".(text|rodata|data)&mfs(_regabi)?(_d)?.a&(mfs_parse)\\w*.o" => "MFS_PARSE_ROM",
    ".(text|rodata|data)&mfs.a|mfs_\\w+.a&(mfs_parse)\\w*.o"           => "MFS_PARSE_ROM",
    ".(data|bss)&mfs(_regabi)?(_d)?.a&(mfs_parse)\\w*.o" => "MFS_PARSE_RAM",
    ".(data|bss)&mfs.a|mfs_\\w+.a&(mfs_parse)\\w*.o"           => "MFS_PARSE_RAM",

    #SEARCH
    ".(text|rodata|data)&mfs(_regabi)?(_d)?.a&(mfs_search)\\w*.o" => "MFS_SEARCH_ROM",
    ".(text|rodata|data)&mfs.a|mfs_\\w+.a&(mfs_search)\\w*.o"           => "MFS_SEARCH_ROM",
    ".(data|bss)&mfs(_regabi)?(_d)?.a&(mfs_search)\\w*.o" => "MFS_SEARCH_RAM",
    ".(data|bss)&mfs.a|mfs_\\w+.a&(mfs_search)\\w*.o"           => "MFS_SEARCH_RAM",

    #TIME
    ".(text|rodata|data)&mfs(_regabi)?(_d)?.a&(mfs_time|mfs_valdev)\\w*.o" => "MFS_TIME_ROM",
    ".(text|rodata|data)&mfs.a|mfs_\\w+.a&(mfs_time|mfs_valdev)\\w*.o"           => "MFS_TIME_ROM",
    ".(data|bss)&mfs(_regabi)?(_d)?.a&(mfs_time|mfs_valdev)\\w*.o" => "MFS_TIME_RAM",
    ".(data|bss)&mfs.a|mfs_\\w+.a&(mfs_time|mfs_valdev)\\w*.o"           => "MFS_TIME_RAM",

    #PARTITION MANAGER
    ".(text|rodata|data)&mfs(_regabi)?(_d)?.a&(part_mgr)\\w*.o" => "MFS_PMGR_ROM",
    ".(text|rodata|data)&mfs.a|mfs_\\w+.a&(part_mgr)\\w*.o"           => "MFS_PMGR_ROM",
    ".(data|bss)&mfs(_regabi)?(_d)?.a&(part_mgr)\\w*.o" => "MFS_PMGR_RAM",
    ".(data|bss)&mfs.a|mfs_\\w+.a&(part_mgr)\\w*.o"           => "MFS_PMGR_RAM",
);

#
# MFS Section lists for report generation
#

@MFS_ROM_COMPONENTS =
(
    ":---\n### Detailed breakdown of MFS Code (ROM) ###",

    "MFS_DIR_ROM",
    "MFS_ATTRI_ROM",
    "MFS_CLUS_ROM",
    "MFS_DEL_ROM",
    "MFS_FAT_ROM",
    "MFS_FORMA_ROM",
    "MFS_HANDLE_ROM",
    "MFS_LFN_ROM",
    "MFS_RENAME_ROM",
    "MFS_MISC_ROM",
    "MFS_OPEN_ROM",
    "MFS_RW_ROM",
    "MFS_PARSE_ROM",
    "MFS_SEARCH_ROM",
    "MFS_TIME_ROM",
    "MFS_PMGR_ROM",
);

@MFS_ROM_COMPONENTS2 =
(
    "+MFS_ROM", ### other + subtotal
);

@MFS_RAM_COMPONENTS =
(
    ":---\n### Detailed breakdown of MFS Global Data (RAM) ###",
    "MFS_DIR_RAM",
    "MFS_ATTRI_RAM",
    "MFS_CLUS_RAM",
    "MFS_DEL_RAM",
    "MFS_FAT_RAM",
    "MFS_FORMA_RAM",
    "MFS_HANDLE_RAM",
    "MFS_LFN_RAM",
    "MFS_RENAME_RAM",
    "MFS_MISC_RAM",
    "MFS_OPEN_RAM",
    "MFS_RW_RAM",
    "MFS_PARSE_RAM",
    "MFS_SEARCH_RAM",
    "MFS_TIME_RAM",
    "MFS_PMGR_RAM",
    "+MFS_RAM",
);

#####################################
#
# RTCS
#

%MAP_RTCS =
(
    # HTTP server
    ".(text|rodata|data)&rtcs(_regabi)?(_d)?.a&(httpsrv|httpsrv_supp|httpsrv_task).o" => "RTCS_HTTPSRV_ROM",
    ".(text|rodata|data)&rtcs.a|rtcs_\\w+.a&(httpsrv|httpsrv_supp|httpsrv_task).o"           => "RTCS_HTTPSRV_ROM",
    ".(data|bss)&rtcs(_regabi)?(_d)?.a&(httpsrv|httpsrv_supp|httpsrv_task).o" => "RTCS_HTTPSRV_RAM",
    ".(data|bss)&rtcs.a|rtcs_\\w+.a&(httpsrv|httpsrv_supp|httpsrv_task).o"           => "RTCS_HTTPSRV_RAM",

    # FTP
    ".(text|rodata|data)&rtcs(_regabi)?(_d)?.a&(ftpclnt|ftpsrv|ftpsrv_cmd|ftpsrv_cmd_file|ftpsrv_cmd_transfer|ftpsrv_msg|ftpsrv_supp|ftpsrv_task).o" => "RTCS_FTP_ROM",
    ".(text|rodata|data)&rtcs.a|rtcs_\\w+.a&(ftpclnt|ftpsrv|ftpsrv_cmd|ftpsrv_cmd_file|ftpsrv_cmd_transfer|ftpsrv_msg|ftpsrv_supp|ftpsrv_task).o"           => "RTCS_FTP_ROM",
    ".(data|bss)&rtcs(_regabi)?(_d)?.a&(ftpclnt|ftpsrv|ftpsrv_cmd|ftpsrv_cmd_file|ftpsrv_cmd_transfer|ftpsrv_msg|ftpsrv_supp|ftpsrv_task).o" => "RTCS_FTP_RAM",
    ".(data|bss)&rtcs.a|rtcs_\\w+.a&(ftpclnt|ftpsrv|ftpsrv_cmd|ftpsrv_cmd_file|ftpsrv_cmd_transfer|ftpsrv_msg|ftpsrv_supp|ftpsrv_task).o"           => "RTCS_FTP_RAM",

    # TELNETD
    ".(text|rodata|data)&rtcs(_regabi)?(_d)?.a&(telnet|telnetio|telnsrv).o" => "RTCS_TELD_ROM",
    ".(text|rodata|data)&rtcs.a|rtcs_\\w+.a&(telnet|telnetio|telnsrv).o"           => "RTCS_TELD_ROM",
    ".(data|bss)&rtcs(_regabi)?(_d)?.a&(telnet|telnetio|telnsrv).o" => "RTCS_TELD_RAM",
    ".(data|bss)&rtcs.a|rtcs_\\w+.a&(telnet|telnetio|telnsrv).o"           => "RTCS_TELD_RAM",

    # ECHO
    ".(text|rodata|data)&rtcs(_regabi)?(_d)?.a&(echosrv).o" => "RTCS_ECHO_ROM",
    ".(text|rodata|data)&rtcs.a|rtcs_\\w+.a&(echosrv).o"           => "RTCS_ECHO_ROM",
    ".(data|bss)&rtcs(_regabi)?(_d)?.a&(echosrv).o" => "RTCS_ECHO_RAM",
    ".(data|bss)&rtcs.a|rtcs_\\w+.a&(echosrv).o"           => "RTCS_ECHO_RAM",

    # EDS
    #".(text|rodata|data)&rtcs(_regabi)?(_d)?.a&(eds).o" => "RTCS_EDS_ROM",
    #".(text|rodata|data)&rtcs.a|rtcs_\\w+.a&(eds).o"           => "RTCS_EDS_ROM",
    #".(data|bss)&rtcs(_regabi)?(_d)?.a&(eds).o" => "RTCS_EDS_RAM",
    #".(data|bss)&rtcs.a|rtcs_\\w+.a&(eds).o"           => "RTCS_EDS_RAM",

    #TFTP
    ".(text|rodata|data)&rtcs(_regabi)?(_d)?.a&(loadtb|loadtc|loadts|tftp|tftpacc|tftpsrv|tftputil).o" => "RTCS_TFTP_ROM",
    ".(text|rodata|data)&rtcs.a|rtcs_\\w+.a&(loadtb|loadtc|loadts|tftp|tftpacc|tftpsrv|tftputil).o"           => "RTCS_TFTP_ROM",
    ".(data|bss)&rtcs(_regabi)?(_d)?.a&(loadtb|loadtc|loadts|tftp|tftpacc|tftpsrv|tftputil).o" => "RTCS_TFTP_RAM",
    ".(data|bss)&rtcs.a|rtcs_\\w+.a&(loadtb|loadtc|loadts|tftp|tftpacc|tftpsrv|tftputil).o"           => "RTCS_TFTP_RAM",

    #SOCKET
    ".(text|rodata|data)&rtcs(_regabi)?(_d)?.a&(sockio|sdgram|sockutil|soip|sosel0|sosel1|soselset|sosock|sotcp|soudp|sstream|soselall|soigmp).o" => "RTCS_SOCK_ROM",
    ".(text|rodata|data)&rtcs.a|rtcs_\\w+.a&(sockio|sdgram|sockutil|soip|sosel0|sosel1|soselset|sosock|sotcp|soudp|sstream|soselall|soigmp).o"           => "RTCS_SOCK_ROM",
    ".(data|bss)&rtcs(_regabi)?(_d)?.a&(sockio|sdgram|sockutil|soip|sosel0|sosel1|soselset|sosock|sotcp|soudp|sstream|soselall|soigmp).o" => "RTCS_SOCK_RAM",
    ".(data|bss)&rtcs.a|rtcs_\\w+.a&(sockio|sdgram|sockutil|soip|sosel0|sosel1|soselset|sosock|sotcp|soudp|sstream|soselall|soigmp).o"           => "RTCS_SOCK_RAM",

    #DNS
    ".(text|rodata|data)&rtcs(_regabi)?(_d)?.a&(dnsinit|resolver|dnsutil|ifdns|dnshosts).o" => "RTCS_DNS_ROM",
    ".(text|rodata|data)&rtcs.a|rtcs_\\w+.a&(dnsinit|resolver|dnsutil|ifdns|dnshosts).o"           => "RTCS_DNS_ROM",
    ".(data|bss)&rtcs(_regabi)?(_d)?.a&(dnsinit|resolver|dnsutil|ifdns|dnshosts).o" => "RTCS_DNS_RAM",
    ".(data|bss)&rtcs.a|rtcs_\\w+.a&(dnsinit|resolver|dnsutil|ifdns|dnshosts).o"           => "RTCS_DNS_RAM",

    #RTCS
    ".(text|rodata|data)&rtcs(_regabi)?(_d)?.a&(ifadd|ifbootp|ifdhcp|ifrem|ifppp|rtcscmd|inet_ntop|inet_pton|rtcs\\w*).o" => "RTCS_RTCS4_ROM",
    ".(text|rodata|data)&rtcs.a|rtcs_\\w+.a&(ifadd|ifbootp|ifdhcp|ifrem|ifppp|rtcscmd|inet_ntop|inet_pton|rtcs\\w*).o"           => "RTCS_RTCS4_ROM",
    ".(data|bss)&rtcs(_regabi)?(_d)?.a&(ifadd|ifbootp|ifdhcp|ifrem|ifppp|rtcscmd|inet_ntop|inet_pton|rtcs\\w*).o" => "RTCS_RTCS4_RAM",
    ".(data|bss)&rtcs.a|rtcs_\\w+.a&(ifadd|ifbootp|ifdhcp|ifrem|ifppp|rtcscmd|inet_ntop|inet_pton|rtcs\\w*).o"           => "RTCS_RTCS4_RAM",

    #RTCSv6
    ".(text|rodata|data)&rtcs(_regabi)?(_d)?.a&(ip6_if).o" => "RTCS_RTCS6_ROM",
    ".(text|rodata|data)&rtcs.a|rtcs_\\w+.a&(ip6_if).o"           => "RTCS_RTCS6_ROM",
    ".(data|bss)&rtcs(_regabi)?(_d)?.a&(ip6_if).o" => "RTCS_RTCS6_RAM",
    ".(data|bss)&rtcs.a|rtcs_\\w+.a&(ip6_if).o"           => "RTCS_RTCS6_RAM",

    #IPC
    #".(text|rodata|data)&rtcs(_regabi)?(_d)?.a&(ipcfg|ipcp)\\w*.o" => "RTCS_IPC_ROM",
    #".(text|rodata|data)&rtcs.a|rtcs_\\w+.a&(ipcfg|ipcp)\\w*.o"           => "RTCS_IPC_ROM",
    #".(data|bss)&rtcs(_regabi)?(_d)?.a&(ipcfg|ipcp)\\w*.o" => "RTCS_IPC_RAM",
    #".(data|bss)&rtcs.a|rtcs_\\w+.a&(ipcfg|ipcp)\\w*.o"           => "RTCS_IPC_RAM",

    #ARP
    ".(text|rodata|data)&rtcs(_regabi)?(_d)?.a&(arp|arpinit|proxyarp).o" => "RTCS_ARP_ROM",
    ".(text|rodata|data)&rtcs.a|rtcs_\\w+.a&(arp|arpinit|proxyarp).o"           => "RTCS_ARP_ROM",
    ".(data|bss)&rtcs(_regabi)?(_d)?.a&(arp|arpinit|proxyarp).o" => "RTCS_ARP_RAM",
    ".(data|bss)&rtcs.a|rtcs_\\w+.a&(arp|arpinit|proxyarp).o"           => "RTCS_ARP_RAM",

    #IP
    ".(text|rodata|data)&rtcs(_regabi)?(_d)?.a&(ipcfg|ipcp|ip-e|ip|ip_reasm|ipif_add|ipif_rem|iplocal|iproute|ipradix|iputil|checksum|rip|route).o" => "RTCS_IP_ROM",
    ".(text|rodata|data)&rtcs.a|rtcs_\\w+.a&(ipcfg|ipcp|ip-e|ip|ip_reasm|ipif_add|ipif_rem|iplocal|iproute|ipradix|iputil|checksum|rip|route).o"           => "RTCS_IP_ROM",
    ".(data|bss)&rtcs(_regabi)?(_d)?.a&(ipcfg|ipcp|ip-e|ip|ip_reasm|ipif_add|ipif_rem|iplocal|iproute|ipradix|iputil|checksum|rip|route).o" => "RTCS_IP_RAM",
    ".(data|bss)&rtcs.a|rtcs_\\w+.a&(ipcfg|ipcp|ip-e|ip|ip_reasm|ipif_add|ipif_rem|iplocal|iproute|ipradix|iputil|checksum|rip|route).o"           => "RTCS_IP_RAM",

    #IPv6
    ".(text|rodata|data)&rtcs(_regabi)?(_d)?.a&(ipcfg6|ip6-e|ip6|ip6_if|ip6_reasm|ip6_trace|iplocal6|checksum6|nd6).o" => "RTCS_IP6_ROM",
    ".(text|rodata|data)&rtcs.a|rtcs_\\w+.a&(ipcfg6|ip6-e|ip6|ip6_if|ip6_reasm|ip6_trace|iplocal6|checksum6|nd6).o"           => "RTCS_IP6_ROM",
    ".(data|bss)&rtcs(_regabi)?(_d)?.a&(ipcfg6|ip6-e|ip6|ip6_if|ip6_reasm|ip6_trace|iplocal6|checksum6|nd6).o" => "RTCS_IP6_RAM",
    ".(data|bss)&rtcs.a|rtcs_\\w+.a&(ipcfg6|ip6-e|ip6|ip6_if|ip6_reasm|ip6_trace|iplocal6|checksum6|nd6).o"           => "RTCS_IP6_RAM",

    #MLD
    ".(text|rodata|data)&rtcs(_regabi)?(_d)?.a&(mld).o" => "RTCS_MLD_ROM",
    ".(text|rodata|data)&rtcs.a|rtcs_\\w+.a&(mld).o"    => "RTCS_IP6_ROM",
    ".(data|bss)&rtcs(_regabi)?(_d)?.a&(mld).o" => "RTCS_MLD_RAM",
    ".(data|bss)&rtcs.a|rtcs_\\w+.a&(mld).o"           => "RTCS_MLD_RAM",

    #PPP
    ".(text|rodata|data)&rtcs(_regabi)?(_d)?.a&(lcp|pktrx|pkttx|ppp|pppfsm|ppphdlc|pppglob)\\w*.o" => "RTCS_PPP_ROM",
    ".(text|rodata|data)&rtcs.a|rtcs_\\w+.a&(lcp|pktrx|pkttx|ppp|pppfsm|ppphdlc|pppglob)\\w*.o"           => "RTCS_PPP_ROM",
    ".(data|bss)&rtcs(_regabi)?(_d)?.a&(lcp|pktrx|pkttx|ppp|pppfsm|ppphdlc|pppglob)\\w*.o" => "RTCS_PPP_RAM",
    ".(data|bss)&rtcs.a|rtcs_\\w+.a&(lcp|pktrx|pkttx|ppp|pppfsm|ppphdlc|pppglob)\\w*.o"           => "RTCS_PPP_RAM",

    #MIB
    ".(text|rodata|data)&rtcs(_regabi)?(_d)?.a&(1213|mib)\\w*.o" => "RTCS_MIB_ROM",
    ".(text|rodata|data)&rtcs.a|rtcs_\\w+.a&(1213|mib)\\w*.o"           => "RTCS_MIB_ROM",
    ".(data|bss)&rtcs(_regabi)?(_d)?.a&(1213|mib)\\w*.o" => "RTCS_MIB_RAM",
    ".(data|bss)&rtcs.a|rtcs_\\w+.a&(1213|mib)\\w*.o"           => "RTCS_MIB_RAM",

    #SNMP
    ".(text|rodata|data)&rtcs(_regabi)?(_d)?.a&(snmp|traps)\\w*.o" => "RTCS_SNMP_ROM",
    ".(text|rodata|data)&rtcs.a|rtcs_\\w+.a&(snmp|traps)\\w*.o"           => "RTCS_SNMP_ROM",
    ".(data|bss)&rtcs(_regabi)?(_d)?.a&(snmp|traps)\\w*.o" => "RTCS_SNMP_RAM",
    ".(data|bss)&rtcs.a|rtcs_\\w+.a&(snmp|traps)\\w*.o"           => "RTCS_SNMP_RAM",

    #DHCP/BootP
    ".(text|rodata|data)&rtcs(_regabi)?(_d)?.a&(dhcpclnt|dhcputil|bootp|bootinit|bootcomm).o" => "RTCS_DHCP_ROM",
    ".(text|rodata|data)&rtcs.a|rtcs_\\w+.a&(dhcpclnt|dhcputil|bootp|bootinit|bootcomm).o"           => "RTCS_DHCP_ROM",
    ".(data|bss)&rtcs(_regabi)?(_d)?.a&(dhcpclnt|dhcputil|bootp|bootinit|bootcomm).o" => "RTCS_DHCP_RAM",
    ".(data|bss)&rtcs.a|rtcs_\\w+.a&(dhcpclnt|dhcputil|bootp|bootinit|bootcomm).o"           => "RTCS_DHCP_RAM",

    #ICMP
    ".(text|rodata|data)&rtcs(_regabi)?(_d)?.a&(icmp|ping).o" => "RTCS_ICMP_ROM",
    ".(text|rodata|data)&rtcs.a|rtcs_\\w+.a&(icmp|ping).o"           => "RTCS_ICMP_ROM",
    ".(data|bss)&rtcs(_regabi)?(_d)?.a&(icmp|ping).o" => "RTCS_ICMP_RAM",
    ".(data|bss)&rtcs.a|rtcs_\\w+.a&(icmp|ping).o"           => "RTCS_ICMP_RAM",

    #ICMPv6
    ".(text|rodata|data)&rtcs(_regabi)?(_d)?.a&(icmp6|ping6).o" => "RTCS_ICMP6_ROM",
    ".(text|rodata|data)&rtcs.a|rtcs_\\w+.a&(icmp6|ping6).o"           => "RTCS_ICMP6_ROM",
    ".(data|bss)&rtcs(_regabi)?(_d)?.a&(icmp6|ping6).o" => "RTCS_ICMP6_RAM",
    ".(data|bss)&rtcs.a|rtcs_\\w+.a&(icmp6|ping6).o"           => "RTCS_ICMP6_RAM",

    #IPSTAT
    ".(text|rodata|data)&rtcs(_regabi)?(_d)?.a&(ifstat).o" => "RTCS_IFSTAT_ROM",
    ".(text|rodata|data)&rtcs.a|rtcs_\\w+.a&(ifstat).o"           => "RTCS_IFSTAT_ROM",
    ".(data|bss)&rtcs(_regabi)?(_d)?.a&(ifstat).o" => "RTCS_IFSTAT_RAM",
    ".(data|bss)&rtcs.a|rtcs_\\w+.a&(ifstat).o"           => "RTCS_IFSTAT_RAM",

    #IGMP
    ".(text|rodata|data)&rtcs(_regabi)?(_d)?.a&(igmp|igmputil)\\w*.o" => "RTCS_IGMP_ROM",
    ".(text|rodata|data)&rtcs.a|rtcs_\\w+.a&(igmp|igmputil)\\w*.o"           => "RTCS_IGMP_ROM",
    ".(data|bss)&rtcs(_regabi)?(_d)?.a&(igmp|igmputil)\\w*.o" => "RTCS_IGMP_RAM",
    ".(data|bss)&rtcs.a|rtcs_\\w+.a&(igmp|igmputil)\\w*.o"           => "RTCS_IGMP_RAM",

    #TCP
    ".(text|rodata|data)&rtcs(_regabi)?(_d)?.a&(tcp|tcp_|tcpip|ticker|timer)\\w*.o" => "RTCS_TCP_ROM",
    ".(text|rodata|data)&rtcs.a|rtcs_\\w+.a&(tcp|tcp_|tcpip|ticker|timer)\\w*.o"           => "RTCS_TCP_ROM",
    ".(data|bss)&rtcs(_regabi)?(_d)?.a&(tcp|tcp_|tcpip|ticker|timer)\\w*.o" => "RTCS_TCP_RAM",
    ".(data|bss)&rtcs.a|rtcs_\\w+.a&(tcp|tcp_|tcpip|ticker|timer)\\w*.o"           => "RTCS_TCP_RAM",

    #UDP
    ".(text|rodata|data)&rtcs(_regabi)?(_d)?.a&udp\\w*.o" => "RTCS_UDP_ROM",
    ".(text|rodata|data)&rtcs.a|rtcs_\\w+.a&udp\\w*.o"           => "RTCS_UDP_ROM",
    ".(data|bss)&rtcs(_regabi)?(_d)?.a&udp\\w*.o" => "RTCS_UDP_RAM",
    ".(data|bss)&rtcs.a|rtcs_\\w+.a&udp\\w*.o"           => "RTCS_UDP_RAM",
);

#
# RTCS Sections list for report generation
#

@RTCS_ROM_COMPONENTS =
(
    ":---\n### Detailed breakdown of RTCS Code (ROM) ###",
    "RTCS_RTCS4_ROM",
    "RTCS_RTCS6_ROM",
    "RTCS_ARP_ROM",
    "RTCS_IP_ROM",
    "RTCS_IP6_ROM",
    "RTCS_MLD_ROM",
    "RTCS_ICMP_ROM",
    "RTCS_ICMP6_ROM",
    "RTCS_IGMP_ROM",
    "RTCS_TCP_ROM",
    "RTCS_UDP_ROM",
    "RTCS_SOCK_ROM",
    "RTCS_IFSTAT_ROM",
    ":### Application-level Protocols Code ###",
    "RTCS_HTTPSRV_ROM"    ,
    "RTCS_FTP_ROM",
    "RTCS_TELD_ROM",
    "RTCS_ECHO_ROM",
    #"RTCS_EDS_ROM",
    "RTCS_TFTP_ROM",
    "RTCS_DNS_ROM",
    #"RTCS_IPC_ROM",
    "RTCS_PPP_ROM",
    "RTCS_MIB_ROM",
    "RTCS_SNMP_ROM",
    "RTCS_DHCP_ROM",
);

@RTCS_ROM_COMPONENTS2 =
(
    "+RTCS_ROM", ### other + subtotal
);

@RTCS_RAM_COMPONENTS =
(
    ":---\n### Detailed breakdown of RTCS Global Data (RAM) ###",
    "RTCS_RTCS4_RAM",
    "RTCS_RTCS6_RAM",
    "RTCS_ARP_RAM",
    "RTCS_IP_RAM",
    "RTCS_IP6_RAM",
    "RTCS_MLD_RAM",
    "RTCS_ICMP_RAM",
    "RTCS_ICMP6_RAM",
    "RTCS_IGMP_RAM",
    "RTCS_TCP_RAM",
    "RTCS_UDP_RAM",
    "RTCS_SOCK_RAM",
    "RTCS_IFSTAT_RAM",
    ":### Application-level Protocols Global Data ###",
    "RTCS_HTTPSRV_RAM",
    "RTCS_FTP_RAM",
    "RTCS_TELD_RAM",
    "RTCS_ECHO_RAM",
    #"RTCS_EDS_RAM",
    "RTCS_TFTP_RAM",
    "RTCS_DNS_RAM",
   #"RTCS_IPC_RAM",
    "RTCS_PPP_RAM",
    "RTCS_MIB_RAM",
    "RTCS_SNMP_RAM",
    "RTCS_DHCP_RAM",

    "+RTCS_RAM", ### other + subtotal
);


#####################################
#
# USBH
#

%MAP_USBH =
(
    #USBH-COMMON
    ".(text|rodata|data)&usb_hdk(_regabi)?(_d)?.a&(host_common|host_main)\\w*.o" => "USBH_COMMON_ROM",
    ".(text|rodata|data)&usbh.a|usb_hdk_\\w+.a&(host_common|host_main)\\w*.o"    => "USBH_COMMON_ROM",
    ".(data|bss)&usb_hdk(_regabi)?(_d)?.a&(host_common|host_main)\\w*.o"         => "USBH_COMMON_RAM",
    ".(data|bss)&usbh.a|usb_hdk_\\w+.a&(host_common|host_main)\\w*.o"            => "USBH_COMMON_RAM",

    #HOST-SEND
    ".(text|rodata|data)&usb_hdk(_regabi)?(_d)?.a&host_snd\\w*.o"                => "USBH_SEND_ROM",
    ".(text|rodata|data)&usbh.a|usb_hdk_\\w+.a&host_snd\\w*.o"                   => "USBH_SEND_ROM",
    ".(data|bss)&usb_hdk(_regabi)?(_d)?.a&host_snd\\w*.o"                        => "USBH_SEND_RAM",
    ".(data|bss)&usbh.a|usb_hdk_\\w+.a&host_snd\\w*.o"                           => "USBH_SEND_RAM",

    #HOST-RECEIVE
    ".(text|rodata|data)&usb_hdk(_regabi)?(_d)?.a&host_rcv\\w*.o"                => "USBH_RCV_ROM",
    ".(text|rodata|data)&usbh.a|usb_hdk_\\w+.a&host_rcv\\w*.o"                   => "USBH_RCV_ROM",
    ".(data|bss)&usb_hdk(_regabi)?(_d)?.a&host_rcv\\w*.o"                        => "USBH_RCV_RAM",
    ".(data|bss)&usbh.a|usb_hdk_\\w+.a&host_rcv\\w*.o"                           => "USBH_RCV_RAM",

    #HOST-DEV
    ".(text|rodata|data)&usb_hdk(_regabi)?(_d)?.a&host_dev_\\w*.o"               => "USBH_DEV_ROM",
    ".(text|rodata|data)&usbh.a|usb_hdk_\\w+.a&host_dev_\\w*.o"                  => "USBH_DEV_ROM",
    ".(data|bss)&usb_hdk(_regabi)?(_d)?.a&host_dev_\\w*.o"                       => "USBH_DEV_RAM",
    ".(data|bss)&usbh.a|usb_hdk_\\w+.a&host_dev_\\w*.o"                          => "USBH_DEV_RAM",

    #HOST-CANCEL
    ".(text|rodata|data)&usb_hdk(_regabi)?(_d)?.a&host_cnl\\w*.o"                => "USBH_CNL_ROM",
    ".(text|rodata|data)&usbh.a|usb_hdk_\\w+.a&host_cnl\\w*.o"                   => "USBH_CNL_ROM",
    ".(data|bss)&usb_hdk(_regabi)?(_d)?.a&host_cnl\\w*.o"                        => "USBH_CNL_RAM",
    ".(data|bss)&usbh.a|usb_hdk_\\w+.a&host_cnl\\w*.o"                           => "USBH_CNL_RAM",

    #HOST-CLOSE
    ".(text|rodata|data)&usb_hdk(_regabi)?(_d)?.a&host_close\\w*.o"              => "USBH_CLOSE_ROM",
    ".(text|rodata|data)&usbh.a|usb_hdk_\\w+.a&host_close\\w*.o"                 => "USBH_CLOSE_ROM",
    ".(data|bss)&usb_hdk(_regabi)?(_d)?.a&host_close\\w*.o"                      => "USBH_CLOSE_RAM",
    ".(data|bss)&usbh.a|usb_hdk_\\w+.a&host_close\\w*.o"                         => "USBH_CLOSE_RAM",

    #HOST-SHUT
    ".(text|rodata|data)&usb_hdk(_regabi)?(_d)?.a&host_shut\\w*.o" => "USBH_SHUT_ROM",
    ".(text|rodata|data)&usbh.a|usb_hdk_\\w+.a&host_shut\\w*.o"           => "USBH_SHUT_ROM",
    ".(data|bss)&usb_hdk(_regabi)?(_d)?.a&host_shut\\w*.o" => "USBH_SHUT_RAM",
    ".(data|bss)&usbh.a|usb_hdk_\\w+.a&host_shut\\w*.o"           => "USBH_SHUT_RAM",

    #USB-CH9
    ".(text|rodata|data)&usb_hdk(_regabi)?(_d)?.a&host_ch9\\w*.o" => "USBH_CH9_ROM",
    ".(text|rodata|data)&usbh.a|usb_hdk_\\w+.a&host_ch9\\w*.o"           => "USBH_CH9_ROM",
    ".(data|bss)&usb_hdk(_regabi)?(_d)?.a&host_ch9\\w*.o" => "USBH_CH9_RAM",
    ".(data|bss)&usbh.a|usb_hdk_\\w+.a&host_ch9\\w*.o"           => "USBH_CH9_RAM",

    #CDC-CLASS
    ".(text|rodata|data)&usb_hdk(_regabi)?(_d)?.a&(usb_host_cdc_in|usb_host_cdc)\\w*.?o?" => "USBH_CDC_ROM",
    ".(text|rodata|data)&usbh.a|usb_hdk_\\w+.a&(usb_host_cdc_in|usb_host_cdc)\\w*.?o?"           => "USBH_CDC_ROM",
    ".(data|bss)&usb_hdk(_regabi)?(_d)?.a&(usb_host_cdc_in|usb_host_cdc)\\w*.?o?" => "USBH_CDC_RAM",
    ".(data|bss)&usbh.a|usb_hdk_\\w+.a&(usb_host_cdc_in|usb_host_cdc)\\w*.?o?"           => "USBH_CDC_RAM",

    #HID-CLASS
    ".(text|rodata|data)&usb_hdk(_regabi)?(_d)?.a&usb_host_hid\\w*.?o?" => "USBH_HID_ROM",
    ".(text|rodata|data)&usbh.a|usb_hdk_\\w+.a&usb_host_hid\\w*.?o?"           => "USBH_HID_ROM",
    ".(data|bss)&usb_hdk(_regabi)?(_d)?.a&usb_host_hid\\w*.?o?" => "USBH_HID_RAM",
    ".(data|bss)&usbh.a|usb_hdk_\\w+.a&usb_host_hid\\w*.?o?"           => "USBH_HID_RAM",

    #HUB-CLASS
    ".(text|rodata|data)&usb_hdk(_regabi)?(_d)?.a&usb_host_hub\\w*.?o?" => "USBH_HUB_ROM",
    ".(text|rodata|data)&usbh.a|usb_hdk_\\w+.a&usb_host_hub\\w*.?o?"           => "USBH_HUB_ROM",
    ".(data|bss)&usb_hdk(_regabi)?(_d)?.a&usb_host_hub\\w*.?o?" => "USBH_HUB_RAM",
    ".(data|bss)&usbh.a|usb_hdk_\\w+.a&usb_host_hub\\w*.?o?"           => "USBH_HUB_RAM",

    #MSD-CLASS
    ".(text|rodata|data)&usb_hdk(_regabi)?(_d)?.a&(usb_host_msd_)\\w*.?o?" => "USBH_MSD_ROM",
    ".(text|rodata|data)&usbh.a|usb_hdk_\\w+.a&(usb_host_msd_)\\w*.?o?"           => "USBH_MSD_ROM",
    ".(data|bss)&usb_hdk(_regabi)?(_d)?.a&(usb_host_msd_)\\w*.?o?" => "USBH_MSD_RAM",
    ".(data|bss)&usbh.a|usb_hdk_\\w+.a&(usb_host_msd_)\\w*.?o?"           => "USBH_MSD_RAM",

    #PHDC-CLASS
    ".(text|rodata|data)&usb_hdk(_regabi)?(_d)?.a&usb_host_phdc\\w*.?o?" => "USBH_PHDC_ROM",
    ".(text|rodata|data)&usbh.a|usb_hdk_\\w+.a&usb_host_phdc\\w*.?o?"           => "USBH_PHDC_ROM",
    ".(data|bss)&usb_hdk(_regabi)?(_d)?.a&usb_host_phdc\\w*.?o?" => "USBH_PHDC_RAM",
    ".(data|bss)&usbh.a|usb_hdk_\\w+.a&usb_host_phdc\\w*.?o?"           => "USBH_PHDC_RAM",

    #PRINTER-CLASS
    ".(text|rodata|data)&usb_hdk(_regabi)?(_d)?.a&usb_host_printe\\w*.?o?" => "USBH_PRINTER_ROM",
    ".(text|rodata|data)&usbh.a|usb_hdk_\\w+.a&usb_host_printe\\w*.?o?"           => "USBH_PRINTER_ROM",
    ".(data|bss)&usb_hdk(_regabi)?(_d)?.a&usb_host_printe\\w*.?o?" => "USBH_PRINTER_RAM",
    ".(data|bss)&usbh.a|usb_hdk_\\w+.a&usb_host_printe\\w*.?o?"           => "USBH_PRINTER_RAM",
);

#
# USBH Sections list for report generation
#

@USBH_ROM_COMPONENTS =
(
    ":---\n### Detailed breakdown of USB Host Code (ROM) ###",
    "USBH_COMMON_ROM",
    "USBH_CH9_ROM",
    "USBH_SEND_ROM",
    "USBH_RCV_ROM",
    "USBH_DEV_ROM",
    "USBH_CNL_ROM",
    "USBH_CLOSE_ROM",
    "USBH_SHUT_ROM",

    ":### USB Host Class Code ###",
    "USBH_CDC_ROM",
    "USBH_HID_ROM",
    "USBH_HUB_ROM",
    "USBH_MSD_ROM",
    "USBH_PHDC_ROM",
    "USBH_PRINTER_ROM",
);

@USBH_ROM_COMPONENTS2 =
(
    "+USBH_ROM", ### other + subtotal
);

@USBH_RAM_COMPONENTS =
(
    ":---\n### Detailed breakdown of USB Host Global Data (RAM) ###",
    "USBH_COMMON_RAM",
    "USBH_CH9_RAM",
    "USBH_SEND_RAM",
    "USBH_RCV_RAM",
    "USBH_DEV_RAM",
    "USBH_CNL_RAM",
    "USBH_CLOSE_RAM",
    "USBH_SHUT_RAM",

    ":### USB Host Class Global Data ###",
    "USBH_CDC_RAM",
    "USBH_HID_RAM",
    "USBH_HUB_RAM",
    "USBH_MSD_RAM",
    "USBH_PHDC_RAM",
    "USBH_PRINTER_RAM",

    "+USBH_RAM", ### other + subtotal
);

#####################################
#
# USBD
#

%MAP_USBD =
(
    #USB-COMMON
    ".(text|rodata|data)&usb_ddk(_regabi)?(_d)?.a&dev_main\\w*.o" => "USBD_COMMON_ROM",
    ".(text|rodata|data)&usbd.a|usb_ddk_\\w+.a&dev_main\\w*.o"           => "USBD_COMMON_ROM",
    ".(data|bss)&usb_ddk(_regabi)?(_d)?.a&dev_main\\w*.o" => "USBD_COMMON_RAM",
    ".(data|bss)&usbd.a|usb_ddk_\\w+.a&dev_main\\w*.o"           => "USBD_COMMON_RAM",

    #USB-CANCEL
    ".(text|rodata|data)&usb_ddk(_regabi)?(_d)?.a&dev_cncl\\w*.o" => "USBD_CNL_ROM",
    ".(text|rodata|data)&usbd.a|usb_ddk_\\w+.a&dev_cncl\\w*.o"           => "USBD_CNL_ROM",
    ".(data|bss)&usb_ddk(_regabi)?(_d)?.a&dev_cncl\\w*.o" => "USBD_CNL_RAM",
    ".(data|bss)&usbd.a|usb_ddk_\\w+.a&dev_cncl\\w*.o"           => "USBD_CNL_RAM",

    #USB-DEINIT-ENDPOINT
    ".(text|rodata|data)&usb_ddk(_regabi)?(_d)?.a&dev_ep_\\w*.o" => "USBD_EP_ROM",
    ".(text|rodata|data)&usbd.a|usb_ddk_\\w+.a&dev_ep_\\w*.o"           => "USBD_EP_ROM",
    ".(data|bss)&usb_ddk(_regabi)?(_d)?.a&dev_ep_\\w*.o" => "USBD_EP_RAM",
    ".(data|bss)&usbd.a|usb_ddk_\\w+.a&dev_ep_\\w*.o"           => "USBD_EP_RAM",

    #USB-RECEIVE
    ".(text|rodata|data)&usb_ddk(_regabi)?(_d)?.a&dev_recv\\w*.o" => "USBD_RCV_ROM",
    ".(text|rodata|data)&usbd.a|usb_ddk_\\w+.a&dev_recv\\w*.o"           => "USBD_RCV_ROM",
    ".(data|bss)&usb_ddk(_regabi)?(_d)?.a&dev_recv\\w*.o" => "USBD_RCV_RAM",
    ".(data|bss)&usbd.a|usb_ddk_\\w+.a&dev_recv\\w*.o"           => "USBD_RCV_RAM",

    #USB-SEND
    ".(text|rodata|data)&usb_ddk(_regabi)?(_d)?.a&dev_send\\w*.o" => "USBD_SEND_ROM",
    ".(text|rodata|data)&usbd.a|usb_ddk_\\w+.a&dev_send\\w*.o"           => "USBD_SEND_ROM",
    ".(data|bss)&usb_ddk(_regabi)?(_d)?.a&dev_send\\w*.o" => "USBD_SEND_RAM",
    ".(data|bss)&usbd.a|usb_ddk_\\w+.a&dev_send\\w*.o"           => "USBD_SEND_RAM",

    #USB-UNSTALL-ENDPOINT
    ".(text|rodata|data)&usb_ddk(_regabi)?(_d)?.a&dev_utl\\w*.o" => "USBD_UNSTALL_ROM",
    ".(text|rodata|data)&usbd.a|usb_ddk_\\w+.a&dev_utl\\w*.o"           => "USBD_UNSTALL_ROM",
    ".(data|bss)&usb_ddk(_regabi)?(_d)?.a&dev_utl\\w*.o" => "USBD_UNSTALL_RAM",
    ".(data|bss)&usbd.a|usb_ddk_\\w+.a&dev_utl\\w*.o"           => "USBD_UNSTALL_RAM",

    #CDC-CLASS
    ".(text|rodata|data)&usb_ddk(_regabi)?(_d)?.a&(usb_cdc|usb_cdc_pstn)\\w*.o" => "USBD_CDC_ROM",
    ".(text|rodata|data)&usbd.a|usb_ddk_\\w+.a&(usb_cdc|usb_cdc_pstn)\\w*.o"           => "USBD_CDC_ROM",
    ".(data|bss)&usb_ddk(_regabi)?(_d)?.a&(usb_cdc|usb_cdc_pstn)\\w*.o" => "USBD_CDC_RAM",
    ".(data|bss)&usbd.a|usb_ddk_\\w+.a&(usb_cdc|usb_cdc_pstn)\\w*.o"           => "USBD_CDC_RAM",

    #HID-CLASS
    ".(text|rodata|data)&usb_ddk(_regabi)?(_d)?.a&usb_hid\\w*.o" => "USBD_HID_ROM",
    ".(text|rodata|data)&usbd.a|usb_ddk_\\w+.a&usb_hid\\w*.o"           => "USBD_HID_ROM",
    ".(data|bss)&usb_ddk(_regabi)?(_d)?.a&usb_hid\\w*.o" => "USBD_HID_RAM",
    ".(data|bss)&usbd.a|usb_ddk_\\w+.a&usb_hid\\w*.o"           => "USBD_HID_RAM",

    #PHDC-CLASS
    ".(text|rodata|data)&usb_ddk(_regabi)?(_d)?.a&usb_phdc\\w*.o" => "USBD_PHDC_ROM",
    ".(text|rodata|data)&usbd.a|usb_ddk_\\w+.a&usb_phdc\\w*.o"           => "USBD_PHDC_ROM",
    ".(data|bss)&usb_ddk(_regabi)?(_d)?.a&usb_phdc\\w*.o" => "USBD_PHDC_RAM",
    ".(data|bss)&usbd.a|usb_ddk_\\w+.a&usb_phdc\\w*.o"           => "USBD_PHDC_RAM",

    #MSD-CLASS
    ".(text|rodata|data)&usb_ddk(_regabi)?(_d)?.a&(usb_msc|usb_msc_scsi)\\w*.o" => "USBD_MSD_ROM",
    ".(text|rodata|data)&usbd.a|usb_ddk_\\w+.a&(usb_msc|usb_msc_scsi)\\w*.o"           => "USBD_MSD_ROM",
    ".(data|bss)&usb_ddk(_regabi)?(_d)?.a&(usb_msc|usb_msc_scsi)\\w*.o" => "USBD_MSD_RAM",
    ".(data|bss)&usbd.a|usb_ddk_\\w+.a&(usb_msc|usb_msc_scsi)\\w*.o"           => "USBD_MSD_RAM",
);


#
# USBD Sections list for report generation
#

@USBD_ROM_COMPONENTS =
(
    ":---\n### Detailed breakdown of USB Device Code (ROM) ###",
    "USBD_COMMON_ROM",
    "USBD_CNL_ROM",
    "USBD_EP_ROM",
    "USBD_RCV_ROM",
    "USBD_SEND_ROM",
    "USBD_UNSTALL_ROM",
    ":### USB Device Class Code ###",
    "USBD_CDC_ROM",
    "USBD_HID_ROM",
    "USBD_MSD_ROM",
    "USBD_PHDC_ROM",
);

@USBD_ROM_COMPONENTS =
(
    "+USBD_ROM", ### other + subtotal
);

@USBD_RAM_COMPONENTS =
(
    ":---\n### Detailed breakdown of USB Device Global Data (RAM) ###",
    "USBD_COMMON_RAM",
    "USBD_CNL_RAM",
    "USBD_EP_RAM",
    "USBD_RCV_RAM",
    "USBD_SEND_RAM",
    "USBD_UNSTALL_RAM",

    ":### USB Device Class Global Data ###",
    "USBD_CDC_RAM",
    "USBD_HID_RAM",
    "USBD_MSD_RAM",
    "USBD_PHDC_RAM",

    "+USBD_RAM", ### other + subtotal
);


###############################################################
#
# if any symbol occures in more than one of the following sections
# a warning is printed
#

@ALL_COMPONENTS =
(
    @PSP_ROM_COMPONENTS,
    @BSP_ROM_COMPONENTS,
    @MQX_KERNEL_OBJECTS,
    @MFS_ROM_COMPONENTS,
    @RTCS_ROM_COMPONENTS,
    @USBH_ROM_COMPONENTS,
    @USBD_ROM_COMPONENTS,
    @KSDK_ROM_COMPONENTS,
);


###############################################################
#
# String tables
#

%COMPONENT_NAMES =
(
    "CORE_ROM"     => "MQX Core Code",
    "CORE_RAM"     => "MQX Core Global Data",
    "STRING_ROM"   => "MQX String Code",
    "STRING_RAM"   => "MQX String Global Data",
    "SCHED_ROM"    => "MQX Scheduler Code",
    "SCHED_RAM"    => "MQX Scheduler Global Data",
    "INT_ROM"      => "Interrupt Management Code",
    "INT_RAM"      => "Interrupt Management Global Data",
    "LWMEM_ROM"    => "Lightweight Memory Manager Code",
    "LWMEM_RAM"    => "Lightweight Memory Manager Global Data",
    "LWSEM_ROM"    => "Lightweight Semaphore Code",
    "LWSEM_RAM"    => "Lightweight Semaphore Global Data",
    "MEM_ROM"      => "Memory Manager Code",
    "MEM_RAM"      => "Memory Manager Global Data",
    "QUEUE_ROM"    => "Queue Management Code",
    "QUEUE_RAM"    => "Queue Management Global Data",
    "TASK_ROM"     => "Task Management Code",
    "TASK_RAM"     => "Task Management Global Data",
    "TIME_ROM"     => "Time Management Code",
    "TIME_RAM"     => "Time Management Global Data",
    "TQ_ROM"       => "Task Queues Component Code",
    "TQ_RAM"       => "Task Queues Component Global Data",
    "EVENT_ROM"    => "Event Component Code",
    "EVENT_RAM"    => "Event Component Global Data",
    "IDLE_ROM"     => "Idle Task Code",
    "IDLE_RAM"     => "Idle Task Global Data",
    "IO_ROM"       => "I/O Subsystem Code",
    "IO_RAM"       => "I/O Subsystem Global Data",
    "KLOG_ROM"     => "Kernel Log Component Code",
    "KLOG_RAM"     => "Kernel Log Component Global Data",
    "LWEVENT_ROM"  => "Lightweight Event Component Code",
    "LWEVENT_RAM"  => "Lightweight Event Component Global Data",
    "LWLOG_ROM"    => "Lightweight Log Component Code",
    "LWLOG_RAM"    => "Lightweight Log Component Global Data",
    "LWMSG_ROM"    => "Lightweight Message Component Code",
    "LWMSG_RAM"    => "Lightweight Message Component Global Data",
    "LWTIMER_ROM"  => "Lightweight Timer Component Code",
    "LWTIMER_RAM"  => "Lightweight Timer Component Global Data",
    "LOG_ROM"      => "Log Component Code",
    "LOG_RAM"      => "Log Component Global Data",
    "MSG_ROM"      => "Message Component Code",
    "MSG_RAM"      => "Message Component Global Data",
    "MUTEX_ROM"    => "Mutex Component Code",
    "MUTEX_RAM"    => "Mutex Component Global Data",
    "SEM_ROM"      => "Semaphore Component Code",
    "SEM_RAM"      => "Semaphore Component Global Data",
    "NAME_ROM"     => "Name Component Code",
    "NAME_RAM"     => "Name Component Global Data",
    "PART_ROM"     => "Partition Component Code",
    "PART_RAM"     => "Partition Component Global Data",
    "MPU_ROM"      => "MPU Support Code",
    "MPU_RAM"      => "MPU Support Global Data",

    ##################################

    "BSP_VECT_ROM"    => "BSP Vector Table",
    "BSP_VECT_RAM"    => "BSP Vector Table Global Data",
    "BSP_INT_ROM"     => "BSP Interrupt Management Code",
    "BSP_INT_RAM"     => "BSP Interrupt Management Global Data",
    "BSP_IO_RAM"      => "BSP I/O Global Data",
    "BSP_BOOTSTRAP_ROM" => "BSP Bootstrap Loader Code",
    "ADC_ROM"         => "A/D Driver Code",
    "ADC_RAM"         => "A/D Driver Global Data",
    "APCFLASH_ROM"    => "APC Flash Driver Code",
    "APCFLASH_RAM"    => "APC Flash Driver Global Data",
    "FlexCAN_ROM"     => "FlexCan Driver Code",
    "FlexCAN_RAM"     => "FlexCan Driver Global Data",
    "msCAN_ROM"       => "msCan Driver Code",
    "msCAN_RAM"       => "msCan Driver Global Data",
    "Display_ROM"     => "Display Driver Code",
    "Display_RAM"     => "Display Driver Global Data",
    "DIU_ROM"         => "DIU Driver Code",
    "DIU_RAM"         => "DIU Driver Global Data",
    "ENET_ROM"        => "Ethernet Driver Code",
    "ENET_RAM"        => "Ethernet Driver Global Data",
    "ENET_PHY_ROM"    => "Ethernet Phy Driver  Code",
    "ENET_PHY_RAM"    => "Ethernet Phy Driver  Global Data",
    "ENET_FEC_ROM"    => "Ethernet FEC Driver Code",
    "ENET_FEC_RAM"    => "Ethernet FEC Driver Global Data",
    "FLASH_ROM"       => "FLASH Driver Code",
    "FLASH_RAM"       => "FLASH Driver Global Data",
    "NAND_ROM"        => "NAND Flash Driver Code",
    "NAND_RAM"        => "NAND Flash Driver Global Data",
    "GPIO_ROM"        => "GPIO Driver Code",
    "GPIO_RAM"        => "GPIO Driver Global Data",
    "I2C_ROM"         => "I2C Driver Code",
    "I2C_RAM"         => "I2C Driver Global Data",
    "PCCARD_ROM"      => "PC-Card Driver Code",
    "PCCARD_RAM"      => "PC-Card Driver Global Data",
    "QSPI_RAM"        => "QSPI Driver Global Data",
    "RTC_ROM"         => "Real Time Clock Driver Code",
    "RTC_RAM"         => "Real Time Clock Driver Global Data",
    "Serial_ROM"      => "Serial Port Driver Code",
    "Serial_RAM"      => "Serial Port Driver Global Data",
    "SPI_ROM"         => "SPI Driver Code",
    "SPI_RAM"         => "SPI Driver Global Data",
    "TFS_ROM"         => "Trivial File System Code",
    "TFS_RAM"         => "Trivial File System Global Data",
    "TIMER_ROM"       => "Timer Driver Code",
    "TIMER_RAM"       => "Timer Driver Global Data",
    "SDCARD_ROM"      => "SD Card Driver Code",
    "SDCARD_RAM"      => "SD Card Driver Global Data",
    "ESDHC_ROM"       => "eSDHC Driver Code",
    "ESDHC_RAM"       => "eSDHC Driver Global Data",
    "CM_ROM"          => "Clock Management Code",
    "CM_RAM"          => "Clock Management Global Data",
    "LPM_ROM"         => "Low Power Management Code",
    "LPM_RAM"         => "Low Power Management Global Data",
    "BSP_INIT_ROM"    => "Board Initialization Code",
    "BSP_INIT_RAM"    => "Board Initialization Global Data",

    ##################################

    "MFS_DIR_ROM"         =>"Directory Code",
    "MFS_DIR_RAM"         =>"Directory Global Data",
    "MFS_ATTRI_ROM"       =>"File Attribute Code",
    "MFS_ATTRI_RAM"       =>"File Attribute Global Data",
    "MFS_CLUS_ROM"        =>"Cluster Code",
    "MFS_CLUS_RAM"        =>"Cluster Global Data",
    "MFS_DEL_ROM"         =>"Delete Code",
    "MFS_DEL_RAM"         =>"Delete Global Data",
    "MFS_FAT_ROM"         =>"FAT Code",
    "MFS_FAT_RAM"         =>"FAT Global Data",
    "MFS_FORMA_ROM"       =>"Format Code",
    "MFS_FORMA_RAM"       =>"Format Global Data",
    "MFS_HANDLE_ROM"      =>"Handle Code",
    "MFS_HANDLE_RAM"      =>"Handle Global Data",
    "MFS_LFN_ROM"         =>"Long file name Code",
    "MFS_LFN_RAM"         =>"Long file name Global Data",
    "MFS_RENAME_ROM"      =>"Rename Code",
    "MFS_RENAME_RAM"      =>"Rename Global Data",
    "MFS_MISC_ROM"        =>"Misc Code",
    "MFS_MISC_RAM"        =>"Misc Global Data",
    "MFS_OPEN_ROM"        =>"Open Code",
    "MFS_OPEN_RAM"        =>"Open Global Data",
    "MFS_RW_ROM"          =>"Read/Write Code",
    "MFS_RW_RAM"          =>"Read/Write Global Data",
    "MFS_PARSE_ROM"       =>"Parse Code",
    "MFS_PARSE_RAM"       =>"Parse Global Data",
    "MFS_SEARCH_ROM"      =>"Search Code",
    "MFS_SEARCH_RAM"      =>"Search Global Data",
    "MFS_TIME_ROM"        =>"Time Code",
    "MFS_TIME_RAM"        =>"Time Global Data",
    "MFS_PMGR_ROM"        =>"Partition manager Code",
    "MFS_PMGR_RAM"        =>"Partition Global Data",

    ##################################

    "RTCS_RTCS4_ROM"      => "RTCS Core Code",
    "RTCS_RTCS4_RAM"      => "RTCS Core Global Data",
    "RTCS_RTCS6_ROM"      => "RTCS IPv6-specific Core Code",
    "RTCS_RTCS6_RAM"      => "RTCS IPv6-specific Core Global Data",
    "RTCS_HTTPSRV_ROM"    => "HTTPSRV Code",
    "RTCS_HTTPSRV_RAM"    => "HTTPSRV Global Data",
    "RTCS_FTP_ROM"        => "FTP Code",
    "RTCS_FTP_RAM"        => "FTP Global Data",
    "RTCS_TELD_ROM"       => "Telnet Code",
    "RTCS_TELD_RAM"       => "Telnet Global Data",
    "RTCS_ECHO_ROM"       => "ECHO Code",
    "RTCS_ECHO_RAM"       => "ECHO Global Data",
    #"RTCS_EDS_ROM"        => "RTCS EDS Code",
    #"RTCS_EDS_RAM"        => "RTCS EDS Global Data",
    "RTCS_TFTP_ROM"       => "TFTP Code",
    "RTCS_TFTP_RAM"       => "TFTP Global Data",
    "RTCS_SOCK_ROM"       => "Socket Code",
    "RTCS_SOCK_RAM"       => "Socket Global Data",
    "RTCS_DNS_ROM"        => "DNS Code",
    "RTCS_DNS_RAM"        => "DNS Global Data",
    "RTCS_IPC_ROM"        => "RTCS IPC Code",
    "RTCS_IPC_RAM"        => "RTCS IPC Global Data",
    "RTCS_ARP_ROM"        => "ARP Code",
    "RTCS_ARP_RAM"        => "ARP Global Data",
    "RTCS_IP_ROM"         => "IP Core Code",
    "RTCS_IP_RAM"         => "IP Core Global Data",
    "RTCS_IP6_ROM"        => "IPv6-specific Core Code",
    "RTCS_IP6_RAM"        => "IPv6-specific Core Global Data",
    "RTCS_MLD_ROM"        => "MLD-specific Core Code",
    "RTCS_MLD_RAM"        => "MLD-specific Core Global Data",
    "RTCS_PPP_ROM"        => "PPP Code",
    "RTCS_PPP_RAM"        => "PPP Global Data",
    "RTCS_MIB_ROM"        => "MIB Code",
    "RTCS_MIB_RAM"        => "MIB Global Data",
    "RTCS_SNMP_ROM"       => "SNMP Code",
    "RTCS_SNMP_RAM"       => "SNMP Global Data",
    "RTCS_DHCP_ROM"       => "DHCP/BootP Code",
    "RTCS_DHCP_RAM"       => "DHCP/BootP Global Data",
    "RTCS_ICMP_ROM"       => "ICMP Code",
    "RTCS_ICMP_RAM"       => "ICMP Global Data",
    "RTCS_ICMP6_ROM"      => "ICMPv6-specific Code",
    "RTCS_ICMP6_RAM"      => "ICMPv6-specific Global Data",
    "RTCS_IGMP_ROM"       => "IGMP Code",
    "RTCS_IGMP_RAM"       => "IGMP Global Data",
    "RTCS_TCP_ROM"        => "TCP Core Code",
    "RTCS_TCP_RAM"        => "TCP Core Global Data",
    "RTCS_UDP_ROM"        => "UDP Core Code",
    "RTCS_UDP_RAM"        => "UDP Core Global Data",
    "RTCS_IFSTAT_ROM"     => "IP Statistics Collection Code",
    "RTCS_IFSTAT_RAM"     => "IP Statistics Global Data",

    ##################################

    "USBH_COMMON_ROM"     => "USBH Core Code",
    "USBH_COMMON_RAM"     => "USBH Core Data",
    "USBH_SEND_ROM"       => "USBH Send Code",
    "USBH_SEND_RAM"       => "USBH Send Global Data",
    "USBH_RCV_ROM"        => "USBH Receive Code",
    "USBH_RCV_RAM"        => "USBH Receive Global Data",
    "USBH_DEV_ROM"        => "USBH Dev Code",
    "USBH_DEV_RAM"        => "USBH Dev Global Data",
    "USBH_CNL_ROM"        => "USBH Cancel Code",
    "USBH_CNL_RAM"        => "USBH Cancel Global Data",
    "USBH_CLOSE_ROM"      => "USBH Close Code",
    "USBH_CLOSE_RAM"      => "USBH Close Global Data",
    "USBH_SHUT_ROM"       => "USBH Shut Code",
    "USBH_SHUT_RAM"       => "USBH Shut Global Data",
    "USBH_CH9_ROM"        => "USBH Chapter9 Code",
    "USBH_CH9_RAM"        => "USBH Chapter9 Global Data",
    "USBH_CDC_ROM"        => "USBH CDC Class Code",
    "USBH_CDC_RAM"        => "USBH CDC Class Global Data",
    "USBH_HID_ROM"        => "USBH HID Class Code",
    "USBH_HID_RAM"        => "USBH HID Class Global Data",
    "USBH_HUB_ROM"        => "USBH HUB Class Code",
    "USBH_HUB_RAM"        => "USBH HUB Class Global Data",
    "USBH_MSD_ROM"        => "USBH MSD Class Code",
    "USBH_MSD_RAM"        => "USBH MSD Class Global Data",
    "USBH_PHDC_ROM"       => "USBH PHDC Class Code",
    "USBH_PHDC_RAM"       => "USBH PHDC Class Global Data",
    "USBH_PRINTER_ROM"    => "USBH PRINTER Class Code",
    "USBH_PRINTER_RAM"    => "USBH PRINTER Class Global Data",

    ##################################

    "USBD_COMMON_ROM"     => "USBD Core Code",
    "USBD_COMMON_RAM"     => "USBD Core Global Data",
    "USBD_CNL_ROM"        => "USBD Cancel Code",
    "USBD_CNL_RAM"        => "USBD Cancel Global Data",
    "USBD_EP_ROM"         => "USBD Endpoint Code",
    "USBD_EP_RAM"         => "USBD Endpoint Global Data",
    "USBD_RCV_ROM"        => "USBD Receive Code",
    "USBD_RCV_RAM"        => "USBD Receive Global Data",
    "USBD_SEND_ROM"       => "USBD Send Code",
    "USBD_SEND_RAM"       => "USBD Send Global Data",
    "USBD_UNSTALL_ROM"    => "USBD Unstall Code",
    "USBD_UNSTALL_RAM"    => "USBD Unstall Global Data",
    "USBD_CDC_ROM"        => "USBD CDC Class Code",
    "USBD_CDC_RAM"        => "USBD CDC Class Global Data",
    "USBD_HID_ROM"        => "USBD HID Class Code",
    "USBD_HID_RAM"        => "USBD HID Class Global Data",
    "USBD_MSD_ROM"        => "USBD MSD Class Code",
    "USBD_MSD_RAM"        => "USBD MSD Class Global Data",
    "USBD_PHDC_ROM"       => "USBD PHDC Class Code",
    "USBD_PHDC_RAM"       => "USBD PHDC Class Global Data",

    ##################################

    "MQX_ROM_OTHER"   => "Other PSP Code",
    "MQX_ROM"         => "Total of MQX PSP Code",
    "KSDK_ROM"        => "Total of KSDK Code",
    "MQX_STD_ROM"     => "Total of STDLIB Code",
    "MQX_RAM_OTHER"   => "Other PSP Global Data",
    "MQX_RAM"         => "Total of MQX PSP Global Data",

    "BSP_ROM_OTHER"   => "Other BSP Code",
    "BSP_ROM"         => "Total of BSP Code",
    "BSP_RAM_OTHER"   => "Other BSP Global Data",
    "BSP_RAM"         => "Total of BSP Global Data",

    "MFS_ROM_OTHER"   => "Other MFS Code",
    "MFS_ROM"         => "Total of MFS Code",
    "MFS_RAM_OTHER"   => "Other MFS Global Data",
    "MFS_RAM"         => "Total of MFS Global Data",

    "RTCS_ROM_OTHER"  => "Other RTCS Code",
    "RTCS_ROM"        => "Total of RTCS Code",
    "RTCS_RAM_OTHER"  => "Other RTCS Global Data",
    "RTCS_RAM"        => "Total of RTCS Global Data",

    "USBH_ROM_OTHER"  => "Other USB Host Code",
    "USBH_ROM"        => "Total of USB Host Code",
    "USBH_RAM_OTHER"  => "Other USB Host Global Data",
    "USBH_RAM"        => "Total of USB Host Global Data",

    "USBD_ROM_OTHER"  => "Other USB Device Code",
    "USBD_ROM"        => "Total of USB Device Data",
    "USBD_RAM_OTHER"  => "Other USB Device Global Data",
    "USBD_RAM"        => "Total of USB Device Global Data",

    "SHELL_ROM_OTHER" => "Other Shell Code",
    "SHELL_ROM"       => "Total of Shell Code",
    "SHELL_RAM_OTHER" => "Other Shell Global Data",
    "SHELL_RAM"       => "Total of Shell Global Data",

    "APP_ROM"         => "Application-specific Code",
    "APP_RAM"         => "Application-specific Global Data",

    "MSL_ROM"         => "System Library Code (MSL/EWL...)",
    "MSL_RAM"         => "System Library Global Data",

    ##################################

    ##################################

    "_TOTAL_ROM"      => "All ROM Code and Initialized Data sections",
    "_TOTAL_RAM"      => "All RAM Static/Global Data sections",
);

%OBJECT_NAMES = (
   "MQX_QUEUE_STRUCT"               => "Queue",
   "MQX_LWSEM_STRUCT"               => "Lightweight Semaphore",
   "MQX_QUEUE_ELEMENT_STRUCT"       => "Queue Element",
   "MQX_TASK_QUEUE_STRUCT"          => "Task Queue",
   "MQX_KERNEL_DATA_STRUCT"         => "Kernel Data",
   "MQX_TD_STRUCT"                  => "Task Descriptor",
   "MQX_READY_Q_STRUCT"             => "Ready Q",
   "MQX_NAME_STRUCT"                => "Name",
   "MQX_NAME_COMPONENT_STRUCT"      => "Name Component",
   "MQX_EVENT_COMPONENT_STRUCT"     => "Event Component",
   "MQX_EVENT_STRUCT"               => "Event",
   "MQX_EVENT_CONNECTION_STRUCT"    => "Event Connection",
   "MQX_FILE"                       => "File Handle",
   "MQX_IO_DEVICE_STRUCT"           => "I/O Device",
   "MQX_LOG_HEADER_STRUCT"          => "Log Header",
   "MQX_LOG_COMPONENT_STRUCT"       => "Log Component",
   "MQX_LWEVENT_STRUCT"             => "Lightweight Event",
   "MQX_LWLOG_ENTRY_STRUCT"         => "Lightweight Log Entry",
   "MQX_LWLOG_HEADER_STRUCT"        => "Lightweight log Header",
   "MQX_LWLOG_COMPONENT_STRUCT"     => "Lightweight Component",
   "MQX_LWMEM_POOL_STRUCT"          => "Lightweight Memory Pool",
   "MQX_LWMEM_BLOCK_STRUCT"         => "Lightweight Memory Block",
   "MQX_LWMSGQ_STRUCT"              => "Lightweight Message Q",
   "MQX_LWTIMER_STRUCT"             => "Lightweight Timer",
   "MQX_LWTIMER_PERIOD_STRUCT"      => "Lightweight Timer Period",
   "MQX_MESSAGE_HEADER_STRUCT"      => "Message Header",
   "MQX_MSGPOOL_BLOCK_STRUCT"       => "Message Pool Block",
   "MQX_MSGPOOL_STRUCT"             => "Message Pool",
   "MQX_INTERNAL_MESSAGE_STRUCT"    => "Message Pool Internal Block",
   "MQX_MSGQ_STRUCT"                => "Message Queue",
   "MQX_MSG_COMPONENT_STRUCT"       => "Message Component",
   "MQX_MUTEX_ATTR_STRUCT"          => "Mutex Attribute",
   "MQX_MUTEX_STRUCT"               => "Mutex",
   "MQX_MUTEX_COMPONENT_STRUCT"     => "Mutex Component",
   "MQX_PARTPOOL_BLOCK_STRUCT"      => "Partition Block",
   "MQX_PARTPOOL_STRUCT"            => "Partition Pool",
   "MQX_INTERNAL_PARTITION_BLOCK_STRUCT"       => "Partition Internal Block",
   "MQX_PARTITION_COMPONENT_STRUCT" => "Partition Component",
   "MQX_SEM_COMPONENT_STRUCT"       => "Semaphore Component",
   "MQX_SEM_STRUCT"                 => "Semaphore",
   "MQX_SEM_CONNECTION_STRUCT"      => "Semaphore Connection",
   "MQX_TIMER_ENTRY_STRUCT"         => "Timer Entry",
   "MQX_TIMER_COMPONENT_STRUCT"     => "Timer Component",
   "MQX_WATCHDOG_ALARM_TABLE_STRUCT"=> "Watchdog Alarm",
   "MQX_WATCHDOG_COMPONENT_STRUCT"  => "Watchdog Component",
);



########################################################################
#
# Parse all files and prepare report
#

if($DUMP_ROM)
{
    push @THE_REPORT, @PSP_ROM_COMPONENTS   if $DUMP_PSP_COMPONENTS;
    push @THE_REPORT, @PSP_ROM_COMPONENTS2  if $DUMP_PSP_COMPONENTS;
    push @THE_REPORT, @BSP_ROM_COMPONENTS   if $DUMP_BSP_COMPONENTS;
    push @THE_REPORT, @BSP_ROM_COMPONENTS2  if $DUMP_BSP_COMPONENTS;
    push @THE_REPORT, @MFS_ROM_COMPONENTS   if $DUMP_MFS_COMPONENTS;
    push @THE_REPORT, @MFS_ROM_COMPONENTS2  if $DUMP_MFS_COMPONENTS;
    push @THE_REPORT, @RTCS_ROM_COMPONENTS  if $DUMP_RTCS_COMPONENTS;
    push @THE_REPORT, @RTCS_ROM_COMPONENTS2 if $DUMP_RTCS_COMPONENTS;
    push @THE_REPORT, @KSDK_ROM_COMPONENTS  if $DUMP_KSDK_COMPONENTS;
    push @THE_REPORT, @USBH_ROM_COMPONENTS  if $DUMP_USBH_COMPONENTS;
    push @THE_REPORT, @USBH_ROM_COMPONENTS2 if $DUMP_USBH_COMPONENTS;
    push @THE_REPORT, @USBD_ROM_COMPONENTS  if $DUMP_USBD_COMPONENTS;
    push @THE_REPORT, @USBD_ROM_COMPONENTS2 if $DUMP_USBD_COMPONENTS;

    # keep "SUMM" section at the end
    push @THE_REPORT, @SUMM_ROM_COMPONENTS  if $DUMP_SUMM_COMPONENTS;
}

if($DUMP_RAM)
{
    push @THE_REPORT, @PSP_RAM_COMPONENTS   if $DUMP_PSP_COMPONENTS;
    push @THE_REPORT, @BSP_RAM_COMPONENTS   if $DUMP_BSP_COMPONENTS;
    push @THE_REPORT, @MFS_RAM_COMPONENTS   if $DUMP_MFS_COMPONENTS;
    push @THE_REPORT, @RTCS_RAM_COMPONENTS  if $DUMP_RTCS_COMPONENTS;
    push @THE_REPORT, @USBH_RAM_COMPONENTS  if $DUMP_USBH_COMPONENTS;
    push @THE_REPORT, @USBD_RAM_COMPONENTS  if $DUMP_USBD_COMPONENTS;

    # keep "SUMM" section at the end
    push @THE_REPORT, @SUMM_RAM_COMPONENTS  if $DUMP_SUMM_COMPONENTS;
}

# add parsing expressions to global MAP
%MAP_COMMON = (%MAP_COMMON, %MAP_BSP)  if $DUMP_BSP_COMPONENTS;
%MAP_COMMON = (%MAP_COMMON, %MAP_MFS)  if $DUMP_MFS_COMPONENTS;
%MAP_COMMON = (%MAP_COMMON, %MAP_RTCS) if $DUMP_RTCS_COMPONENTS;
%MAP_COMMON = (%MAP_COMMON, %MAP_USBH) if $DUMP_USBH_COMPONENTS;
%MAP_COMMON = (%MAP_COMMON, %MAP_USBD) if $DUMP_USBD_COMPONENTS;

# globals
@OUT_ROWS = ();  # list of row headings for output
%OUT_COLS = ();  # map of row heading to comma-separated list of output values

foreach $mapfile (@MAPFILES)
{
    # these two hashes will be filled by parse()
    %sect_size = ();  # sum of symbol sizes per section
    %sym_size = ();   # individual symbol sizes

    if(not parse_file ($mapfile, \%sect_size, \%sym_size))
    {
        printf STDERR ("Error parsing MAP file $mapfile!\n");
    }

    # add parsed data to OUT_ global variables
    add_to_output ($mapfile, \%sect_size, \%sym_size);
}

# save OUT_ variables to real files
print "Writing output file: $OUT_FILE\n";
save_html("$OUT_FILE") if @OUT_ROWS;

if($TEXT_DUMP)
{
    print "### Begin text dump:\n";
    foreach $r (@OUT_ROWS)
    {
        print "$r: $OUT_COLS{$r}\n";
    }
    print "### End text dump\n";
}

exit 0;

########################################################################
########################################################################

sub save_html
{
    my ($fname) = @_;
    my $t;

    open OUTFILE,">$fname" or mydie("Can not open output file $fname");

    $t .= "<HTML>\r\n";
    $t .= "<HEAD>\r\n";
    $t .= "   <META HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html; charset=iso-8859-1\">\r\n";
    $t .= "   <TITLE>MQX Code Size Report </TITLE>\r\n";
    $t .= "<style type=\"text/css\">\r\n";
    $t .= "body{\r\n";
    $t .= " padding: 0px;\r\n";
    $t .= " margin: 30px;\r\n";
    $t .= " background-color: #FFF;\r\n";
    $t .= " font-family: Arial,Helvetica Neue, Helvetica,  sans-serif;\r\n";
    $t .= " font-size: 8pt;\r\n";
    $t .= " font-weight: normal;\r\n";
    $t .= " color: #51626F;\r\n";
    $t .= "}\r\n";
    $t .= ".reportname {\r\n";
    $t .= " font-size: 20pt;\r\n";
    $t .= " font-weight: bold;\r\n";
    $t .= "}\r\n";
    $t .= "td {\r\n";
    $t .= " font-size: 9pt;\r\n";
    $t .= " vertical-align: bottom;\r\n";
    $t .= "}\r\n";
    $t .= ".legalese {\r\n";
    $t .= " font-size: 7pt;\r\n";
    $t .= "}\r\n";
    $t .= "</style>\r\n";
    $t .= "</HEAD>\r\n";
    $t .= "<BODY>\r\n";
    $t .= "<TABLE CELLSPACING=0 CELLPADDING=0 WIDTH=\"1000\">\r\n";
    $t .= "<TR><TD WIDTH=\"100%\" class=\"reportname\">\r\n";
    $t .= "<CENTER>MQX Code Size Report\r\n";
    $t .= "</CENTER></TD></TR></TABLE>\r\n";

    $t .= "<BR><BR><TABLE CELLSPACING=0 CELLPADDING=3>";

    foreach $row (@OUT_ROWS)
    {
        $r = $row;
        $v = $OUT_COLS{$r};
        $v =~ s/\,/\<\/TD\>\<TD\>/g;
        $r =~ s/###([^#]+)###/<B>$1<\/B>/;
        $r =~ s/\-\-\-/<HR>/;
        $t .= "<TR><TD>$r</TD><TD>$v</TD></TR>\n";
    }

    $t .= "</TD></TR></TABLE>\r\n";


    $t .= "<BR><TABLE CELLSPACING=0 CELLPADDING=0 WIDTH=\"1000\" ><hr><TR><TD class=\"legalese\">\r\n";
    $t .= "<BR>(c) 2008-2012 Freescale Semiconductor. All rights reserved.\r\n";
    $t .= "Confidential Information. No part of this document may be\r\n";
    $t .= "copied or reproduced in any form or by any means without prior written\r\n";
    $t .= "consent of Freescale Semiconductor. Freescale MQX is a trademark\r\n";
    $t .= "of Freescale Semiconductor. All other trademarks are property\r\n";
    $t .= "of their respective owners. Generated by codesize reporter $VERSION\r\n";
    $t .= "</TD></TR></TABLE></BODY></HTML>\r\n";

    print OUTFILE $t;
    close OUTFILE;
}

sub parse_file
{
    my ($path, $sect_size, $symbol_size) = @_;

    my ($format, %map) = get_map($MAPFILE_FMT{$path});

    my @sym_in_components;
    my $current_sect;
    my $current_obj;
    my %usage;
    my $iar_part;
    my %iar_modules;
    my $previous_line;

    @iar_areas = ();

    print "Parsing $path ($MAPFILE_FMT{$path})\n";
    open INFILE, '<', $path or mydie("Can not open input file $path");

    while($line = <INFILE>)
    {
        # e.g.:  1004741A 00000072 .text _io_tfs_read (m52259evb_d.a tfs.o)
        if($format eq "cwmcf" or $format eq "cwarm")
        {
            next if $line !~ /^\s*(\w+)\s+(\w+)\s+(\.?\w+)\s+([A-Za-z0-9_@]+)\s+\((.*)\)\s*$/;
            $addr = "0x" . $1;
            $symsz = hex($2);
            $sect = $3;
            $symbol = $4;
            @objfiles = split /\s+/, $5;

            # if there is no library (.a), consider this as a .c file (part of app)
            if("@objfiles" !~ /[.]a\b/)
            {
                push @objfiles,"_dummy_appl.c";
            }
        }
        elsif($format eq "cwmpc")
        {
            # section heading info:   0000204c 000a84 0001204c 0000218c  1 .text     digitalsign.o
            if ($line =~ /^\s*\w+\s+(\w+)\s+(\w+)\s+\w+\s+1\s+([A-Za-z0-9_.\$]+)\s+(.*?)\s*$/)
            {
                $current_sect = $3;
                $current_obj = $4;
                next;
            }
            # symbol info (follows heading):   0000204c 0001d4 0001204c 0000218c  4 Ram_disk_start     digitalsign.o
            elsif($current_sect and $line =~ /^\s*\w+\s+(\w+)\s+(\w+)\s+\w+\s+(2|4|8|16)\s+([A-Za-z0-9_@\$]+)\s+(.*?)\s*$/)
            {
                $symsz = hex($1);
                $addr = "0x" . $2;
                $symbol = $4;
                $sect = "";
                $obj = $5;
                #@objfiles = split /\s+/, $5;
                @objfiles = ();
                my $my_idx = index($obj, ' ');

                if($my_idx>0)
                {
                    $objfiles[0] = substr($obj, $my_idx + 1, length($obj) - $my_idx - 1);
                    $objfiles[1] = substr($obj, 0, $my_idx);
                }
                else
                {
                    $objfiles[0] = $obj;
                }

                if($obj eq $current_obj)
                {
                    $sect = $current_sect;
                    # second entry in objfiles may be the full path to .o file
                    if($objfiles[0] =~ /^[A-Za-z0-9_.: \\\/]*?([A-Za-z0-9_.]+\.o)(bj)?$/)
                    {
                        push @objfiles,"$1";
                    }
                    # if there is no library (.a), consider this as a .c file (part of app)
                    if("@objfiles" !~ /[.]a\b/)
                    {
                        push @objfiles,"_dummy_appl.c";
                    }
                    # extab is treated as .text
                    if("@objfiles" !~ /\bextab\b/)
                    {
                        push @objfiles,".text";
                    }
                }
                else
                {
                    $current_sect = "";
                    next;
                }
            }
            else
            {
                next;
            }
        }
        elsif($format eq "mdkarm")
        {
            # symbol info eg:
            # Base Addr    Size         Type   Attr      Idx    E Section Name        Object
            # 0x000092e8   0x0000003c   Code   RO         2695    i._time_delay       psp_twrk60n512_d.lib(ti_delay.o)
            # 0x0000a314   0x000000c0   Data   RO         2045  * .constdata          bsp_twrk60n512_d.lib(init_sci.o)
            # 0x1fff0050   0x00000004   Data   RW         2817    .data               bsp_twrk60n512_d.lib(adc_kadc.o)
            # 0x1fff01a4   0x00000024   Zero   RW         2906    .bss                bsp_twrk60n512_d.lib(adt_kpdb.o)

            $line =~ s/\.\ text/.text/; # section name with space would cause us real troubles
            next if $line !~ /^\s*(\w+)\s+0x(\w+)\s+(Code|Data|Zero)\s+(RO|RW)\s+(\d+)\s*\*?\s*(\S+)\s+([^(]+)(\((.+)\))?$/;
            $addr = $1;
            $symsz = hex($2);
            $tmptype = $3;
            $tmpaccs = $4;
            $sect = $6;
            $symbol = $sect; # just fake
            $tmplib = $7;
            $tmpobj = $9;
            chomp $tmplib;
            $tmplib =~ s/\.lib$/\.a/i;
            @objfiles = ($tmplib);
            push @objfiles,$tmpobj if $tmpobj;

            # emulate section names as we can process
            push @objfiles,".text"   if $tmptype eq "Code";
            push @objfiles,".rodata" if $tmptype eq "Data" and $tmpaccs eq "RO";

            # if there is no library (.a), consider this as a .c file (part of app)
            if("@objfiles" !~ /[.]a\b/)
            {
                push @objfiles,"_dummy_appl.c";
            }
        }
        elsif($format eq "iararm")
        {
            # different parts of MAP file
            if($line =~ /^[* \t]+PLACEMENT\s+SUMMARY/) {
                $iar_part = "P"; next;
            }
            elsif($line =~ /^[* \t]+MODULE\s+SUMMARY/) {
                $iar_part = "M"; next;
            }
            elsif($line =~ /^[* \t]+ENTRY\s+LIST/) {
                $iar_part = "E"; next;
            }

            #   PLACEMENT SUMMARY: gather section names for memory ranges
            #   .text              ro code  0x1fff0e54   0x72c  serl_int.o [3]
            if($iar_part eq "P" and $line =~ /^\s*([.A-Za-z_][.A-Za-z0-9_]*)\s+(ro)?\s+(\w+)\s+0x(\w+)\s+0x(\w+)\s+[.A-Za-z0-9_]+\s+\[(\d+)\]\s*$/)
            {
                $a = hex($4);
                $b = $a + hex($5) + 1;
                push @iar_areas, "$a;$b;$1";
                next;
            }
            #   MODULE SUMMARY: gather library names
            #   bsp_twrk60n512_d.a: [3]
            elsif($iar_part eq "M" and $line =~ /^\s*(.*?)\s*:\s*\[(\d+)\]\s*$/)
            {
                $iar_modules{$2} = $1;
                next;
            }
            #   ENTRY LIST: finally, we get some symbols. In three different formats:
            #    _bsp_serial_io_init     0x1fff3441   0xf8  Code  Gb  init_gpio.o [3]
            #    _call_main              0x1fff4e29         Code  Gb  cmain.o [6]
            #    _bsp_get_serial_base_address
            #                            0x1fff44d9   0x5c  Code  Gb  serl_pioneer2.o [3]
            elsif($iar_part eq "E")
            {
                if($line =~ /^\s*([A-Za-z_][.A-Za-z0-9_]*)?\s+(0x(\w+))\s+(0x(\w+))?\s+(Code|Data)\s+\w+\s+([.A-Za-z0-9_]+)\s+\[(\d+)\]\s*$/)
                {
                    $symszx = $4;
                    $symsz = $5 ? hex($5) : 0;
                    $addr = $6 eq "Code" ? sprintf("0x%x", hex($3) & 0xfffffffe) : $2;  # remove LSB from code labels
                    $symbol = $1 ? $1 : $pending_symbol;
                    $sect = iar_get_sect($addr, $symszx);
                    $objfile = $7;
                    @objfiles = ($objfile, $iar_modules{$8});

                    # if there is no library (.a), consider this as a .c file (part of app)
                    if($objfiles[1] !~ /[.]a$/)
                    {
                        push @objfiles,"_dummy_appl.c";
                    }

                }
                else
                {
                    $line =~ /^\s*([A-Za-z_][.A-Za-z0-9_]*)\s*$/;
                    $pending_symbol = $1;
                    next;
                }
            }
            # nothing interesting
            else
            {
                next;
            }
        }
        elsif($format eq "kds")
        {
            # KDS: .text          0x00000000        0x0 ..\..\..\..\..\..\..\..\..\..\lib\ksdk_mqx_lib\kds\K64F12\Release\ksdk_mqx_lib.a(fsl_uart_driver.o)
            # MDK: 0x000092e8   0x0000003c   Code               RO        2695            i._time_delay       psp_twrk60n512_d.lib(ti_delay.o)
            # ^\s*(\w+)\s+      0x(\w+)\s+  (Code|Data|Zero)\s+(RO|RW)\s+(\d+)\s *\*?\s*  (\S+)\s+           ([^(]+)(\((.+)\))?$
            if ($line =~ /\.(\w+\.\w+)\s/)
            {
                $previous_line = $line ;
                #print $previous_line;
                next;
            }
            if($previous_line)
            {
                $line = $previous_line . $line;
                $previous_line = "";
            }
            $line =~ s/\.\ text/.text/;
            #$line = $previous_line . $line;
            next if $line !~ /^\s*(\.text|\.rodata)(\S+)\s+(0x\w+)\s+0x(\w+)\s+([^(]+[\\|\/](\w+.(o|a)))(\((.+)\))?$/;
            $addr = $3;
            $symsz = hex($4);#size
            $tmptype = $1;
            $tmpaccs = 0;

            $sect = "i" . $2;
            $symbol = $sect; # just fake
            $tmplib = $6;
            $tmpobj = $9;
            chomp $tmplib;
            @objfiles = ($tmplib);
            push @objfiles,$tmpobj if $tmpobj;

            # emulate section names as we can process
            push @objfiles,".text"  if $tmptype eq ".text";
            push @objfiles,".rodata" if $tmptype eq ".rodata";

            # if there is no library (.a), consider this as a .c file (part of app)
            if("@objfiles" !~ /[.]a\b/)
            {
                push @objfiles,"_dummy_appl.c";
            }
            # nothing interesting
        }
        elsif($format eq "cmake")
        {
            # KDS: .text          0x00000000        0x0 ..\..\..\..\..\..\..\..\..\..\lib\ksdk_mqx_lib\kds\K64F12\Release\ksdk_mqx_lib.a(fsl_uart_driver.o)
            # MDK: 0x000092e8   0x0000003c   Code               RO        2695            i._time_delay       psp_twrk60n512_d.lib(ti_delay.o)
            # ^\s*(\w+)\s+      0x(\w+)\s+  (Code|Data|Zero)\s+(RO|RW)\s+(\d+)\s *\*?\s*  (\S+)\s+           ([^(]+)(\((.+)\))?$
            if ($line =~ /\.(\w+\.\w+)\s/)
            {
                $previous_line = $line ;
                #print $previous_line;
                next;
            }
            if($previous_line)
            {
                $line = $previous_line . $line;
                $previous_line = "";
            }
            $line =~ s/\.\ text/.text/;
            #$line = $previous_line . $line;
            next if $line !~ /^\s*(\.text|\.rodata)(\S+)\s+(0x\w+)\s+0x(\w+)\s+([^(]+\\(\w+.(o|a)))(\((.+)\))?$/;
            $addr = $3;
            $symsz = hex($4);#size
            $tmptype = $1;
            $tmpaccs = 0;

            $sect = "i" . $2;
            $symbol = $sect; # just fake
            $tmplib = $6;
            $tmpobj = $9;
            $tmpobj =~ s/\.c\.o/\.o/i;
            $tmpobj =~ s/\.c\.obj/\.o/i;
            chomp $tmplib;

            @objfiles = ($tmplib);
            push @objfiles,$tmpobj if $tmpobj;

            # emulate section names as we can process
            push @objfiles,".text"  if $tmptype eq ".text";
            push @objfiles,".rodata" if $tmptype eq ".rodata";

            # if there is no library (.a), consider this as a .c file (part of app)
            if("@objfiles" !~ /[.]a\b/)
            {
                push @objfiles,"_dummy_appl.c";
            }
            # nothing interesting
        }
        else
        {
            die "Unknown file format specified";
        }

        $symbol_size->{$symbol} = $symsz;

        # treat function name and section name as a mappable name too
        push @objfiles,$sect if $sect;
        push @objfiles,$symbol;

        # build list of all IDs to which to register the symbol to
        # hash is used to count all only once (see below)
        my %used = ();

        # directly mapped: archive, object file, section, symbol, ...
        my $mapped = 0;
        my $mapped_in_components = 0;

        foreach $o (@objfiles)
        {
            # KSDK lib will begin with lib_ so simply remove it
            $o =~ s/lib_//;
            # is used
            $used{$o} = 1;
        }
        # count in how many components this symbol is counted
        my @sym_in_components = ();

        # look for friendly names
        foreach $mrall (keys %map)
        {
            # all &-separated regular expressions
            @mrarr = split /\s*\&\s*/, $mrall;

            # this could be our frienldy name
            @friendlynames = split /\s*[,; ]\s*/,$map{$mrall};
            push @friendlynames, "_TOTAL";
            push @friendlynames, "_TOTAL_ROM" if $map{$mrall} =~ /_ROM/;
            push @friendlynames, "_TOTAL_RAM" if $map{$mrall} =~ /_RAM/;

            # .. if match survives true
            $match = 1;

            # test all regexps, each must be satisfied by at least one of @objfiles
            foreach $mr (@mrarr)
            {
                if(not eval_one_regexp($mr,@objfiles))
                {
                    # at least one regexp from the &-list not satisfied
                    $match = 0;
                    last;
                }
            }

            # filter is satisfied, map to all friendly names
            if($match)
            {
                $mapped = 1;

                foreach $f (@friendlynames)
                {
                    if(not $used{$f})
                    {
                        $used{$f} = 1;
                        if ("@ALL_COMPONENTS" =~ /\b$f\b/)
                        {
                          push @sym_in_components,$f;
                          $mapped_in_components = 1;
                        }
                    }
                }
            }
        }

        # symbol counted in more than one component?
        if(@sym_in_components > 1)
        {
            $WARNINGS_COUNT++;
            print "WARNING: $symbol is counted in more than one MQX component (in @sym_in_components)\n" if $WARNINGS_ENABLE;
        }

        # no friendly section mapping found for this symbol (and it is not a linker constant)
        if(not $mapped and $symsz)
        {
            $WARNINGS_COUNT++;
            print "WARNING: $symbol was not mapped to any section - @objfiles\n" if $WARNINGS_ENABLE;
        }

        # list all sections the symbol is mapped to
        if($DUMP_SYM_DETAILS and %used)
        {
            # no friendly section mapping found for this symbol (and it is not a linker constant)
            if(not $mapped_in_components and $symsz)
            {
                print "NOTE: $symbol was not mapped to any specific component, it is counted as \"Other\"\n" if $WARNINGS_ENABLE;
            }

            print "Symbol $symbol (addr=$addr; size=$symsz) is mapped to:\n";
        }

        foreach $o (keys %used)
        {
            # add size to total size
            $sect_size{$o} = 0 if not $sect_size{$o};
            $sect_size{$o} += $symsz;
            # add symbol to the list
            $usage{$o} .= "\t$symbol ($symsz)\n";
            if($DUMP_SYM_DETAILS and %used)
            {
                print "\t$o\n";
            }
        }
    }
    close(INFILE);

    if($DUMP_SECT_DETAILS)
    {
        foreach $o (keys %usage)
        {
            print "Symbols mapped to section $o\n";
            print $usage{$o};
        }
    }

    return 1;
}


sub add_to_output
{
    my ($path, $sect_size, $symbol_size) = @_;

    # add heading lines
    out_cell("### Name ###", $MAPFILE_NAME{$path});
    out_cell("### Kernel configutation ###", $MAPFILE_NAME2{$path});
    out_cell("### Application Profile ###", $MAPFILE_NAME3{$path});
    out_cell("### Compiler ###", $MAPFILE_FMT{$path});

    if($DUMP_MQX_KERNEL_OBJECTS)
    {
        foreach $object_ref (@MQX_KERNEL_OBJECTS)
        {
            $object = $object_ref;

            # just a separator
            if($object =~ /^\:((.|\n)*)/m)
            {
                out_row($1);
            }
            # non-zero section
            else
            {
                out_cell($OBJECT_NAMES{$object}, $symbol_size->{$object});
            }
        }
    }

    $comp_size_subtotal = 0;
    foreach $component_ref (@THE_REPORT)
    {
        $component = $component_ref;

        {
            # just a separator
            if($component =~ /^:((.|\n)*)/m)
            {
                $name = $1;
                out_row($name);

                # horizontal line separator line also clears the subtotal
                $comp_size_subtotal = 0 if $name =~ /\-\-\-/;
            }
            # other + subtotal
            elsif($component =~ /^\+((.|\n)*)/m)
            {
                $component = $1;

                # Other (reminder) size has special section codename XXX_OTHER
                $name = $COMPONENT_NAMES{"${component}_OTHER"} ;
                die "Missing component name for $component _OTHER" if not $name;
                $othsz = $sect_size{$component} ? ($sect_size{$component} - $comp_size_subtotal) : "";
                out_cell($name, $othsz);

                # and the subtotal
                $name = "### $COMPONENT_NAMES{$component} ###";
                die "Missing component name for $component" if not $name;
                out_cell($name, $sect_size{$component});
            }
            # non-zero section
            else
            {
                # report may require this printed as bold
                $bold = $component =~ /^###\s*(.*?)\s*###$/ ? 1 : 0;

                $component = $1 if $bold;
                $name = $COMPONENT_NAMES{$component};
                $name = "### $name ###" if $bold;
                die "Missing component name for $component" if not $name;
                out_cell($name, $sect_size{$component});
                $comp_size_subtotal += $sect_size{$component} if $sect_size{$component};
            }
        }
    }

    # close the column just prepared
    close_curr_col();
}

# find address range in @iar_areas

sub iar_get_sect
{
    my ($from, $size) = @_;
    my $a0, $a1, $s;

    #print (">> looking for area $from ... + $size\n");

    if($from =~ /0x(\w+)/) { $from = hex($1); }
    if($size =~ /0x(\w+)/) { $size = hex($1); }

    #print (">> looking for area $from ... + $size\n");
    foreach (@iar_areas)
    {
        ($a0,$a1,$s) = split /;/;

        #print (">> >> testing $a0 ... $a1 ($s)\n");

        if($from >= $a0 and ($from + $size) < $a1)
        {
            #print (">> >> found $s\n");
            return $s;
        }
    }

    #print (">> >> NOT found\n");
    return "[no_section]";
}


# this function adds new column to output

$OUT_COL_CNTS = 0;

sub close_curr_col
{
    foreach my $r (keys %CURR_COL)
    {
        $OUT_COLS{$r} .= "," if $OUT_COLS_CNT;
        $OUT_COLS{$r} .= $CURR_COL{$r};
    }
    %CURR_COL = ();
    $OUT_COLS_CNT++;
}

# this function should fill the @OUT_ROWS and %OUT_COLS lists

sub out_cell
{
    my ($row, $val, $dash) = @_;
    out_row($row);
    $val = "-" if $val eq "";
    $CURR_COL{$row} = $val;
}

# add new row

sub out_row
{
    my ($row) = @_;
    mydie("internal error (empty row)") if not $row;

    # add only unique rows (BTW: as we use just one add_to_output function
    # the list of rows is allways the same for each column)
    foreach my $r (@OUT_ROWS)
    {
        return 0 if $r eq $row;
    }

    push @OUT_ROWS, $row;
    return 1;
}


sub get_map
{
    my ($fmt) = @_;

    return ("cwmpc", %MAP_COMMON, %MAP_CWMPC)  if $fmt =~ /^cwm?pc/i;
    return ("cwmcf", %MAP_COMMON, %MAP_CWMCF)  if $fmt =~ /^cwm?cf/i;
    return ("cwarm",  %MAP_COMMON, %MAP_CWARM)  if $fmt =~ /^cwm?(k|arm)/i;
    return ("iararm", %MAP_COMMON, %MAP_IARARM) if $fmt =~ /^iararm/i;
    return ("iararm", %MAP_COMMON, %MAP_IARARM) if $fmt =~ /^iar/i;
    return ("kds", %MAP_COMMON) if $fmt =~ /^kds/i;
    return ("cmake", %MAP_COMMON) if $fmt =~ /^cmake/i;
    return ("mdkarm", %MAP_COMMON) if $fmt =~ /^mdk/i;
    return ("kds", %MAP_COMMON) if $fmt =~ /^atl/i;
    mydie("Invalid format '$fmt' specified");
}

sub eval_one_regexp
{
    my ($regexp,@list) = @_;

    $regexp =~ s/\./[.]/g;

    foreach my $i (@list)
    {
        return 1 if $i =~ /^$regexp$/;
    }
    return 0;
}

sub print_usage
{
    my $readme =
        "\nCopyright (C) 2008-2012 Freescale Semiconductor\n\n".
        "\nFreescale Semiconductor MQX(TM) MAP-file analyzer/CodeSize script $VERSION\n".
        "This script analyzes the MAP files created by build tools and generates\n".
        "codesize report in HTML format.\n\n".
        "Supported tools:\n".
        "    CodeWarrior for MCU/ColdFire 6.3 (use -c cwcf6)\n".
        "    CodeWarrior for ColdFire 7.2 (use -c cwcf7)\n".
        "    CodeWarrior for mobileGT 9.2 (use -c cwmpc9)\n".
        "    CodeWarrior version 10 for ColdFire platforms (use -c cwcf10)\n".
        "    CodeWarrior version 10 for Kinetis platforms  (use -c cwarm10)\n".
        "    IAR Embedded Workbench for ARM v6.10 or later (use -c iararm6)\n".
        "    Kinetis Design Studio (use -c kds)\n".
        "    ARM-MDK Keil uVision v4.23 or later (use -c mdk)\n".
        "\n".
        "Options:\n".
        "    -M ... print detailed MAP file analysis report\n".
        "    -t ... dump text output to console\n".
        "    -W ... enable warning messages\n".
        "    -o <FILE>  ... specify report output file name\n".
        "    -n <NAME>  ... alternative MAP file name displayed in the report\n".
        "    -c <FORMAT> .. MAP file format specifier (use before the MAP file name)\n".
        "       supported formats: cwcf7, cwmcu6, cwmpc9, cwcf10, cwarm10, iararm6, mdk\n".
        "\nReport Options:\n".
        "    +PSP  or -PSP  .. force or suppress PSP details (default +)\n".
        "    +BSP  or -BSP  .. force or suppress BSP details (default +)\n".
        "    +MFS  or -MFS  .. force or suppress MFS File System details (default -)\n".
        "    +RTCS or -RTCS .. force or suppress RTCS TCP/IP stack details (default -)\n".
        "    +USBH or -USBH .. force or suppress USB Host stack details (default -)\n".
        "    +USBL or -USBL .. force or suppress USB Dev stack details  (default -)\n".
        "    +SUMM or -SUMM .. force or suppress summary report (default +)\n".
        "\n".
        "Usage examples:\n".
        "    codesize.exe -c cwcf7 <MAP_file>\n".
        "    codesize.exe -M -c cwcf10 <MAP_file>\n".
        "    codesize.exe +MFS -PSP -BSP -c cwcf10 <MAP_file>\n".
        "    codesize.exe -c cwcf10 <MAP_file1> -c cwmpc9 <MAP_file2> ....\n";
    print "$readme\n";
}

sub mydie
{
    my ($msg) = @_;
    print STDERR "$msg\n";
    exit(255);
}