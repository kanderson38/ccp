//
//  CCPHelpTopic.h
//  Cockatiel Color Palette
//
//  Created by Kirsten Anderson on 10/9/15.
//  Copyright © 2015 Kirsten Anderson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCPHelpTopic : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *tag;
@property (strong, nonatomic) NSString *fullText;
@property (strong, nonatomic) NSMutableArray *subtopics;
@property (weak, nonatomic) NSMutableArray *relatedTopics;


+ (NSMutableDictionary *) createHelpTopicDictionary;

@end
