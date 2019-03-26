//
//  CCPMutationsMenuTableViewController.m
//  Cockatiel Color Palette
//
//  Created by Kirsten Anderson on 5/12/15.
//  Copyright (c) 2015 Kirsten Anderson. All rights reserved.
//

#import "CCPMutationsMenuTableViewController.h"
#import "CCPMutationInfoViewController.h"


@interface CCPMutationsMenuTableViewController ()

@property (strong, nonatomic) NSArray *mutationsArray;
@property (strong, nonatomic) NSDictionary *mutationsDictionary;
@property (strong, nonatomic) NSDictionary *singleMutationDict;


@end

@implementation CCPMutationsMenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 120.0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UINib *nib = [UINib nibWithNibName:@"CCPBirdColorsView" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"CCPBirdColorsView"];

    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    
        self.navigationItem.backBarButtonItem = backButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!self.mutationsArray) {
        
        //set up each mutation as a dictionary including the image name, bird object (for displaying BirdColorsView) and the description text
        CCPBirdObject *greyBird = [[CCPBirdObject alloc] initWithGender:@"male"];
        
        NSDictionary *greyDict = [[NSDictionary alloc] initWithObjectsAndKeys:@"grey1x.png", @"image",
                                  NSLocalizedString(@"grey_desc", @"Normal Grey Description"), @"desc",
                                  NSLocalizedString(@"normal grey", @"normal grey"), @"name",
                                  greyBird, @"bird",
                                  nil];
        
        CCPBirdObject *cinnamonBird = [[CCPBirdObject alloc] initWithGender:@"male"];
        cinnamonBird.cinnamon.visual = TRUE;
        
        NSDictionary *cinnamonDict = [[NSDictionary alloc] initWithObjectsAndKeys:@"fallow_cinnamon1x.png", @"image",
                                      NSLocalizedString(@"cinnfallow_desc", @"Cinnamon/Fallow Description"), @"desc",
                                      NSLocalizedString(@"cinnamon", @"cinnamon"), @"name",
                                      cinnamonBird, @"bird",
                                      nil];
        
        CCPBirdObject *fallowBird = [[CCPBirdObject alloc] initWithGender:@"male"];
        fallowBird.fallow.visual = TRUE;
        
        NSDictionary *fallowDict = [[NSDictionary alloc] initWithObjectsAndKeys:@"fallow_cinnamon1x.png", @"image",
                                    NSLocalizedString(@"cinnfallow_desc", @"Cinnamon/Fallow Description"), @"desc",
                                    NSLocalizedString(@"fallow", @"fallow"), @"name",
                                    fallowBird, @"bird",
                                    nil];
        
        CCPBirdObject *lutinoBird = [[CCPBirdObject alloc] initWithGender:@"male"];
        lutinoBird.lutino.visual = TRUE;
        
        NSDictionary *lutinoDict = [[NSDictionary alloc] initWithObjectsAndKeys:@"lutino1x.png", @"image",
                                    NSLocalizedString(@"lutino_desc", @"Lutino Description"), @"desc",
                                    NSLocalizedString(@"lutino", @"lutino"), @"name",
                                    lutinoBird, @"bird",
                                    nil];
        
        CCPBirdObject *oliveBird = [[CCPBirdObject alloc] initWithGender:@"male"];
        oliveBird.olive.visual = TRUE;
        
        NSDictionary *oliveDict = [[NSDictionary alloc] initWithObjectsAndKeys:@"olive1x.png", @"image",
                                   NSLocalizedString(@"olive_desc", @"Olive Description"), @"desc",
                                   NSLocalizedString(@"olive", @"olive"), @"name",
                                   oliveBird, @"bird",
                                   nil];
        
        CCPBirdObject *creamfaceBird = [[CCPBirdObject alloc] initWithGender:@"male"];
        creamfaceBird.parblue.gene1 = 2;
        creamfaceBird.parblue.gene2 = 2;
        
        NSDictionary *creamfaceDict = [[NSDictionary alloc] initWithObjectsAndKeys:@"parblue1x.png", @"image",
                                       NSLocalizedString(@"parblue_desc", @"Parblue Description"), @"desc",
                                       NSLocalizedString(@"creamface", @"creamface"), @"name",
                                       creamfaceBird, @"bird",
                                       nil];
        
        CCPBirdObject *pastelfaceBird = [[CCPBirdObject alloc] initWithGender:@"male"];
        pastelfaceBird.parblue.gene1 = 1;
        pastelfaceBird.parblue.gene2 = 1;
        
        NSDictionary *pastelfaceDict = [[NSDictionary alloc] initWithObjectsAndKeys:@"parblue1x.png", @"image",
                                        NSLocalizedString(@"parblue_desc", @"Parblue Description"), @"desc",
                                        NSLocalizedString(@"pastelface", @"pastelface"), @"name",
                                        pastelfaceBird, @"bird",
                                        nil];
        
        CCPBirdObject *whitefaceBird = [[CCPBirdObject alloc] initWithGender:@"male"];
        whitefaceBird.parblue.gene1 = 3;
        whitefaceBird.parblue.gene2 = 3;
        
        NSDictionary *whitefaceDict = [[NSDictionary alloc] initWithObjectsAndKeys:@"parblue1x.png", @"image",
                                       NSLocalizedString(@"parblue_desc", @"Parblue Description"), @"desc",
                                       NSLocalizedString(@"whiteface", @"whiteface"), @"name",
                                       whitefaceBird, @"bird",
                                       nil];
        
        CCPBirdObject *pearlBird = [[CCPBirdObject alloc] initWithGender:@"male"];
        pearlBird.pearl.visual = TRUE;
        
        NSDictionary *pearlDict = [[NSDictionary alloc] initWithObjectsAndKeys:@"pearl1x.png", @"image",
                                   NSLocalizedString(@"pearl_desc", @"Pearl Description"), @"desc",
                                   NSLocalizedString(@"pearl", @"pearl"), @"name",
                                   pearlBird, @"bird",
                                   nil];
        
        CCPBirdObject *piedBird = [[CCPBirdObject alloc] initWithGender:@"male"];
        piedBird.pied.visual = TRUE;
        
        NSDictionary *piedDict = [[NSDictionary alloc] initWithObjectsAndKeys:@"pied1x.png", @"image",
                                  NSLocalizedString(@"pied_desc", @"Pied Description"), @"desc",
                                  NSLocalizedString(@"pied", @"pied"), @"name",
                                  piedBird, @"bird",
                                  nil];
        
        CCPBirdObject *recSilverBird = [[CCPBirdObject alloc] initWithGender:@"male"];
        recSilverBird.recSilver.visual = TRUE;
        
        NSDictionary *recSilverDict = [[NSDictionary alloc] initWithObjectsAndKeys:@"silvers1x.png", @"image",
                                       NSLocalizedString(@"silver_desc", @"Silver Description"), @"desc",
                                       NSLocalizedString(@"recessive silver", @"recessive silver"), @"name",
                                       recSilverBird, @"bird",
                                       nil];
        
        CCPBirdObject *domSilverBird = [[CCPBirdObject alloc] initWithGender:@"male"];
        domSilverBird.domSilver.visual = TRUE;
        domSilverBird.domSilver.gene1 = 1;
        domSilverBird.domSilver.gene2 = 1;
        
        NSDictionary *domSilverDict = [[NSDictionary alloc] initWithObjectsAndKeys:@"silvers1x.png", @"image",
                                       NSLocalizedString(@"silver_desc", @"Silver Description"), @"desc",
                                       NSLocalizedString(@"dominant silver", @"dominant silver"), @"name",
                                       domSilverBird, @"bird",
                                       nil];
        
        CCPBirdObject *SLYellowcheekBird = [[CCPBirdObject alloc] initWithGender:@"male"];
        SLYellowcheekBird.SLYellowcheek.visual = TRUE;
        
        NSDictionary *SLYellowcheekDict = [[NSDictionary alloc] initWithObjectsAndKeys:@"yellowcheek1x.png", @"image",
                                           NSLocalizedString(@"yellowcheek_desc", @"Yellowcheek Description"), @"desc",
                                           NSLocalizedString(@"sex-linked yellowcheek", @"sex-linked yellowcheek"), @"name",
                                           SLYellowcheekBird, @"bird",
                                           nil];
        
        CCPBirdObject *domYellowcheekBird = [[CCPBirdObject alloc] initWithGender:@"male"];
        domYellowcheekBird.domYellowcheek.visual = TRUE;
        domYellowcheekBird.domYellowcheek.gene1 = 1;
        domYellowcheekBird.domYellowcheek.gene2 = 1;
        
        NSDictionary *domYellowcheekDict = [[NSDictionary alloc] initWithObjectsAndKeys:@"yellowcheek1x.png", @"image",
                                            NSLocalizedString(@"yellowcheek_desc", @"Yellowcheek Description"), @"desc",
                                            NSLocalizedString(@"dominant yellowcheek", @"dominant yellowcheek"), @"name",
                                            domYellowcheekBird, @"bird",
                                            nil];
        
        self.mutationsArray = [[NSArray alloc] initWithObjects:greyDict, cinnamonDict, creamfaceDict, fallowDict, lutinoDict, oliveDict, pastelfaceDict, pearlDict, piedDict, domSilverDict, recSilverDict, domYellowcheekDict, SLYellowcheekDict, whitefaceDict, nil];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.mutationsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CCPBirdColorsView *cell = [tableView dequeueReusableCellWithIdentifier:@"CCPBirdColorsView" forIndexPath:indexPath];
    
    
    cell.resultsLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.resultsLabel.numberOfLines = 0;
    cell.resultsLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    cell.resultsLabel.textColor = [UIColor darkGrayColor];
    
    NSDictionary *currentMutation = [self.mutationsArray objectAtIndex:(int)indexPath.row];
    NSString *name = [currentMutation objectForKey:@"name"];
    CCPBirdObject *bird = [currentMutation objectForKey:@"bird"];
    name = [name stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[name substringToIndex:1] uppercaseString]];
    
    cell.resultsLabel.text = name;
    [cell displayImageColors:bird];
    cell.accessoryView = cell.disclosureAccessory;
    return cell;
}

//pass mutation info to new view controller

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGRect screenRect = self.view.window.bounds;
    CCPMutationInfoViewController *vc = [[CCPMutationInfoViewController alloc] initWithNibName:@"CCPMutationInfoViewController" bundle:nil];
    vc.mutationDict = [self.mutationsArray objectAtIndex:indexPath.row];
    vc.view.frame = screenRect;
    vc.hidesBottomBarWhenPushed = YES;

    [self.navigationController pushViewController:vc animated:YES];
}


@end
