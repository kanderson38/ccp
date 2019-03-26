//
//  CCPMutation.h
//  Cockatiel Color Palette
//
//  Created by Kirsten Anderson on 1/14/15.
//  Copyright (c) 2015 Kirsten Anderson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCPMutation : NSObject 

- (instancetype) initWithName:(NSString *)name withInheritance:(NSString *)inheritance andGender:(NSString *)gender;

- (NSMutableDictionary *)addToCorrectList:(NSMutableDictionary *)names;

-(void)resetMutationForButton:(int)buttonState andGender:(NSString *)gender;
-(void)resetParblueForButtons:(int)button1 and:(int)button2;
-(int)getButton; 

- (id) makeCopy;

@property (nonatomic, weak) NSString *name;
@property (nonatomic, weak) NSString *inheritance;
@property (nonatomic) int gene1;
@property (nonatomic) int gene2;
@property (nonatomic) BOOL visual;


@end
