//
//  HelloWorldLayer.m
//  iBall
//
//  Created by Ron Coleman on 12/9/12.
//  Copyright Ron Coleman 2012-2014. All rights reserved.
//


// Import the interfaces
#import "GameScreen.h"
#import "Ball.h"
#import "GameController.h"

CGSize tileSize_;
GameController* gameControlLayer;

// HelloWorldLayer implementation
@implementation GameScreen

+(CCScene *) scene
{
	// Get a scene
	CCScene* scene = [CCScene node];
	
	// Construct a game screen and add it to the scene
	GameScreen *layer = [GameScreen node];

	[scene addChild: layer];
    
    // Construct the game constroller and add it to the scene
    gameControlLayer = [GameController node];
    
    [scene addChild: gameControlLayer];
    
	return scene;
}

-(id) init
{
	// Apple recommends to re-assign "self" with the "super" return value
    self = [super init];
    
	if( self != 0 ) {
        world = [CCTMXTiledMap tiledMapWithTMXFile:@"iBall4-world.tmx"];
        
        [self addChild: world];
        
        ball = (Ball*) [[Ball alloc] initAtX:16 andY:16 of:world];
        
        [self addChild: ball];
        
        [self scheduleUpdate];
	}
    
	return self;
}

-(void) update:(ccTime)dt {
    // Get player input
    if([gameControlLayer quitPressed])
        [[CCDirector sharedDirector] popScene];
        
    ball.input = [gameControlLayer update];
    
//    if(ball.input != STOPPED)
//        NSLog(@"got input");
    
    // Update ball
    [ball update];
    
    // Scroll the world as needed
    [self scroll];
}

- (void) scroll {
    [self scrollX];
    
    [self scrollY];
}

- (void) scrollX {
    // Scrolling in X direction is relatively simple since ball stops on a tile boundary
    
    // Get ball's x which Entity ensures is a pixel (ie, world) coordinate
    float ballX = ball.x;
    
    // Seems with Retina display, the screen width is stored in points but we need pixels.
    int screenWidth = TOPIXEL([[CCDirector sharedDirector] winSize].width);
    
    // Get the half screen width to know when we need to scroll left or right
    float halfOfTheScreen = screenWidth / 2.0f;

    // Get the level height to know when we need to scroll up or down
    int levelWidth = world.mapSize.width * world.tileSize.width;
    
    // Scroll the background if we're not at the edge of the world
    if ((ballX >= halfOfTheScreen) && (ballX < (levelWidth - halfOfTheScreen))) {
        float newXPosition = (halfOfTheScreen - ballX);
        
        [self setPosition:ccp(newXPosition,TOPIXEL(self.position.y))];
    }
}

- (void) scrollY {   
    // Scrolling Y direction is more complicated since ball may be travelling
    // under continuous gravity rather than to/from tile boundaries.
    
    // Get the screen Y which is store by cocos2d as a point. For sprites
    // the Entity class handles this converversion. For layers, we must
    // deal with this manually for any position or size coming from the layer.
    int screenY = TOPIXEL(self.position.y);
    
    // Get the ball's y which again Entity converts to pixel (ie, world) coordinate for us
    int ballY = ball.y;
    
    // Get the screen height which is whatever the orientation is, ie, 3.5" portrait mode
    // is 640 that whereas in landscape mode is 960 or something like that.
    int screenHeight = TOPIXEL([[CCDirector sharedDirector] winSize].height);
    
    // Get the tile height which is pretty much a constant.
    int tileHeight = world.tileSize.height;
    
    // Get the half screen height to know when we need to scroll up or down
    float halfScreenHeight = screenHeight / 2.0f;
    
    // Get the level height to know when we need to scroll up or down
    int levelHeight = world.mapSize.width * world.tileSize.height;
    
    // Scroll the background if we're not at the edge of the world
    if ((ballY >= halfScreenHeight) && (ballY < (levelHeight - halfScreenHeight))) {
        float newYPosition = halfScreenHeight - ballY;

        [self setPosition:ccp(TOPIXEL(self.position.x),newYPosition)];
    }
    
    // Screen may not settle on tile boundary and we need to force it there.
    else if((screenY % tileHeight) != 0) {
        // Discrepancy is amount to move the screen
        int d = screenY % tileHeight;
        
        // Move the screen in the opposite direction of the discrepancy
        screenY += -d;
        
        [self setPosition: ccp(TOPIXEL(self.position.x),screenY)];
    }
}

- (void) setPosition:(CGPoint)position {
    [super setPosition:CGPointMake(TOPOINT(position.x), TOPOINT(position.y))];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
    
    [ball release];
}
@end
