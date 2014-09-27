//
//  MainScreen.h
//  iBall
//
//  Created by Ron Coleman on 12/21/12.
//  Copyright Ron Coleman 2012-2014. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"

/** Main screen layer which runs the main menu */
@interface MainScreen : CCLayer

/** Gets a scene to contain this layer */
+(CCScene *) scene;

/** Constructor for the main screen */
-(id) init;

/** Handles pressing the start button */
-(void) onStart: (CCMenuItemFont*) button;

/** Handles pressing the quit button */
-(void) onQuit: (CCMenuItemFont*) button;

/** Handles pressing the credits button */
-(void) onCredits: (CCMenuItemFont*) button;
@end
