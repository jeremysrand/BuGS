/*
 *  settings.h
 *  BuGS
 *
 *  Created by Jeremy Rand on 2021-06-03.
 * Copyright © 2021 Jeremy Rand. All rights reserved.
 */

#ifndef _GUARD_PROJECTBuGS_FILEsettings_
#define _GUARD_PROJECTBuGS_FILEsettings_

#include <TYPES.h>


extern unsigned int myUserId;

extern void saveSettings(void);
BOOLEAN loadSettings(void);
extern void swapStereoSettings(void);


#endif /* define _GUARD_PROJECTBuGS_FILEsettings_ */
