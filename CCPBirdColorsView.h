//
//  CCPBirdColorsView.h
//  Cockatiel Color Palette
//
//  Created by Kirsten Anderson on 10/23/15.
//  Copyright © 2015 Kirsten Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCPBirdObject.h"


@interface CCPBirdColorsView : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bodyColorImage;
@property (weak, nonatomic) IBOutlet UIImageView *piedColorImage;
@property (weak, nonatomic) IBOutlet UIImageView *pearlColorImage;
@property (weak, nonatomic) IBOutlet UIImageView *faceColorImage;
@property (weak, nonatomic) IBOutlet UIImageView *cheekColorImage;
@property (weak, nonatomic) IBOutlet UIImageView *eyeColorImage;
@property (weak, nonatomic) IBOutlet UIImageView *beakColorImage;
@property (weak, nonatomic) IBOutlet UIImageView *pearlTailColorImage;
@property (weak, nonatomic) IBOutlet UIImageView *tailColorImage;
@property (weak, nonatomic) IBOutlet UIImageView *outlineLeftImage;
@property (weak, nonatomic) IBOutlet UIImageView *outlineRightImage;
@property (weak, nonatomic) IBOutlet UIImageView *outlineMiddleImage;
@property (weak, nonatomic) IBOutlet UIImageView *disclosureAccessory;

- (void) displayImageColors:(CCPBirdObject *)bird;

@end
