//
//  CCPMaleSelectController.h
//  Cockatiel Color Palette
//
//  Created by Kirsten Anderson on 2/24/16.
//  Copyright © 2016 Kirsten Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCPFemaleSelectController.h"

@class CCPBirdObject;

@interface CCPMaleSelectController : CCPFemaleSelectController

@property (nonatomic, strong) CCPBirdObject *motherBird;
@property (nonatomic, strong) CCPBirdObject *fatherBird;

@end
