//
//  GameController.h
//  iBall
//
//  Created by Ron Coleman on 12/16/12.
//  Copyright Ron Coleman 2012-2014. All rights reserved.
//

#import "GameController.h"


@implementation GameController

- (GameController*) init {
    
    if( (self=[super init])) {
        [self initJoystickAndButtons];
        ready = TRUE;
    }
    
    return self;
}

- (bool) quitPressed {
    return quitButton.active;
}

- (enum direction) update {
    enum direction dir = STOPPED;
    
    // Get the continuous input scaled
    CGPoint velocity = ccpMult(leftJoystick.velocity, 128.0f); 
    
    // Transform continuous velocity input to tri-state output 
    int avx = abs(velocity.x);
    int avy = abs(velocity.y);

    if(avx > avy && ready) {
        if(velocity.x > 0)
            dir = RIGHT;
        else
            dir = LEFT;
    }
    else if(avx < avy && velocity.y > 0 && ready)
        dir = UP;
    
    // Since the joystick may take a couple of cycles to
    // reset, we need to wait until it goes back to zero
    // i.e., it is "ready", before reporting more output.
    bool gotInput = avx != 0 || avy != 0;
    
    if(ready && gotInput) {
        ready = FALSE;
    }
    
    else if(!ready && !gotInput) {
        ready = TRUE;
    }
    
    return dir;
}

-(void)initJoystickAndButtons {
    CGSize screenSize = [CCDirector sharedDirector].winSize;

    CGRect joystickBaseDimensions = CGRectMake(0, 0, 128.0f, 128.0f);
    CGRect quitButtonDimensions = CGRectMake(0, 0, 32.0f, 32.0f);

    CGPoint joystickBasePosition;
    CGPoint quitButtonPosition;

//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        // The device is an iPad running iPhone 3.2 or later.
//        CCLOG(@"Positioning Joystick and Buttons for iPad");
//        joystickBasePosition = ccp(screenSize.width*0.0625f,
//                                   screenSize.height*0.052f);
//        
//        quitButtonPosition = ccp(screenSize.width*0.946f,
//                                 screenSize.height*0.80f);
//        
//    }
//    else {
        // The device is an iPhone or iPod touch.       
        joystickBasePosition = ccp(screenSize.width*0.07f, screenSize.height*0.11f);
        
        quitButtonPosition = ccp(screenSize.width-32.0f, screenSize.height-32.0f);
//    }
    
    SneakyJoystickSkinnedBase *joystickBase =
        [[[SneakyJoystickSkinnedBase alloc] init] autorelease];
    
    joystickBase.position = joystickBasePosition;
    
    joystickBase.backgroundSprite = [CCSprite spriteWithFile:@"dpadDown2.png"];
    
    joystickBase.thumbSprite = [CCSprite spriteWithFile:@"joystickDown2.png"];
    
    joystickBase.joystick = [[SneakyJoystick alloc] initWithRect:joystickBaseDimensions];
    
    leftJoystick = [joystickBase.joystick retain];
    
    [self addChild:joystickBase];
    
    SneakyButtonSkinnedBase *quitButtonBase =
        [[[SneakyButtonSkinnedBase alloc] init] autorelease];
    
    quitButtonBase.position = quitButtonPosition;
    
    quitButtonBase.defaultSprite = 
        [CCSprite spriteWithFile:@"quit-button2.png"];
    
    quitButtonBase.activatedSprite = 
        [CCSprite spriteWithFile:@"quit-button2.png"];
    
    quitButtonBase.pressSprite = 
        [CCSprite spriteWithFile:@"quit-button2.png"];
    
    quitButtonBase.button = [[SneakyButton alloc]initWithRect:quitButtonDimensions];
    
    quitButton = [quitButtonBase.button retain];
    
    quitButton.isToggleable = NO;
    
    [self addChild:quitButtonBase]; 
}
@end
