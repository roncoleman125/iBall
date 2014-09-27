//
//  Ball.m
//  iBall
//
//  Created by Ron Coleman on 12/11/12.
//  Copyright Ron Coleman 2012-2014. All rights reserved.
//

#import "Ball.h"
#import "Helper.h"
#import "cocos2d.h"

@implementation Ball

@synthesize input;

- (Ball*) initAtX:(int) x andY: (int) y of:(CCTMXTiledMap*) world_ {
    
    [super initWithFrames: @"ball12.png" width:32 height:32];
    
    if(self != nil) {
        vx = vy = 0;
        
        input = STOPPED;
        
        [self setPosition:ccp(x,y)];
        
        [self setWorld:world_];
    }
    
    return self;
}

- (void) update {	
	[self moveX];
	
	[self moveY];
	
	input = STOPPED;
}

- (void) moveX {
    // Get current (or old) x to see if we moved
	int oldX = self.x;
    
    // Get current x velocity in case we need to roll to a tile boundary
	double vxLast = vx;
	
    // Set x velocity based on input, if any
	if(self.input == LEFT)
		vx = -VELOCITY;

	else if(self.input == RIGHT)
		vx = VELOCITY;

	else
		vx = 0;
	
    // If we're not on a tile boundary, keep moving
	if(vx == 0 && (self.x % tileSize != 0))
		vx = vxLast;
	
	// Move relative to current position
	[self moveToX:vx andY: 0];
	
    CCTMXLayer* platforms = [world layerNamed:@"platforms"];
    
	if(vx != 0 && [self collidesWith:platforms])
		[self moveToX:-vx andY:0];
    
	if(oldX == self.x)
		return;
    
    if(oldX < self.x)
        [self nextFrame];
    else
        [self prevFrame];
}

- (void) moveY {	
	// Check if player "jumping"
	if(vy == 0 && self.input == UP)
		vy = VELOCITY_LAUNCH;
	
	// Check if ball falls from a platform
	else if(vy == 0 && ![self onPlatform])
		vy = -VELOCITY_DROP;
	
    // If not moving or no input to move, we're done here
    if(vy == 0)
        return;
    
	// If ball is in motion, update the velocity per gravity
	vy -= GRAVITY;
		
	if(vy <= -VELOCITY_TERMINAL)
		vy = -VELOCITY_TERMINAL;
		
	[self moveToX: 0 andY: vy];
		
	// If we collide with the platform layer, cancel motion
    if((vy <= 0 && [self onPlatform]) || (vy > 0 && [self hitsPlatform])) {
		[self moveToX: 0 andY: -vy];
			
		[self moveToContact];
			
		// If we collide going down, stop movement
		if(vy < 0) {
			vy = 0;
		}
			
		// If we collide going up, bounce off platform
		else {
			// "-" means reverse direction
			// "bounce factor" means platform absorbs some energy
			vy = -BOUNCE_FACTOR  * vy;
				
			// By chance velocity may be zero...which could be a problem
			if(vy == 0)
				vy = -VELOCITY_RESIDUAL;
		}
	}	
    
    return;
}

- (bool) onPlatform {
    // We're on a platform, if there's a tile immediately below
    CCTMXLayer* platforms = [world layerNamed:@"platforms"];
    
    CGRect frame = [self rect];
    
	int w = frame.size.width;
	
	int xoffs[] = { 0, w-1};
	int yoffs[] = {-1,  -1};
    
	for(int i=0; i < 2; i++) {
        int col = [Helper world: world toTileCol:self.x + xoffs[i]];
        int row = [Helper world: world toTileRow:self.y + yoffs[i]];
        
        if(![Helper validIn:world col:col row:row])
            continue;
        
        int gid = [platforms tileGIDAt:ccp(col,row)];
        
        if(gid != 0)
            return TRUE;
	}
	
	return FALSE;
}

-(bool) hitsPlatform {
    // We hit a platform if there's a tile immediately above
    CCTMXLayer* platforms = [world layerNamed:@"platforms"];

    CGRect frame = [self rect];
	int h = frame.size.height;
    int w = frame.size.width;
	
	int xoffs[] = {0  , w-1};
	int yoffs[] = {h+1, h+1}; 
    
	for(int i=0; i < 2; i++) {
        int col = [Helper world:world toTileCol:self.x + xoffs[i]];
        int row = [Helper world:world toTileRow:self.y + yoffs[i]];
        
        if(![Helper validIn:world col:col row:row])
            continue;
        
        int gid = [platforms tileGIDAt:ccp(col,row)];
        
        if(gid != 0)
            return TRUE;
	}
	
	return FALSE;	
}

- (void) moveToContact {
	// Default creeps down
	int creep = -1;
	
	// Unless we're going up, then creep up
	if(vy > 0)
		creep = 1;
	
    CCTMXLayer* platforms = [world layerNamed:@"platforms"];
	
	while([self collidesWith:platforms] == false)
		[self moveToX: 0 andY: creep];
	
    // Creep down (or up) once more to appear in contact with surface
	[self moveToX: 0 andY: -creep];
}

-(bool) collidesWith:(CCTMXLayer*)platforms {
    // We collide with the world if a tile is on any side
//	CGRect frame = [[self displayFrame] rect];
    CGRect frame = [self rect];
    
	int w = frame.size.width;
	int h = frame.size.height;
	
    // (Note w, h are +1 beyond the object boundary.)
	int xoffs[] = {0, 0, w, w};
	int yoffs[] = {0, h, h, 0};
    
    // Check around the four edges for collision with world
	for(int i=0; i < 4; i++) {        
        int col = [Helper world:world toTileCol:self.x + xoffs[i]];
        int row = [Helper world:world toTileRow:self.y + yoffs[i]];
        
        if(![Helper validIn:world col:col row:row])
            continue;        
        
        // If there is a tile at the edge, we collided
        int gid = [platforms tileGIDAt:ccp(col,row)];
        
        if(gid != 0)
            return TRUE;
	}
	
    // We found no tile at the edge so we must not be colliding
	return FALSE;
}
@end
