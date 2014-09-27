//
//  Helper.m
//  iBall3
//
//  Created by Ron Coleman on 2/1/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "Helper.h"

@implementation Helper

+ (int) world: (CCTMXTiledMap*) world toTileCol:(int) x {
    int tileSize = [world tileSize].width;
    
    return x / tileSize;
}

+ (int) world: (CCTMXTiledMap*) world toTileRow:(int) y {
    int tileSize = [world tileSize].height;
    
    return [world mapSize].height - y / tileSize - 1;
}

+ (bool) validIn: (CCTMXTiledMap*) world col: (int) tilex row:(int) tiley {
    // Tile coordinates are valid if they are in the world
    CGSize mapSize = [world mapSize];
    
    bool outsideWorld = 
    tilex < 0 || 
    tiley < 0 || 
    tilex >= mapSize.width || 
    tiley >= mapSize.height;
    
    return !outsideWorld;
}
@end
