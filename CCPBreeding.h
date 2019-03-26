//
//  CCPBreeding.h
//  Cockatiel Color Palette
//
//  Created by Kirsten Anderson on 3/13/15.
//  Copyright (c) 2015 Kirsten Anderson. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CCPBirdObject;

@interface CCPBreeding : NSObject

+(NSArray *)breedMale:(CCPBirdObject *)male toFemale:(CCPBirdObject *)female;

@end
