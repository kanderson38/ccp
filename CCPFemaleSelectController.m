//
//  CCPFemaleSelectController.m
//  Cockatiel Color Palette
//
//  Created by Kirsten Anderson on 2/24/16.
//  Copyright © 2016 Kirsten Anderson. All rights reserved.
//

#import "CCPFemaleSelectController.h"
#import "CCPBirdObject.h"
#import "CCPMutation.h"
#import "CCPGeneralInfoTableViewController.h"
#import "CCPInfoViewController.h"

@interface CCPFemaleSelectController ()

@property CCPBirdObject *currentBird;
@property (weak, nonatomic) IBOutlet UISegmentedControl *oliveButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *fallowButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sexlinkedHelpButton;

@property (weak, nonatomic) IBOutlet UISegmentedControl *piedButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *recSilverButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *cinnamonButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *pearlButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *SLYellowcheekButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *domSilverButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *lutinoButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *domYellowcheekButton;

@property (weak, nonatomic) IBOutlet UISegmentedControl *parblueGenotypeButton1;
@property (weak, nonatomic) IBOutlet UISegmentedControl *parblueGenotypeButton2;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;


@end
@implementation CCPFemaleSelectController


- (IBAction)resetToGrey: (id)sender
{
    NSString *gender = self.bird.gender;
    CCPBirdObject *newBird = [[CCPBirdObject alloc] initWithGender:gender];
    self.bird = newBird;
    [self setButtonStates];
    
}

#pragma mark - Navigation

//displays correct help topic when help button in section header is tapped
- (IBAction) loadHelpView: (id)sender
{
    UIButton *clicked = (UIButton *)sender;
    
    [self saveBirdState];
    
    if (clicked.tag == 1) {
        NSMutableString *topic = [NSMutableString stringWithString:@"parblueTopics"];
        CCPGeneralInfoTableViewController *vc = [[CCPGeneralInfoTableViewController alloc] initWithTopic:topic];
        
        [self.navigationController pushViewController:vc animated:YES];
    } else if (clicked.tag == 2) {
        NSString *topic = NSLocalizedString(@"What do X1 and X2 mean?", nil);
        CCPInfoViewController *ivc = [[CCPInfoViewController alloc] init];
        ivc.whichText = topic;
        
        [self.navigationController showViewController:ivc sender:nil];
    }
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [super prepareForSegue:segue sender:sender];
    
    [self saveBirdState];
}


- (void)saveBirdState
{
    //get mutations to reset based on button states
    
    
    NSString *gender = self.bird.gender;
    
    
    [self.bird.pied resetMutationForButton:(int)self.piedButton.selectedSegmentIndex andGender:gender];
    
    [self.bird.fallow resetMutationForButton:(int)self.fallowButton.selectedSegmentIndex andGender:gender];
    
    [self.bird.olive resetMutationForButton:(int)self.oliveButton.selectedSegmentIndex andGender:gender];
    
    [self.bird.recSilver resetMutationForButton:(int)self.recSilverButton.selectedSegmentIndex andGender:gender];
    
    //get parblue button selections and send to appropriate mutations
    
    int geno1 = (int)self.parblueGenotypeButton1.selectedSegmentIndex;
    int geno2 = (int)self.parblueGenotypeButton2.selectedSegmentIndex;
    [self.bird.parblue resetParblueForButtons:geno1 and:geno2];
    
    [self.bird.domSilver resetMutationForButton:(int)self.domSilverButton.selectedSegmentIndex andGender:gender];
    
    [self.bird.domYellowcheek resetMutationForButton:(int)self.domYellowcheekButton.selectedSegmentIndex andGender:gender];
    
    [self.bird.pearl resetMutationForButton:(int)self.pearlButton.selectedSegmentIndex andGender:gender];
    
    [self.bird.lutino resetMutationForButton:(int)self.lutinoButton.selectedSegmentIndex andGender:gender];
    
    [self.bird.cinnamon resetMutationForButton:(int)self.cinnamonButton.selectedSegmentIndex andGender:gender];
    
    [self.bird.SLYellowcheek resetMutationForButton:(int)self.SLYellowcheekButton.selectedSegmentIndex andGender:gender];
    
}

#pragma mark - Button dynamic changes

//when parblue geno1 button is changed, update geno2's enabled segments and change its selected segment to match geno1

-(IBAction)updateGeno1:(id)sender
{
    if ((int)self.parblueGenotypeButton1.selectedSegmentIndex > (int)self.parblueGenotypeButton2.selectedSegmentIndex) {
        int geno2 = (int)self.parblueGenotypeButton1.selectedSegmentIndex;
        [self.parblueGenotypeButton2 setSelectedSegmentIndex:geno2];
        
        
    }
    [self adjustGeno2Button];
}


- (void)adjustGeno2Button
{
    int geno1 = (int)self.parblueGenotypeButton1.selectedSegmentIndex;
    
    //initially enable all so it will update properly
    for (int i = 0; i < [self.parblueGenotypeButton2 numberOfSegments]; i++) {
        [self.parblueGenotypeButton2 setEnabled:YES forSegmentAtIndex:i];
    }
    
    for (int i = (geno1 - 1); (i >= 0); i--) {
        [self.parblueGenotypeButton2 setEnabled:NO forSegmentAtIndex:i];
    }
}


#pragma mark - View preparation

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
 
    [self setButtonStates];
  
}

- (void)setButtonStates
{
    //pied
    [self.piedButton setSelectedSegmentIndex:[self.bird.pied getButton]];
    
    //fallow
    [self.fallowButton setSelectedSegmentIndex:[self.bird.fallow getButton]];
    
    //rec silver
    [self.recSilverButton setSelectedSegmentIndex:[self.bird.recSilver getButton]];
    
    //olive
    [self.oliveButton setSelectedSegmentIndex:[self.bird.olive getButton]];
    
    //dom silver
    [self.domSilverButton setSelectedSegmentIndex:[self.bird.domSilver getButton]];
    
    //dom yc
    [self.domYellowcheekButton setSelectedSegmentIndex:[self.bird.domYellowcheek getButton]];
    
    //set parblue button states
    
    
    [self.parblueGenotypeButton1 setSelectedSegmentIndex:self.bird.parblue.gene1];
    [self.parblueGenotypeButton2 setSelectedSegmentIndex:self.bird.parblue.gene2];
    
    //genotypeButton2 will have some segments disabled depending on which (visual)
    //mutation is selected in geno1: all segments higher than geno1's selected segment
    [self adjustGeno2Button];
    
    //sex-linked mutations
    
    
    //yellowcheek
    [self.SLYellowcheekButton setSelectedSegmentIndex:[self.bird.SLYellowcheek getButton]];
    
    //lutino
    [self.lutinoButton setSelectedSegmentIndex:[self.bird.lutino getButton]];
    
    //pearl
    [self.pearlButton setSelectedSegmentIndex:[self.bird.pearl getButton]];
    
    //cinnamon
    [self.cinnamonButton setSelectedSegmentIndex:[self.bird.cinnamon getButton]];
    
    [self.view setNeedsDisplay];
    
}


@end
