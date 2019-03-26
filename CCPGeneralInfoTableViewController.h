//
//  CCPGeneralInfoTableViewController.h
//  Cockatiel Color Palette
//
//  Created by Kirsten Anderson on 5/29/15.
//  Copyright (c) 2015 Kirsten Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CCPGeneralInfoTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *parblueTopicsArray;
@property (nonatomic, strong) NSMutableArray *geneticsTopicsArray;
@property (nonatomic, strong) NSMutableArray *sexlinkedTopicsArray;
@property (nonatomic, strong) NSMutableArray *mainHelpTopicsArray;
@property (nonatomic, strong) NSMutableArray *faqArray;

@property (nonatomic, strong) NSDictionary *helpTopicDictionary;
@property (nonatomic, strong) NSArray *currentTopicArray;


@property (nonatomic, weak) NSString *whichTopic;

- (instancetype)initWithTopic:(NSString *)topic;

@end
