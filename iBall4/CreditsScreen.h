//
//  CreditsScreen.h
//  iBall
//
//  Created by Ron Coleman on 12/22/12.
//  Copyright Ron Coleman 2012-2014. All rights reserved.
//

#import "cocos2d.h"

/** Credits screen */
@interface CreditsScreen : CCLayer

/** Gets a scene to contain this layer */
+(CCScene *) scene;

/** Constructor for the main screen */
- (id) init;

/** Handles pressing the back button */
- (void) onBack: (CCMenuItemFont*) button;
@end
