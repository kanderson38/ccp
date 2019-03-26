//
//  CCPBirdObject.m

// each bird object has a gender, a set of genes that carry particular mutations, and an index (calculated during breeding) to show the bird's type's frequency.

//  Cockatiel Color Palette
//
//  Created by Kirsten Anderson on 1/6/15.
//  Copyright (c) 2015 Kirsten Anderson. All rights reserved.
//

#import "CCPBirdObject.h"

#import "CCPMutation.h"

@interface CCPBirdObject ()

@property (nonatomic) NSMutableArray *visualList;
@property (nonatomic) NSMutableArray *splitsList;
@property (nonatomic) NSMutableDictionary *namesList;

@end

@implementation CCPBirdObject

- (instancetype)initWithGender:(NSString *)gender
{
    self = [super init];
    
    //init all mutations and add to bird
    
    self.pied = [[CCPMutation alloc] initWithName:NSLocalizedString(@"pied", @"pied name") withInheritance:@"recessive"  andGender:gender];
    self.fallow = [[CCPMutation alloc] initWithName:NSLocalizedString(@"fallow", @"fallow name") withInheritance:@"recessive" andGender:gender];
    self.recSilver = [[CCPMutation alloc] initWithName:NSLocalizedString(@"recessive silver", @"recessive silver name") withInheritance:@"recessive" andGender:gender];
    self.olive = [[CCPMutation alloc] initWithName:NSLocalizedString(@"olive", @"olive name") withInheritance:@"recessive" andGender:gender];
    self.parblue = [[CCPMutation alloc] initWithName:@"parblue" withInheritance:@"parblue" andGender:gender];
    self.domSilver = [[CCPMutation alloc] initWithName:NSLocalizedString(@"dominant silver", @"dominant silver name") withInheritance:@"dominant" andGender:gender];
    self.domYellowcheek = [[CCPMutation alloc] initWithName:NSLocalizedString(@"dominant yellowcheek", @"dominant yellowcheek name") withInheritance:@"dominant" andGender:gender];
    self.SLYellowcheek = [[CCPMutation alloc] initWithName:NSLocalizedString(@"sex-linked yellowcheek", @"sex-linked yellowcheek name") withInheritance:@"sexlinked" andGender:gender];
    self.cinnamon = [[CCPMutation alloc] initWithName:NSLocalizedString(@"cinnamon", @"cinnamon name") withInheritance:@"sexlinked" andGender:gender];
    self.pearl = [[CCPMutation alloc] initWithName:NSLocalizedString(@"pearl", @"pearl name") withInheritance:@"sexlinked" andGender:gender];
    self.lutino = [[CCPMutation alloc] initWithName:NSLocalizedString(@"lutino", @"lutino name") withInheritance:@"sexlinked" andGender:gender];
    self.gender = gender;
    self.frequencyIndex = 1;
    
    return self;
}


- (NSString *)translateIntoWords
{
        
   //get each mutation's value and determine whether it's split or visual
    //separate different inheritances into different methods
    
        NSString *fullDescription = @"";
    self.splitsList = [[NSMutableArray alloc] init];
    self.visualList = [[NSMutableArray alloc] init];
    self.namesList = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.visualList, @"visuals", self.splitsList, @"splits", nil];
    
    
    //for each mutation, addToCorrectList
    
    //pied
    self.namesList = [self.pied addToCorrectList:self.namesList];
    
    //fallow
    self.namesList = [self.fallow addToCorrectList:self.namesList];
    
    //olive
    self.namesList = [self.olive addToCorrectList:self.namesList];
    
    //rec silver
    self.namesList = [self.recSilver addToCorrectList:self.namesList];
    
    //dom silver
    self.namesList = [self.domSilver addToCorrectList:self.namesList];
    
    //dom yellowcheek
    self.namesList = [self.domYellowcheek addToCorrectList:self.namesList];
    
    //pearl
    self.namesList = [self.pearl addToCorrectList:self.namesList];
    
    //lutino
    self.namesList = [self.lutino addToCorrectList:self.namesList];
    
    //cinnamon
    self.namesList = [self.cinnamon addToCorrectList:self.namesList];
    
    //sex linked yellowcheek
    self.namesList = [self.SLYellowcheek addToCorrectList:self.namesList];
    
    //whiteface
    self.namesList = [self.parblue addToCorrectList:self.namesList];
    

    
    if (self.visualList.count == 0) { //if there are no visual mutations, the description should start with "normal grey"
        
        fullDescription = NSLocalizedString(@"normal grey", @"grey name");
        [self.visualList addObject:fullDescription];
    } else {
        
        for (int i = 0; i < self.visualList.count; i++) {
            NSString *current = [self.visualList objectAtIndex:i];
            
            //make sure there's no leading space before the first item in the description
            if (i == 0) {
                fullDescription = [fullDescription stringByAppendingString:current];
            } else {
                fullDescription = [fullDescription stringByAppendingFormat:@" %@", current];
            }
        }
        
    }
    
    if (!(self.splitsList.count == 0)) {
        
        NSString *splitText = NSLocalizedString(@"split to", @"split to");
        fullDescription = [fullDescription stringByAppendingString:splitText];
        
        for (int i = 0; i < self.splitsList.count; i++) {
            NSString *current = [self.splitsList objectAtIndex:i];
            fullDescription = [fullDescription stringByAppendingFormat:@" %@", current];
        }
    }
    
    //capitalize the first letter
    fullDescription = [fullDescription stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[fullDescription substringToIndex:1] capitalizedString]];
    return fullDescription;
}


//for duplicating birds in breeding results
-(id) mutableCopyWithZone: (NSZone *) zone
{
    
    CCPBirdObject *birdCopy = [[CCPBirdObject alloc] initWithGender:@"male"];
    [birdCopy setPied:[self.pied makeCopy]];
    [birdCopy setRecSilver:[self.recSilver makeCopy]];
    [birdCopy setFallow:[self.fallow makeCopy]];
    [birdCopy setOlive:[self.olive makeCopy]];
    [birdCopy setParblue:[self.parblue makeCopy]];
    [birdCopy setDomSilver:[self.domSilver makeCopy]];
    [birdCopy setDomYellowcheek:[self.domYellowcheek makeCopy]];
    [birdCopy setLutino:[self.lutino makeCopy]];
    [birdCopy setPearl:[self.pearl makeCopy]];
    [birdCopy setCinnamon:[self.cinnamon makeCopy]];
    [birdCopy setSLYellowcheek:[self.SLYellowcheek makeCopy]];
    birdCopy.gender = self.gender;
    birdCopy.frequencyIndex = self.frequencyIndex;
    
    return birdCopy;
}

-(id) copyWithZone: (NSZone *) zone
{
    
    CCPBirdObject *birdCopy = [[CCPBirdObject alloc] initWithGender:@"male"];
    [birdCopy setPied:[self.pied makeCopy]];
    [birdCopy setRecSilver:[self.recSilver makeCopy]];
    [birdCopy setFallow:[self.fallow makeCopy]];
    [birdCopy setOlive:[self.olive makeCopy]];
    [birdCopy setParblue:[self.parblue makeCopy]];
    [birdCopy setDomSilver:[self.domSilver makeCopy]];
    [birdCopy setDomYellowcheek:[self.domYellowcheek makeCopy]];
    [birdCopy setLutino:[self.lutino makeCopy]];
    [birdCopy setPearl:[self.pearl makeCopy]];
    [birdCopy setCinnamon:[self.cinnamon makeCopy]];
    [birdCopy setSLYellowcheek:[self.SLYellowcheek makeCopy]];
    birdCopy.gender = self.gender;
    birdCopy.frequencyIndex = self.frequencyIndex;
    
    return birdCopy;
}

- (void)resetChickToFemale
{
    self.cinnamon.gene2 = 2;
    self.lutino.gene2 = 2;
    self.pearl.gene2 = 2;
    self.SLYellowcheek.gene2 = 2;
    self.gender = @"female";
    
}

@end
