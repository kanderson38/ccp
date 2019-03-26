//
//  CCPBirdObject.h
//  Cockatiel Color Palette
//
//  Created by Kirsten Anderson on 1/6/15.
//  Copyright (c) 2015 Kirsten Anderson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCPMutation.h"
static NSDictionary *mutationsList;

@interface CCPBirdObject : NSObject <NSMutableCopying>

- (NSString *)translateIntoWords;
- (instancetype)initWithGender:(NSString *)gender;
- (id) mutableCopyWithZone: (NSZone *) zone;
- (void)resetChickToFemale;

@property (nonatomic, strong) CCPMutation *pied;
@property (nonatomic, strong) CCPMutation *fallow;
@property (nonatomic, strong) CCPMutation *recSilver;
@property (nonatomic, strong) CCPMutation *olive;
@property (nonatomic, strong) CCPMutation *parblue;
@property (nonatomic, strong) CCPMutation *domSilver;
@property (nonatomic, strong) CCPMutation *domYellowcheek;
@property (nonatomic, strong) CCPMutation *SLYellowcheek;
@property (nonatomic, strong) CCPMutation *cinnamon;
@property (nonatomic, strong) CCPMutation *pearl;
@property (nonatomic, strong) CCPMutation *lutino;
@property (nonatomic, weak) NSString *gender;
@property (nonatomic) float frequencyIndex;

@end
