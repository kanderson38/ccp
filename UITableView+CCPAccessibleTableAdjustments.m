//
//  UITableView+CCPAccessibleTableAdjustments.m

//change table row heights when type size is changed

//  Cockatiel Color Palette
//
//  Created by Kirsten Anderson on 2/22/16.
//  Copyright © 2016 Kirsten Anderson. All rights reserved.
//

#import "UITableView+CCPAccessibleTableAdjustments.h"

@implementation UITableView (CCPAccessibleTableAdjustments)

- (void) adjustTableViewForAccessibility
{
    static NSDictionary *rowHeightSettingsDict;
    
    if (!rowHeightSettingsDict) {
        rowHeightSettingsDict = @{UIContentSizeCategoryExtraSmall : @45,
                                  UIContentSizeCategorySmall : @45,
                                  UIContentSizeCategoryMedium : @45,
                                  UIContentSizeCategoryLarge : @45,
                                  UIContentSizeCategoryExtraLarge : @55,
                                  UIContentSizeCategoryExtraExtraLarge : @85,
                                  UIContentSizeCategoryExtraExtraExtraLarge : @95,
                                  UIContentSizeCategoryAccessibilityLarge : @115,
                                  UIContentSizeCategoryAccessibilityMedium : @105,
                                  UIContentSizeCategoryAccessibilityExtraLarge : @125,
                                  UIContentSizeCategoryAccessibilityExtraExtraLarge : @135,
                                  UIContentSizeCategoryAccessibilityExtraExtraExtraLarge : @145
                                  };
    }
    
    NSString *currentSize = [[UIApplication sharedApplication] preferredContentSizeCategory];    

    NSNumber *rowHeight = rowHeightSettingsDict[currentSize];
    [self setRowHeight:rowHeight.floatValue];
    [self reloadData];
    
}

@end
