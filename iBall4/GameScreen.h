//
//  GameScreen.h
//  iBall
//
//  Created by Ron Coleman on 12/9/12.
//  Copyright Ron Coleman 2012-2014. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

#import "Ball.h"
#import "GameController.h"

/** GameScreen layer which runs the game world screen */
@interface GameScreen : CCLayer
{
    // Ball object the player manipulates
    Ball* ball;
    
    // The world in which the balls lives
    CCTMXTiledMap* world;
}

/** Gets a scene to contain this layer */
+(CCScene *) scene;

/** Updates the game with step time dt */
-(void) update:(ccTime)dt;

/** Convenience method which scrolls the world in X,Y directions */
- (void) scroll;

/** Scrolls the world in the X direction */
- (void) scrollX;

/** Scrolls the world in the Y direction */
- (void) scrollY;

/** Overrides CCLayer method so as to handle retina displays. */
- (void) setPosition:(CGPoint)position;
@end
