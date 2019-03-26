//
//  CCPMutationInfoViewController.m
//  Cockatiel Color Palette
//
//  Created by Kirsten Anderson on 5/13/15.
//  Copyright (c) 2015 Kirsten Anderson. All rights reserved.
//

#import "CCPMutationInfoViewController.h"


@interface CCPMutationInfoViewController ()

@property (weak, nonatomic) IBOutlet UITextView *mainText;
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (strong, nonatomic) IBOutlet UIView *mainView;

@end

@implementation CCPMutationInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.backBarButtonItem.title = @"done";
    
    self.view.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(230/255.0) alpha:1.0];
    
    NSString *title = [self.mutationDict objectForKey:@"name"];
    title = [title stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[title substringToIndex:1] uppercaseString]];
    self.navigationItem.title = title;
    
    // create image view
    [self loadSubviews];
}

- (void)loadSubviews
{
    
    //get the image associated with the selected mutation
    NSString *imageName = [self.mutationDict objectForKey:@"image"];
    
    UIImage *birdImage = [UIImage imageNamed:imageName];
    self.mainImage.image = birdImage;
    
    
    //format the textView text, since the appearance customization in CCPStyleController doesn't seem to be working
    

    //get the description text associated with  the selected mutation
    NSString *descText = [self.mutationDict objectForKey:@"desc"];
    
    //more text appearance customization
    NSDictionary *textDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:[UIFont preferredFontForTextStyle:UIFontTextStyleBody],
                                    NSFontAttributeName, [UIColor darkGrayColor], NSForegroundColorAttributeName, nil];

    
    self.mainText.attributedText = [[NSAttributedString alloc] initWithString:descText attributes:textDictionary];
    //self.mainText.backgroundColor = [UIColor clearColor];
    
    self.mainText.scrollEnabled = YES;
    [self.mainText flashScrollIndicators];
}

//scrollRangeToVisible must be called from this method
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.mainText scrollRectToVisible:(CGRectMake(0.0, 0.0, 1.0, 1.0)) animated:NO];
    //[self.mainText scrollRangeToVisible:NSMakeRange(0, 1)]; //load text aligned to the top of the textView
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.mainImage.image = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
