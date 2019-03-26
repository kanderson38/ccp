//
//  CCPMainView.m
//  Cockatiel Color Palette
//
//  Created by Kirsten Anderson on 1/6/15.
//  Copyright (c) 2015 Kirsten Anderson. All rights reserved.
//

#import "CCPMainView.h"
#import "CCPMaleSelectController.h"
#import "CCPBirdObject.h"
#import "CCPResultsPageController.h"
#import "CCPMutation.h"
#import "CCPFemaleSelectController.h"
#import "CCPBreeding.h"
#import "CCPBirdColorsView.h"
#import "CCPInfoViewController.h"
#import "UIColor+CCPCustomColors.h"


@interface CCPMainView ()
//@property (weak, nonatomic) IBOutlet UINavigationBar *pageLabel;
//@property (weak, nonatomic) IBOutlet UIButton *setMaleButton;
//@property (weak, nonatomic) IBOutlet UILabel *maleTypeLabel;
//@property (weak, nonatomic) IBOutlet UIButton *setFemaleButton;
//@property (weak, nonatomic) IBOutlet UILabel *femaleTypeLabel;
//@property (nonatomic, strong) IBOutletCollection(UILabel) NSArray *parentLabels;
//@property (weak, nonatomic) IBOutlet UILabel *pageHeader;
@property (nonatomic, strong) CCPBirdObject *fatherBird;
@property (nonatomic, strong) CCPBirdObject *motherBird;

@end

@implementation CCPMainView



#pragma mark - View preparation

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
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



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"buttonCell"];
    
       if (!_fatherBird) {
        self.fatherBird = [[CCPBirdObject alloc] initWithGender:@"male"];
       }
    
    if (!_motherBird) {
        self.motherBird = [[CCPBirdObject alloc] initWithGender:@"female"];
    }
    
    
    
}

#pragma mark - Memory management

- (void)dealloc
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Table setup

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 100;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    //style the section header text

    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, tableView.frame.size.width - 52, 100)];
    headerLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    headerLabel.numberOfLines = 0;
    headerLabel.lineBreakMode = NSLineBreakByWordWrapping;
    headerLabel.textColor = [UIColor customLightYellowColor];
    
    if (section == 0) {
        headerLabel.text = NSLocalizedString(@"select parents types", nil);
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,100)];
    view.backgroundColor = [UIColor darkGrayColor];
    
    UIButton *helpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [helpButton setImage:[UIImage imageNamed:@"instructionsicon.pdf"] forState:UIControlStateNormal];
    helpButton.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    helpButton.tintColor = [UIColor customLightOrangeColor];
    helpButton.frame = CGRectMake((view.frame.size.width - 42), (view.frame.size.height/2 - 20), 40, 40); //(view.frame.size.height/2 + 20)), (view.frame.size.height/2 - 20), 40, 40)
    helpButton.tag = section;
    
    [helpButton addTarget:self
                   action:@selector(loadHelpView:)
         forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:helpButton];
    [view addSubview:headerLabel];
    
    
    return view;
}





-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Create an instance of UITableViewCell
    
    CCPBirdColorsView *cell = [tableView dequeueReusableCellWithIdentifier:@"CCPBirdColorsView" forIndexPath:indexPath];
    
    UITableViewCell *buttonCell = [tableView dequeueReusableCellWithIdentifier:@"buttonCell" forIndexPath:indexPath];
    
    cell.resultsLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    cell.resultsLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.resultsLabel.numberOfLines = 0;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.resultsLabel.text = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"father", @"father"), [self.fatherBird translateIntoWords]];
            [cell displayImageColors:self.fatherBird];
        } else if (indexPath.row == 1) {
            cell.resultsLabel.text = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"mother", @"mother"), [self.motherBird translateIntoWords]];
            [cell displayImageColors:self.motherBird];
        } else if (indexPath.row == 2) {
           // UIFont *headerFont = [UIFont fontWithName:@"GillSans" size:16.0];
            
            //NSDictionary *headerAttributes = [[NSDictionary alloc] initWithObjectsAndKeys: headerFont, NSFontAttributeName, nil];
            UILabel *breedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (buttonCell.frame.origin.y + 15), self.view.frame.size.width, buttonCell.frame.size.height)];
            
            breedLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
            breedLabel.lineBreakMode = NSLineBreakByWordWrapping;
            breedLabel.numberOfLines = 0;
            breedLabel.textColor = [UIColor customDarkOrangeColor];
            
            breedLabel.text = NSLocalizedString(@"view breeding results", @"view breeding results");
            breedLabel.textAlignment = NSTextAlignmentCenter;
            [buttonCell addSubview:breedLabel];
            return buttonCell;
        }
    }
    
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:@"showMale" sender:nil];
    } else if (indexPath.row == 1) {
        [self performSegueWithIdentifier:@"showFemale" sender:nil];
    } else if (indexPath.row == 2) {
        [self performSegueWithIdentifier:@"showBreedingResults" sender:nil];
    }
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

    if ([segue.identifier isEqualToString:@"showMale"]) {
        
        CCPMaleSelectController *maleView = (CCPMaleSelectController *)segue.destinationViewController;
        maleView.bird = self.fatherBird;
        maleView.fatherBird = self.fatherBird;
        maleView.motherBird = self.motherBird;
        maleView.hidesBottomBarWhenPushed = YES;
        
        //[self.navigationController pushViewController:maleView animated:YES];
    } else if ([segue.identifier isEqualToString:@"showFemale"]) {
        
        CCPFemaleSelectController *femaleView = (CCPFemaleSelectController *)segue.destinationViewController;
        femaleView.bird = self.motherBird;
        femaleView.hidesBottomBarWhenPushed = YES;
        //[self.navigationController pushViewController:femaleView animated:YES];
        
    } else if ([segue.identifier isEqualToString:@"showBreedingResults"]) {
        
        CCPResultsPageController *resultsView = (CCPResultsPageController *)segue.destinationViewController;
        //send list of breeding results to view
        NSArray *results = [[NSArray alloc] init];
        results = [CCPBreeding breedMale:self.fatherBird toFemale:self.motherBird];
        resultsView.breedingResults = results;
        resultsView.father = self.fatherBird;
        resultsView.mother = self.motherBird;
        
        //[self.navigationController pushViewController:resultsView animated:YES];
        
    }
    
}

//loads help view when disclosure button in header is pressed

//displays correct help topic when help button in section header is tapped
- (void) loadHelpView: (id)sender
{
    UIButton *clicked = (UIButton *)sender;
    
   if (clicked.tag == 0) {
        NSString *topic = NSLocalizedString(@"How to use the virtual breeder", nil);
        CCPInfoViewController *ivc = [[CCPInfoViewController alloc] init];
        ivc.whichText = topic;
        
        [self.navigationController showViewController:ivc sender:nil];
    }
    
}

-(IBAction)returnToMainPage:(UIStoryboardSegue *)segue;
{
    CCPMaleSelectController *mc = [segue sourceViewController];
    if ([segue.identifier isEqualToString:@"returnMale"]) {
        self.fatherBird = mc.bird;
    } else if ([segue.identifier isEqualToString:@"returnFemale"]) {
        self.motherBird = mc.bird;
    }
    
}


@end
