//
//  Helper.h
//  iBall
//
//  Created by Ron Coleman on 2/1/13.
//  Copyright Ron Coleman 2012-2014. All rights reserved.
//

#import "cocos2d.h"

// Macros to handle retina-pixel conversions: 1x1 retina point is 2x2 pixels.
// See http://stackoverflow.com/questions/9286975/cocos2d-pixels-and-positioning
#define PIXELS_PER_POINT 2.
#define TOPOINT(pix) (pix / PIXELS_PER_POINT)
#define TOPIXEL(pt) (pt * PIXELS_PER_POINT)

/** Helper class with some convenience methods */
@interface Helper : NSObject

/** Converts world X coordinates to tile column */
+ (int) world: (CCTMXTiledMap*) world toTileCol:(int) x;

/** Converts world Y coordinate to tile row given a map */
+ (int) world: (CCTMXTiledMap*) world toTileRow:(int) y;

/** Returns true if the tile row, col is valid in the map */
+ (bool) validIn: (CCTMXTiledMap*) world col: (int) col row:(int) row;
@end
