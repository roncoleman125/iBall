//
//  GameController.h
//  iBall3
//
//  Created by Ron Coleman on 12/16/12.
//  Copyright Ron Coleman 2012-2014. All rights reserved.
//
#import "CCLayer.h"
#import "SneakyJoystick.h"
#import "SneakyButton.h"
#import "SneakyButtonSkinnedBase.h"
#import "SneakyJoystickSkinnedBase.h"

/** Directions joystick can indicate */
enum direction {
    STOPPED = 0,
    LEFT = 1,
    RIGHT = 2,
    UP = 3
};

/** Layer that contains the game controls */
@interface GameController : CCLayer {
    SneakyJoystick *leftJoystick; 
    SneakyButton *quitButton;  
    bool ready;
}

/** Initializes the joystick and buttons */
- (void)initJoystickAndButtons;

/* Updates the joystick */
- (enum direction) update;

/* Handles pressing the quit button */
- (bool) quitPressed;
@end