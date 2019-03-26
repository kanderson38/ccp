//
//  CCPMutation.m

// initWithName() assigns values to .gene1 and .gene2 to show whether the mutation is present on each gene
// getButton() uses .gene1 and .gene2 values to correctly display the segmented controls on MaleSelect and FemaleSelect pages
// resetMutationForButton() and resetParblueForButton() use the values of the segmented controls to correctly set the .gene1 and .gene2 values
// addToCorrectList() uses .gene1 and .gene2 values to determine whether the mutation is visual or split in a given bird when displaying the bird's type as a string

//  Cockatiel Color Palette
//
//  Created by Kirsten Anderson on 1/14/15.
//  Copyright (c) 2015 Kirsten Anderson. All rights reserved.
//

#import "CCPMutation.h"
#import "CCPBirdObject.h"

//for reference:
//pied
//fallow
//olive
//rec silver
//whiteface
//pastelface
//creamface
//dom silver
//dom yellowcheek
//pearl
//lutino
//cinnamon
//sex linked yellowcheek



@implementation CCPMutation

- (instancetype) initWithName:(NSString *)name withInheritance:(NSString *)inheritance andGender:(NSString *)gender
{
    self.name = name;
    self.gene1 = (int)0;  //'0' means the mutation is not present on the given gene
    self.gene2 = (int)0;
    self.inheritance = inheritance;
    self.visual = NO;
    
       if ([gender isEqualToString:@"female"]) {
        if ([inheritance isEqualToString:@"sexlinked"]) {
            self.gene2 = 2;
        }
       }
    
    return self;
}




//gets buttonState for all mutations except parblue
- (int)getButton
{
    int button = 0;
    if ([self.inheritance isEqualToString:@"recessive"] || [self.inheritance isEqualToString:@"dominant"]) {
        button = self.gene1 + self.gene2;
    } else if ([self.inheritance isEqualToString:@"sexlinked"]) {
        if (self.gene2 == 2) { //bird is female
            button = self.gene1;
        } else { //bird is male
            if (self.gene1 == 0) { //X1 is normal
                if (self.gene2 == 0) { //X2 is normal
                    button = 0;
                } else { //X2 carries mutation
                    button = 2; //bird is split (X2)
                }
            } else { //X1 carries mutation
                if (self.gene2 == 0) { //X2 is normal
                    button = 1; //bird is split (X1)
                } else { //if X2 also carries mutation
                    button = 3; //bird is visual
                }
            }
        }
    }
    return button;
}




//when the setMale or setFemale view is loaded, set the mutation button states correctly
//(parblue handled separately)
-(void)resetMutationForButton:(int)buttonState andGender:(NSString *)gender
{
    
    if ([self.inheritance isEqualToString:@"sexlinked"]) {
        if (buttonState == 0) {
            if ([gender isEqualToString:@"male"]) {
                self.gene1 = 0;
                self.gene2 = 0;
            } else if ([gender isEqualToString:@"female"]) {
                self.gene1 = 0;
                self.gene2 = 2;  //'2' represents the Y chromosome
            }
        } else if (buttonState == 1) {
            if ([gender isEqualToString:@"male"]) {
                //set X1 to mutation, X2 to none
                self.gene1 = 1;
                self.gene2 = 0;
            } else if([gender isEqualToString:@"female"]) {
                //female does carry mutation
                self.gene1 = 1;
                self.gene2 = 2;
            }
        } else if (buttonState == 2) {
            //set X1 to none, X2 to mutation
            self.gene1 = 0;
            self.gene2 = 1;
        } else if (buttonState == 3) {
            self.gene1 = 1;
            self.gene2 = 1;
        }
      } else {
        //recessive and dominant
        if (buttonState == 0) { //visual
            self.gene1 = 0;
            self.gene2 = 0;
        } else if (buttonState == 1) { //split or single-factor
            self.gene1 = 0;
            self.gene2 = 1;
        } else if (buttonState == 2) { //no mutation
            self.gene1 = 1;
            self.gene2 = 1;
        }
    }

}


//when the setMale or setFemale view is loaded, set the parblue button states correctly
-(void)resetParblueForButtons:(int)button1 and:(int)button2
{
    self.gene1 = button1;
    self.gene2 = button2;
}

- (NSMutableDictionary *)addToCorrectList:(NSMutableDictionary *)names
{
   // NSLog(@"running this for %@ %i %i", self.name, self.gene1, self.gene2);
    NSMutableArray *visuals = [names objectForKey:@"visuals"];
    NSMutableArray *splits = [names objectForKey:@"splits"];
    NSString *myName = self.name;
    NSArray *parblueNames = [[NSArray alloc] initWithObjects:@"none", NSLocalizedString(@"pastelface", @"pastelface name"), NSLocalizedString(@"creamface", @"creamface name"), NSLocalizedString(@"whiteface", @"whiteface name"), nil];
    
    int gene1 = (int)self.gene1;
    int gene2 = (int)self.gene2;
    
    //set "visual" to NO as a starting point
    self.visual = NO;
    //NSLog(@"%i gene1, %i gene2 for %@", self.gene1, self.gene2, self.name);
    if (!((gene1 == 0) && (gene2 == 0))) { //if bird is not normal grey
        if (gene1 == gene2) { //if bird is visual
            if ([self.inheritance isEqualToString:@"dominant"]) {
                myName = [myName stringByAppendingString:NSLocalizedString(@"double factor", @"double factor")];
            } else if ([self.inheritance isEqualToString:@"parblue"]) {
                myName = [parblueNames objectAtIndex:self.gene1];
            }
            self.visual = YES;
            [visuals addObject:myName];
        } else { //if bird is split
                if ([self.inheritance isEqualToString:@"dominant"]) {
                myName = [myName stringByAppendingString:NSLocalizedString(@"single factor", @"single factor")];
                [visuals addObject:myName];
            } else if ([self.inheritance isEqualToString:@"sexlinked"]) {
                if (gene2 == 2) { //bird is female
                    if (gene1 == 1) {
                        self.visual = YES;
                        [visuals addObject:myName];
                    }
                } else { //bird is male
                    if (gene2 == 0) {
                        myName = [myName stringByAppendingString:@"(X1)"];
                    } else if (gene1 == 0) {
                        myName = [myName stringByAppendingString:@"(X2)"];
                    }
                    self.visual = NO;
                    [splits addObject:myName];
                    
                }
            } else if ([self.inheritance isEqualToString:@"recessive"]){
                self.visual = NO;
                    [splits addObject:myName];
                
            } else if ([self.inheritance isEqualToString:@"parblue"]) {
                
                if (gene1 != 0) {
                    myName = [parblueNames objectAtIndex:self.gene1];
                    self.visual = NO;
                    [splits addObject:myName];
                }
                
                if (gene2 != 0) {
                    myName = [parblueNames objectAtIndex:self.gene2];
                    self.visual = NO;
                    [splits addObject:myName];
                }
                
                if ((gene1 != 0) && (gene2 != 0)) {
                    int phenotype = MIN(gene1, gene2);
                    NSString *phenotypeString = [NSString stringWithFormat:@" (phenotype: %@)", [parblueNames objectAtIndex:phenotype]];
                    self.visual = YES;
                    [splits addObject: phenotypeString];
                }
                
            }
        }
        
    }

return names;
}

//part of copying a bird object exactly (needed when making list of possible offpsring)

- (id) makeCopy
{
    NSString *name = self.name;
    NSString *inheritance = self.inheritance;
    
    CCPMutation *mutationCopy = [[CCPMutation alloc] initWithName:name withInheritance:inheritance andGender:@"male"];
    mutationCopy.gene1 = (int)self.gene1;
    mutationCopy.gene2 = (int)self.gene2;
    mutationCopy.visual = self.visual;
        
    return mutationCopy;
}

@end
