/*
 * main.c
 * BuGS
 *
 * Created by Jeremy Rand on 2020-06-10.
 * Copyright (c) 2020 Jeremy Rand. All rights reserved.
 *
 */



#include <Memory.h>
#include <Locator.h>
#include <MiscTool.h>

#include "main.h"
#include "game.h"s


/* Defines and macros */

#define TOOLFAIL(string) \
    if (toolerror()) SysFailMgr(toolerror(), "\p" string "\n\r    Error Code -> $");


/* Types */


/* Globals */

BOOLEAN shouldQuit;
unsigned int userid;


/* Implementation */


void initGlobals(void)
{
    shouldQuit = FALSE;
}


int main(void)
{
    int event;
    Ref toolStartupRef;
    
    userid = MMStartUp();
    TOOLFAIL("Unable to start memory manager");
    
    TLStartUp();
    TOOLFAIL("Unable to start tool locator");
    
    toolStartupRef = StartUpTools(userid, refIsResource, TOOL_STARTUP);
    TOOLFAIL("Unable to start tools");
    
    CompactMem();
    /* Allocate $1000 extra before the SHR screen so I can write sprites above the start of the
       screen without overwriting memory I do not own. */
    NewHandle(0x9000, userid, attrLocked | attrFixed | attrAddr | attrBank, (Pointer)0x011000);
    TOOLFAIL("Unable to allocate SHR screen");
    
    game();
    
    ShutDownTools(refIsHandle, toolStartupRef);
    TOOLFAIL("Unable to shutdown tools");
    
    TLShutDown();
    TOOLFAIL("Unable to shutdown tool locator");
    
    MMShutDown(userid);
    TOOLFAIL("Unable to shutdown memory manager");
}
