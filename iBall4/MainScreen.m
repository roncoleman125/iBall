//
//  MainScreen.m
//  iBall
//
//  Created by Ron Coleman on 12/21/12.
//  Copyright Ron Coleman 2012-2014. All rights reserved.
//

#import "MainScreen.h"
#import "GameScreen.h"
#import "CreditsScreen.h"
#import "SimpleAudioEngine.h"

@implementation MainScreen

+(CCScene *) scene
{
	// Get a scene
	CCScene* scene = [CCScene node];
	
	// Construct a main screen and add it to the scene
	MainScreen *layer = [MainScreen node];
	
	[scene addChild: layer];
    
	return scene;
}

- (id) init {
    if( (self=[super init])) {
        // Get the screen dimensions
        int screenWidth = [[CCDirector sharedDirector] winSize].width;
        int screenHeight = [[CCDirector sharedDirector] winSize].height;
        
        // Add the logo
        CCSprite* logo = [[CCSprite node] initWithFile:@"iball-logo2.png"];
        
        [logo setPosition:ccp(screenWidth/2.0,screenHeight * 0.65f)];
        
        [self addChild:logo];
        
        // Add the buttons to the menu
        CCMenuItem *startButton =
            [CCMenuItemFont itemWithString:@"Start" target:self selector:@selector(onStart:)];

        CCMenuItem *quitButton =
            [CCMenuItemFont itemWithString:@"Quit" target:self selector:@selector(onQuit:)];
        
        CCMenuItem *creditsButton =
            [CCMenuItemFont itemWithString:@"Credits" target:self selector:@selector(onCredits:)];
        
        CCMenu *menu = [CCMenu menuWithItems:startButton, quitButton, creditsButton, nil];
        
        [menu alignItemsVertically];
        
        [menu setPosition:ccp(screenWidth / 2, screenHeight*0.25f)];

        // Add the menu to the layer
        [self addChild:menu];
        
        // Get the music started, yeh mon
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"island.mp3" loop:true];
    }
    
    return self;
}

- (void) onStart: (CCMenuItemFont*) button {
    [[CCDirector sharedDirector] pushScene:[CCTransitionRotoZoom transitionWithDuration:2.0 scene:[GameScreen scene]]];
}
     
- (void) onQuit: (CCMenuItemFont*) button {
    exit(0);
}

- (void) onCredits: (CCMenuItemFont*) button {
   [[CCDirector sharedDirector] pushScene:[CreditsScreen scene]];
}


@end
