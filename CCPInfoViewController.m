
// Displays individual help topics in text view/scroll view.
//
//  CCPInfoViewController.m
//  Cockatiel Color Palette
//
//  Created by Kirsten Anderson on 2/6/15.
//  Copyright (c) 2015 Kirsten Anderson. All rights reserved.
//

#import "CCPInfoViewController.h"


@interface CCPInfoViewController ()
@property (weak, nonatomic) IBOutlet UITextView *mainText;

@end

@implementation CCPInfoViewController

#pragma mark - View preparation

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self
           selector:@selector(loadPageText)
               name:UIContentSizeCategoryDidChangeNotification
             object:nil];
    
    [self loadPageText];
    
}

- (void)loadPageText
{
    NSDictionary *titleTextDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline],
                                         NSFontAttributeName, [UIColor darkGrayColor], NSForegroundColorAttributeName, nil];
    NSDictionary *textDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:[UIFont preferredFontForTextStyle:UIFontTextStyleBody],
                                    NSFontAttributeName, [UIColor darkGrayColor], NSForegroundColorAttributeName, nil];
    
    
    //use segue id to get topic
    //display title in correct format, followed by main text
    if (!self.whichText) {
        if ([self.restorationIdentifier isEqualToString:@"aboutPage"]) {
            self.whichText = NSLocalizedString(@"about full text", nil);
            
        }
    }
    
    NSString *info1 = self.whichText;
    
    //get range of the first paragraph, set title attributes
    NSRange range = [info1 rangeOfString:@"\n\n"];
    range.length = range.location;
    range.location = 0;
    NSMutableAttributedString *attributedInfo = [[NSMutableAttributedString alloc] initWithString:info1 attributes:textDictionary];
    [attributedInfo addAttributes:titleTextDictionary range:range];
    self.mainText.attributedText = attributedInfo;
    
}


//scrollRangeToVisible must be called from this method
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.mainText scrollRectToVisible:(CGRectMake(0.0, 0.0, 1.0, 1.0)) animated:NO];
    //[self.mainText scrollRangeToVisible:NSMakeRange(0, 1)]; //load text aligned to the top of the textView

}


- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view from its nib.
}

#pragma mark - Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}

@end
