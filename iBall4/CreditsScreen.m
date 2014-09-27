//
//  CreditsScreen.m
//  iBall3
//
//  Created by Ron Coleman on 12/22/12.
//  Copyright Ron Coleman 2012-2014. All rights reserved.
//

#import "CreditsScreen.h"

@implementation CreditsScreen
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene* scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	CreditsScreen *layer = [CreditsScreen node];
	
	// add layer as a child to scene
	[scene addChild: layer];
    
	// return the scene
	return scene;
}

- (id) init {
    if( (self=[super init])) {
        int screenWidth = [[CCDirector sharedDirector] winSize].width;
        int screenHeight = [[CCDirector sharedDirector] winSize].height;
        
        // create and initialize a Label
        NSString* text = @"By R. Coleman (2010), music by Zirkle & Hogue (2009), ball from GameMaker";
        
        CCLabelTTF *label = (CCLabelTTF*)[CCLabelTTF labelWithString:text fontName:@"Marker Felt" fontSize:24 dimensions: CGSizeMake(400,100) hAlignment:UITextAlignmentLeft];
        
        [label setColor:ccc3(0, 255, 0)];
        
        // position the label on the center of the screen
        label.position =  ccp( screenWidth /2 , screenHeight/2 );
    		
        // add the label as a child to this Layer
        [self addChild: label];
    
        // Add the back button
        CCMenuItem *backButton =
            [CCMenuItemFont itemWithString:@"Back" target:self selector:@selector(onBack:)];
        
        CCMenu *menu = [CCMenu menuWithItems:backButton, nil];
        
        [menu alignItemsVertically];
        
        [menu setPosition:ccp(screenWidth / 2, screenHeight*0.25f)];
        
        [self addChild:menu];
    }
    
    return self;
}

-(void) onBack: (CCMenuItemFont*) button {
   [[CCDirector sharedDirector] popScene];
}
@end
