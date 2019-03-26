//
//  CCPResultsPageController.h
//  Cockatiel Color Palette
//
//  Created by Kirsten Anderson on 1/28/15.
//  Copyright (c) 2015 Kirsten Anderson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CCPBirdObject.h"
#import "CCPBirdColorsView.h"

@class CCPBirdObject;

@interface CCPResultsPageController : UITableViewController

@property NSArray *breedingResults;
@property CCPBirdObject *mother;
@property CCPBirdObject *father;

@end
