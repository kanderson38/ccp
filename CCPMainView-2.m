////
////  CCPMainView.m
////  Cockatiel Color Palette
////
////  Created by Kirsten Anderson on 1/6/15.
////  Copyright (c) 2015 Kirsten Anderson. All rights reserved.
////
//
//#import "CCPMainView.h"
//#import "CCPMaleTableViewController.h"
//#import "CCPBirdObject.h"
//#import "CCPResultsPageController.h"
//#import "CCPMutation.h"
//#import "CCPFemaleTableViewController.h"
//#import "CCPBreeding.h"
//
//
//@interface CCPMainView ()
//@property (weak, nonatomic) IBOutlet UINavigationBar *pageLabel;
//@property (weak, nonatomic) IBOutlet UIButton *setMaleButton;
//@property (weak, nonatomic) IBOutlet UILabel *maleTypeLabel;
//@property (weak, nonatomic) IBOutlet UIButton *setFemaleButton;
//@property (weak, nonatomic) IBOutlet UILabel *femaleTypeLabel;
//@property (nonatomic, strong) IBOutletCollection(UILabel) NSArray *parentLabels;
//@property (nonatomic, strong) CCPBirdObject *fatherBird;
//@property (nonatomic, strong) CCPBirdObject *motherBird;
//
//@property (weak, nonatomic) IBOutlet UIButton *breedButton;
//
//@end
//
//@implementation CCPMainView
//
//-(IBAction)returnToMainPage:(UIStoryboardSegue *)segue;
//{
//    CCPMaleTableViewController *mc = [segue sourceViewController];
//    if ([segue.identifier isEqualToString:@"returnMale"]) {
//    self.fatherBird = mc.bird;
//    self.maleTypeLabel.text = [self.fatherBird translateIntoWords];
//    } else if ([segue.identifier isEqualToString:@"returnFemale"]) {
//        self.motherBird = mc.bird;
//        self.femaleTypeLabel.text = [self.motherBird translateIntoWords];
//    }
//}
//
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view from its nib.
//    [super viewDidLoad];
//    
//    
//    //initialize parents
//    NSString *birdNameFather = @" ";
//    NSString *birdNameMother = @" ";
//    
//    if (!_fatherBird) {
//        self.fatherBird = [[CCPBirdObject alloc] initWithGender:@"male"];
//        birdNameFather = [[self.fatherBird translateIntoWords] stringByAppendingString:NSLocalizedString(@"initial parent text", @"initial parent text")];
//    } else {
//    
//        birdNameFather = [self.fatherBird translateIntoWords];
//    }
//    
//    if (!_motherBird) {
//        self.motherBird = [[CCPBirdObject alloc] initWithGender:@"female"];
//        birdNameMother = [[self.motherBird translateIntoWords] stringByAppendingString:NSLocalizedString(@"initial parent text", @"initial parent text")];
//    } else {
//    
//    birdNameMother = [self.motherBird translateIntoWords];
//    }
//    
//    //capitalize the bird names
//    birdNameFather = [birdNameFather stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[birdNameFather substringToIndex:1] capitalizedString]];
//    birdNameMother = [birdNameMother stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[birdNameMother substringToIndex:1] capitalizedString]];
//    
//    self.maleTypeLabel.text = birdNameFather;
//    self.femaleTypeLabel.text = birdNameMother;
//    
//    
//    
//    }
//
//- (void) viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//    //format the labels properly
//    for (UILabel *label in self.parentLabels) {
//        label.textColor = [UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(230/255.0) alpha:1.0];
//    }
//    
//    self.tableView.estimatedRowHeight = 100.0;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
//    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"offspringCell"];
//    
//
//    
//    NSLog(@"%f", self.maleTypeLabel.bounds.size.height);
//}
//
//
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    
//    //style the section header text
//    
//    UIFont *headerFont = [UIFont fontWithName:@"GillSans" size:20.0];
//    
//    NSDictionary *headerAttributes = [[NSDictionary alloc] initWithObjectsAndKeys: headerFont, NSFontAttributeName, nil];
//    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, tableView.frame.size.width, 50)];
//    label.numberOfLines = 0;
//    label.textColor = [UIColor whiteColor];
//    if (section == 0) {
//        label.attributedText = [[NSMutableAttributedString alloc] initWithString:@"Parents' Types" attributes:headerAttributes];
//    }
//    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,50)];
//    //view.backgroundColor = [UIColor colorWithRed:79/255.0 green:36/255.0 blue:0/255.0 alpha:1.0];
//    view.backgroundColor = [UIColor darkGrayColor];
//    
//    [view addSubview:label];
//    
//    return view;
//}
//
//
////-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
////    // Create an instance of UITableViewCell
////    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"offspringCell" forIndexPath:indexPath];
////    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
////    cell.textLabel.numberOfLines = 0;
////    cell.textLabel.font = [UIFont fontWithName:@"GillSans" size:18.0];
////    cell.textLabel.textColor = [UIColor darkGrayColor];
////    
////    if (indexPath.section == 0) {
////        if (indexPath.row == 0) {
////            cell.textLabel.text = [NSString stringWithFormat:@"Father: %@", [self.fatherBird translateIntoWords]];
////        } else if (indexPath.row == 1) {
////            cell.textLabel.text = [NSString stringWithFormat:@"Mother: %@", [self.motherBird translateIntoWords]];
////        }
////    }
////    return cell;
////}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//
//    if ([segue.identifier isEqualToString:@"showMale"]) {
//        
//        CCPMaleTableViewController *maleView = (CCPMaleTableViewController *)segue.destinationViewController;
//        maleView.bird = self.fatherBird;
//        maleView.fatherBird = self.fatherBird;
//        maleView.motherBird = self.motherBird;
//        maleView.hidesBottomBarWhenPushed = YES;
//    } else if ([segue.identifier isEqualToString:@"showFemale"]) {
//        
//        CCPFemaleTableViewController *femaleView = (CCPFemaleTableViewController *)segue.destinationViewController;
//        femaleView.bird = self.motherBird;
//        femaleView.hidesBottomBarWhenPushed = YES;
//    } else if ([segue.identifier isEqualToString:@"showBreedingResults"]) {
//        
//        CCPResultsPageController *resultsView = (CCPResultsPageController *)segue.destinationViewController;
//        //send list of breeding results to view
//        NSArray *results = [[NSArray alloc] init];
//        results = [CCPBreeding breedMale:self.fatherBird toFemale:self.motherBird];
//        resultsView.breedingResults = results;
//        resultsView.father = self.fatherBird;
//        resultsView.mother = self.motherBird;
//        
//    }
//
//    
//    
//}
//
//
//
//
//@end
