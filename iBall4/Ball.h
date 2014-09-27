//
//  Ball.h
//  iBall
//
//  Created by Ron Coleman on 12/11/12.
//  Copyright Ron Coleman 2012-2014. All rights reserved.
//

#import "Entity.h"
#import "GameController.h"

#define VELOCITY 4
#define VELOCITY_TERMINAL (VELOCITY * 3)
#define VELOCITY_LAUNCH 14
#define VELOCITY_DROP 4
#define VELOCITY_RESIDUAL 0.5
#define BOUNCE_FACTOR 0.75
#define GRAVITY 0.7

/** This class implements the PC */
@interface Ball : Entity {
    enum direction input;
    double vx;
    double vy;
    int count;
}

@property(nonatomic) enum direction input;

/** Constructor which give the world (x,y) and the world the ball is in. */
- (Ball*) initAtX:(int) x andY: (int) y of:(CCTMXTiledMap*) world;

/** Updates the ball */
- (void) update;

/** Conditionally moves ball relative to current x. */
- (void) moveX;

/** Conditionally move ball relative to current y. */
- (void) moveY;

/** Returns true if ball collides with the plaform layer. */
- (bool) collidesWith:(CCTMXLayer*) platforms;

/** Returns true if ball is on a platform below it. */
- (bool) onPlatform;

/** Returns true if ball hits platform above */
- (bool) hitsPlatform;

/** Moves ball to contact point below or above */
- (void) moveToContact;
@end
