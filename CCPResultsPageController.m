//
//  CCPResultsPageController.m
//  Cockatiel Color Palette
//
//  Created by Kirsten Anderson on 1/28/15.
//  Copyright (c) 2015 Kirsten Anderson. All rights reserved.
//

#import "CCPResultsPageController.h"
#import "CCPInfoViewController.h"
#import "UIColor+CCPCustomColors.h"




@interface CCPResultsPageController ()

@property (strong, nonatomic) NSArray *maleChicks;
@property (strong, nonatomic) NSArray *femaleChicks;
@property (strong, nonatomic) NSArray *maleCrossovers;
@property (strong, nonatomic) NSArray *femaleCrossovers;
@property (nonatomic) int crossoversIndex;

@end


@implementation CCPResultsPageController

#pragma mark - View preparation

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 100.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.maleChicks = [self.breedingResults objectAtIndex:0];
    self.femaleChicks = [self.breedingResults objectAtIndex:1];
    if (self.breedingResults.count == 4) {
        self.maleCrossovers = [self.breedingResults objectAtIndex:2];
        self.femaleCrossovers = [self.breedingResults objectAtIndex:3];
    } else {
        self.maleCrossovers = nil;
        self.femaleCrossovers = nil;
    }

    
    UINib *nib = [UINib nibWithNibName:@"CCPBirdColorsView" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"CCPBirdColorsView"];

    
}

- (void)viewWillAppear:(BOOL)animated
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self
           selector:@selector(adjustTypeSize)
               name:UIContentSizeCategoryDidChangeNotification
             object:nil];
    [self adjustTypeSize];
}

- (void)adjustTypeSize {
    [self.tableView reloadData];
}

- (void)dealloc
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}

#pragma mark - Navigation

- (void) loadHelpView: (id)sender
{
    
    NSString *topic = NSLocalizedString(@"What is a crossover?", nil);
    CCPInfoViewController *ivc = [[CCPInfoViewController alloc] init];
    ivc.whichText = topic;
    
    [self.navigationController showViewController:ivc sender:nil];
    
}

#pragma mark - Table setup


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    } else if (section == 1) {
        return [self.maleChicks count];
    } else if (section == 2) {
        return [self.femaleChicks count];
    } else if (section == 3) {
        return [self.maleCrossovers count];
    } else if (section == 4) {
        return [self.femaleCrossovers count];
    }
    

    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    int sections = 3;
    
    if ([[self.breedingResults objectAtIndex:2] count] != 0) {
        sections += 2;
    }
    
    return sections;
    
    }



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    //style the section header text
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, tableView.frame.size.width, 50)];
    headerLabel.numberOfLines = 0;
    headerLabel.textColor = [UIColor customLightYellowColor];
    headerLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,50)];
    view.backgroundColor = [UIColor darkGrayColor];
    
    //add help button and assign tag (parameter determining which help topics to show)
    
    UIButton *helpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    helpButton.tintColor = [UIColor customLightOrangeColor];
    helpButton.frame = CGRectMake((view.frame.size.width - (view.frame.size.height/2 + 20)), 5, 40, 40); //(view.frame.size.height/2 + 20)), (view.frame.size.height/2 - 20), 40, 40)
    [helpButton setImage:[UIImage imageNamed:@"instructionsicon.pdf"] forState:UIControlStateNormal];
    helpButton.tag = section;
    
    [helpButton addTarget:self
                   action:@selector(loadHelpView:)
         forControlEvents:UIControlEventTouchUpInside];
    if (section == 0) {
        headerLabel.text = NSLocalizedString(@"parents", @"parents");
        [helpButton setHidden:YES];
    } else if (section == 1) {
        headerLabel.text = NSLocalizedString(@"male chicks", @"male chicks");
        [helpButton setHidden:YES];
    } else if (section == 2) {
            headerLabel.text = NSLocalizedString(@"female chicks", @"female chicks");
        [helpButton setHidden:YES];
    } else if (section == 3){
        headerLabel.text = NSLocalizedString(@"crossovers male chicks", @"crossovers male chicks");
    [helpButton setHidden:NO];
        
    } else if (section == 4) {
        headerLabel.text = NSLocalizedString(@"crossovers female chicks", @"crossovers female chicks");
        [helpButton setHidden:NO];
    }
    
    [view addSubview:headerLabel];
    [view addSubview:helpButton];
    
    return view;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 50;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    // Create an instance of UITableViewCell
    
    CCPBirdColorsView *cell = [tableView dequeueReusableCellWithIdentifier:@"CCPBirdColorsView" forIndexPath:indexPath];
    
    cell.resultsLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    cell.resultsLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.resultsLabel.numberOfLines = 0;
    cell.disclosureAccessory.alpha = 0.0;
 
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.resultsLabel.text = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"father", @"father"), [self.father translateIntoWords]];
            [cell displayImageColors:self.father];
        } else if (indexPath.row == 1) {
            cell.resultsLabel.text = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"mother", @"mother"), [self.mother translateIntoWords]];
            [cell displayImageColors:self.mother];
        }
    } else if (indexPath.section == 1) {
        CCPBirdObject *bird = [self.maleChicks objectAtIndex:indexPath.row];
        int percentage = (int)(bird.frequencyIndex * 100);
        cell.resultsLabel.text = [NSString stringWithFormat:@"%i%% %@", percentage, [bird translateIntoWords]];
        [cell displayImageColors:bird];
    } else if (indexPath.section == 2) {
        CCPBirdObject *bird = [self.femaleChicks objectAtIndex:indexPath.row];
        int percentage = (int)(bird.frequencyIndex * 100);
        cell.resultsLabel.text = [NSString stringWithFormat:@"%i%% %@", percentage, [bird translateIntoWords]];
        [cell displayImageColors:bird];
    } else if (indexPath.section == 3) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,50)];
        view.backgroundColor = [UIColor darkGrayColor];
               
        CCPBirdObject *bird = [self.maleCrossovers objectAtIndex:indexPath.row];
        
        NSString *maleString = [NSMutableString stringWithFormat:@"%@", [bird translateIntoWords]];
        [cell displayImageColors:bird];
        cell.resultsLabel.text = maleString;
        
    } else if (indexPath.section == 4) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,50)];
        view.backgroundColor = [UIColor darkGrayColor];
        
        
        
        CCPBirdObject *bird = [self.femaleCrossovers objectAtIndex:indexPath.row];
        cell.resultsLabel.text = [NSString stringWithFormat:@"%@", [bird translateIntoWords]];
        [cell displayImageColors:bird];
    }
    
    return cell;
}



@end
