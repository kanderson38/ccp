//
//  CCPGeneralInfoTableViewController.m
//  Cockatiel Color Palette

// A table view controller that uses its restoration identifier to display the correct help topics.
// Selecting a row in the table view presents a view controller that displays the selected information.
//
//  Created by Kirsten Anderson on 5/29/15.
//  Copyright (c) 2015 Kirsten Anderson. All rights reserved.
//

#import "CCPGeneralInfoTableViewController.h"
#import "CCPInfoViewController.h"
#import "CCPHelpTopic.h"
#import "CCPMutationsMenuTableViewController.h"

@interface CCPGeneralInfoTableViewController ()


@property (nonatomic, strong) NSMutableArray *mainHelpTopicsTitleArray;
@end


@implementation CCPGeneralInfoTableViewController

#pragma mark - initialize

- (instancetype)initWithTopic:(NSString *)topic
{
    self = [super init];
    
    self.restorationIdentifier = topic;
    return self;
}

#pragma mark - view prep

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"generalInfo"];
    //load all the help topics
    NSMutableDictionary *allHelpTopics = [CCPHelpTopic createHelpTopicDictionary];
    
    NSString *restorationID = self.restorationIdentifier;
    
    CCPHelpTopic *helpTopic = [allHelpTopics objectForKey:restorationID];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0;
    
    if (helpTopic.subtopics) {
        self.currentTopicArray = helpTopic.subtopics;
    } else {
        self.currentTopicArray = [allHelpTopics objectForKey:@"mainTopics"];
    }
    
}


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

#pragma mark - memory management

- (void)dealloc
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table functions


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (self.currentTopicArray.count) {
        return self.currentTopicArray.count;
    } else {
        return 0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"generalInfo" forIndexPath:indexPath];
    
    
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.textColor = [UIColor darkGrayColor];
    
    CCPHelpTopic *cellTopic = [self.currentTopicArray objectAtIndex:indexPath.row];
    cell.textLabel.text = cellTopic.title;
    
//    UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0.0, (cell.frame.size.height - 1), cell.frame.size.width, 1.0)];
//    separator.backgroundColor = [UIColor darkGrayColor];
//    [cell addSubview:separator];

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CCPHelpTopic *selectedTopic = [self.currentTopicArray objectAtIndex:indexPath.row];
    
    //if "mutations" is selected, load the mutations view
    if ([selectedTopic.tag isEqualToString:@"mutationsTopics"]) {
        CCPMutationsMenuTableViewController *vc = [[CCPMutationsMenuTableViewController alloc] init];
        self.navigationController.navigationBar.translucent = NO;
        [self.navigationController pushViewController:vc animated:YES];
    //if dictionary entry is an array, open another infoTableViewController to display the subtopics
} else if (selectedTopic.subtopics != nil) {
        CCPGeneralInfoTableViewController *vc = [[CCPGeneralInfoTableViewController alloc] initWithTopic:selectedTopic.tag];
        self.navigationController.navigationBar.translucent = NO;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        CCPInfoViewController *vc = [[CCPInfoViewController alloc] initWithNibName:@"CCPInfoViewController" bundle:nil];
        vc.whichText = selectedTopic.fullText;

        self.navigationController.navigationBar.translucent = NO;
    [self.navigationController pushViewController:vc animated:YES];
    }
    
}



@end
