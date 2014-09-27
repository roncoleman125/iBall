//
//  Entity.h
//  iBall3
//
//  Created by Ron Coleman on 12/14/12.
//  Copyright               Ron Coleman 2012-2014. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Helper.h"


/** Parent class for all entity subclasses */
@interface Entity : CCSprite {
    CCTexture2D *texture;
    CCTMXTiledMap* world;
    int width;
    int height;
    int tileSize;
}

@property(nonatomic) int frameNumber;
@property(nonatomic,readonly) int frameCount;
@property(nonatomic) int x;
@property(nonatomic) int y;

/** Constructor */
- (Entity*) initWithFrames: (NSString*) fileName width: (int) width height:(int) height;

/** Updates the entity -- MUST OVERRIDE THIS METHOD !!! */
- (void) update;

/** Moves entity relative to current location. */
- (void) moveToX:(double)x andY:(double)y;

/** Sets x, y position in world */
- (void) setPosition:(CGPoint)position;

/** Gettor for x coordinate of entity position or use dot x */
- (int) x;

/** Settor for x coordinate of entity position or use dot x */
- (void) setX: (int) x;

/** Gettor for y coordinate of entity position or use dot y */
- (int) y;

/** Settor for y coordinate of entity position or use dot y */
- (void) setY: (int) y;

/** Settor for the entity frame or just use dot frameNumber */
- (void) setFrameNumber: (int) value;

/** Goes to next frame */
- (void) nextFrame;

/** Goes to previous frame */
- (void) prevFrame;

/** Sets the world for this entity */
- (void) setWorld: (CCTMXTiledMap*) world;

/** Gets the frame's rectangle */
- (CGRect) rect;
@end
