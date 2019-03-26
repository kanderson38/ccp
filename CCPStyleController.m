//
//  CCPStyleController.m
//
// defines custom colors for various graphic elements
//
//
//  Cockatiel Color Palette
//
//  Created by Kirsten Anderson on 4/1/15.
//  Copyright (c) 2015 Kirsten Anderson. All rights reserved.
//

#import "CCPStyleController.h"
#import "CCPMainView.h"
#import "UIColor+CCPCustomColors.h"

@implementation CCPStyleController

+ (void)applyStyles
{
    
    UIColor *customLightYellowColor = [UIColor customLightYellowColor];
    UIColor *customDarkBrownColor = [UIColor customDarkBrownColor];
    UIColor *customDarkOrangeColor = [UIColor customDarkOrangeColor];
    UIColor *customLightOrangeColor = [UIColor customLightOrangeColor];
    
    
    
    
    [[UISegmentedControl appearance] setTintColor:[UIColor darkGrayColor]];
    
    [[UITextField appearance] setTextColor:[UIColor darkGrayColor]];
    
    [[UITextView appearance] setTextColor:[UIColor darkGrayColor]];
    [[UITextView appearance] setTintColor:customDarkOrangeColor];
    [[UITextView appearance] setBackgroundColor:customLightYellowColor];
    
    [[UITableViewCell appearance] setBackgroundColor:customLightYellowColor];
    
    [[UIScrollView appearance] setBackgroundColor:customLightYellowColor];
    
    [[UINavigationBar appearance] setBarTintColor:customLightOrangeColor];
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setTintColor:customDarkOrangeColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : customDarkBrownColor}];
    
    
    [[UITabBar appearance] setTintColor:customDarkBrownColor];
    [[UITabBar appearance] setBarTintColor:customLightOrangeColor];
    
    [[UIScrollView appearance] setBackgroundColor:customLightYellowColor];
    
    
    
}


@end
