//
//  CCPBirdColorsView.m

// dynamically shows a bird object's colors based on its mutation settings

//  Cockatiel Color Palette
//
//  Created by Kirsten Anderson on 10/23/15.
//  Copyright © 2015 Kirsten Anderson. All rights reserved.
//


#import "CCPBirdColorsView.h"
#import "UIImage+CCPImageTiling.h"

@interface CCPBirdColorsView ()


@end

@implementation CCPBirdColorsView

- (void)awakeFromNib {
    // Initialization code
   }

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



//set all the elements in the cell's bird image to match the given bird's mutations
-(void) displayImageColors:(CCPBirdObject *)bird
{
    UIColor *customPinkColor = [UIColor colorWithRed:240.0/255.0 green:203.0/255.0 blue:159.0/255.0 alpha:1.0];
    UIColor *cinnamonColor = [UIColor colorWithRed:209.0/255.0 green:195.0/255.0 blue:169.0/255.0 alpha:1.0];
    UIColor *fallowColor = [UIColor colorWithRed:234.0/255.0 green:222.0/255.0 blue:199.0/255.0 alpha:1.0];
    UIColor *mediumSilverColor = [UIColor colorWithRed:209.0/255.0 green:210.0/255.0 blue:209.0/255.0 alpha:1.0];
    UIColor *lightSilverColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:229.0/255.0 alpha:1.0];
    UIColor *cinnamonEyeColor = [UIColor colorWithRed:125.0/255.0 green:63.0/255.0 blue:34.0/255.0 alpha:1.0];
    UIColor *paleYellowColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:201.0/255.0 alpha:1.0];
    UIColor *paleOrangeColor = [UIColor colorWithRed:250.0/255.0 green:182.0/255.0 blue:150.0/255.0 alpha:1.0];
    UIColor *oliveColor = [UIColor colorWithRed:212.0/255.0 green:217.0/255.0 blue:189.0/255.0 alpha:1.0];
    UIColor *normalCheekColor = [UIColor colorWithRed:243.0/255.0 green:114.0/255.0 blue:33.0/255.0 alpha:1.0];
    
    self.pearlColorImage.image = [self.pearlColorImage.image imageResizingModeTile];
    
    self.outlineLeftImage.tintColor = [UIColor blackColor];
    self.outlineRightImage.tintColor = [UIColor blackColor];
    self.outlineMiddleImage.tintColor = [UIColor blackColor];
    self.bodyColorImage.tintColor = [UIColor grayColor];
    self.piedColorImage.tintColor = [UIColor yellowColor];
    self.pearlColorImage.tintColor = [UIColor yellowColor];
    self.faceColorImage.tintColor = [UIColor yellowColor];
    self.cheekColorImage.tintColor = normalCheekColor;
    self.eyeColorImage.tintColor = [UIColor brownColor];
    self.beakColorImage.tintColor = [UIColor darkGrayColor];
    self.pearlTailColorImage.tintColor = [UIColor yellowColor];
    self.tailColorImage.tintColor = [UIColor grayColor];

    //start with pied and pearl hidden
    self.piedColorImage.alpha = 0.0;
    self.pearlTailColorImage.alpha = 0.0;
    self.pearlColorImage.alpha = 0.0;
   
    
    if (bird.pearl.visual)
    {
        self.pearlColorImage.alpha = 1.0;
        self.pearlTailColorImage.alpha = 1.0;
    }
    
    if (bird.pied.visual) {
        self.piedColorImage.alpha = 1.0;
    }
    
    
    //set yellow level
    
    int maxGene = MAX(bird.parblue.gene1, bird.parblue.gene2);
    int minGene = MIN(bird.parblue.gene1, bird.parblue.gene2);
    
    
    
    if ((maxGene == 3) && (minGene == 3)) { //visual WF
        self.faceColorImage.tintColor = [UIColor whiteColor];
        self.cheekColorImage.tintColor = [UIColor whiteColor];
        self.piedColorImage.tintColor = [UIColor whiteColor];
        self.pearlColorImage.tintColor = [UIColor whiteColor];
        self.pearlTailColorImage.tintColor = [UIColor whiteColor];
    } else if ((minGene == 2) && (maxGene >= 2)) {
        //visual CF
        self.cheekColorImage.tintColor = paleYellowColor;
        self.faceColorImage.tintColor = [UIColor whiteColor];
        self.pearlColorImage.tintColor = [UIColor whiteColor];
        self.pearlTailColorImage.tintColor = [UIColor whiteColor];
        self.piedColorImage.tintColor = [UIColor whiteColor];
        
    } else if ((minGene == 1) && (maxGene >= 1)) {
        //visual PF
        self.cheekColorImage.tintColor = paleOrangeColor;
        self.faceColorImage.tintColor = paleYellowColor;
        self.pearlColorImage.tintColor = paleYellowColor;
        self.pearlTailColorImage.tintColor = paleYellowColor;
        self.piedColorImage.tintColor = paleYellowColor;
        
        
    } else if ((bird.domYellowcheek.gene1 == 1) || (bird.domYellowcheek.gene2 == 1)) {
        self.cheekColorImage.tintColor = [UIColor yellowColor];
        self.faceColorImage.tintColor = [UIColor whiteColor];
    } else if (bird.SLYellowcheek.visual) {
        self.cheekColorImage.tintColor = [UIColor yellowColor];
        self.faceColorImage.tintColor = [UIColor whiteColor];
    }
    
    //set grey level/tone
    
    if (bird.lutino.visual) {
        self.bodyColorImage.tintColor = [UIColor whiteColor];
        self.tailColorImage.tintColor = [UIColor whiteColor];
        self.beakColorImage.tintColor = customPinkColor;
        self.eyeColorImage.tintColor = [UIColor redColor];
        self.piedColorImage.tintColor = [UIColor whiteColor];
        
    } else if (bird.recSilver.visual) {
        self.bodyColorImage.tintColor = mediumSilverColor;
        self.tailColorImage.tintColor = mediumSilverColor;
        self.eyeColorImage.tintColor = [UIColor redColor];
        self.beakColorImage.tintColor = customPinkColor;
        
        
        
    } else if (bird.domSilver.gene2 != bird.domSilver.gene1) { //single factor
        self.bodyColorImage.tintColor = mediumSilverColor;
        self.tailColorImage.tintColor = mediumSilverColor;
        
    } else if ((bird.domSilver.gene1 == 1) && (bird.domSilver.gene2 == 1)) { //double factor
        self.bodyColorImage.tintColor = lightSilverColor;
        self.tailColorImage.tintColor = lightSilverColor;
        
    } else if (bird.fallow.visual) {
        self.beakColorImage.tintColor = customPinkColor;
        self.bodyColorImage.tintColor = fallowColor;
        self.tailColorImage.tintColor = fallowColor;
        self.eyeColorImage.tintColor = [UIColor redColor];
        
    } else if (bird.cinnamon.visual) {
        self.beakColorImage.tintColor = fallowColor;
        self.eyeColorImage.tintColor = cinnamonEyeColor;
        self.bodyColorImage.tintColor = cinnamonColor;
        self.tailColorImage.tintColor = cinnamonColor;
        
    } else if (bird.olive.visual) {
        self.bodyColorImage.tintColor = oliveColor;
        self.tailColorImage.tintColor = oliveColor;
        self.beakColorImage.tintColor = [UIColor darkGrayColor];
    }

    
    
    [self setNeedsDisplay];
    }

@end
