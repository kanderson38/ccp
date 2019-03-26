//
//  CCPHelpTopic.m

//creates a dictionary of help topics and titles for display in a table view

//  Cockatiel Color Palette
//
//  Created by Kirsten Anderson on 10/9/15.
//  Copyright © 2015 Kirsten Anderson. All rights reserved.
//

#import "CCPHelpTopic.h"

@interface CCPHelpTopic ()

@end

@implementation CCPHelpTopic

- (instancetype)initWithTitle:(NSString *)title andTag:(NSString *)tag andText:(NSString *)text orSubtopics:(NSMutableArray *)subtopics
{
    self = [super init];
    self.title = title;
    self.tag = tag;
    self.fullText = text;
    self.subtopics = subtopics;
    
    return self;
}


+ (NSMutableDictionary *) createHelpTopicDictionary
{
    
    static NSMutableDictionary *allHelpTopicsDictionary = nil;
    
    //only create dictionary once
    
    if (!allHelpTopicsDictionary) {
    
    //instructions
    //basic breeder instructions
    
    CCPHelpTopic *basicBreederInstructions = [[CCPHelpTopic alloc]
                                              initWithTitle:NSLocalizedString(@"How to use the virtual breeder title", nil)
                                              andTag:@"basicBreederInstructions"
                                              andText:NSLocalizedString(@"How to use the virtual breeder", nil)
                                              orSubtopics:nil];
    
    
    //genetics lesson
    //mutations
    
    CCPHelpTopic *whatIsAMutation = [[CCPHelpTopic alloc]
                                     initWithTitle:NSLocalizedString(@"What is a mutation title", nil)
                                     andTag:@"whatIsAMutation"
                                     andText:NSLocalizedString(@"What is a mutation?", nil)
                                     orSubtopics:nil];
    
    //inheritance
    
    CCPHelpTopic *inheritance = [[CCPHelpTopic alloc]
                                 initWithTitle:NSLocalizedString(@"How are the mutations inherited title", nil)
                                 andTag:@"inheritance"
                                 andText:NSLocalizedString(@"How are the mutations inherited?", nil)
                                 orSubtopics:nil];
    
    //X1X2
    
    CCPHelpTopic *X1X2 = [[CCPHelpTopic alloc]
                          initWithTitle:NSLocalizedString(@"What do X1 and X2 mean title", nil)
                          andTag:@"X1X2"
                          andText:NSLocalizedString(@"What do X1 and X2 mean?", nil)
                          orSubtopics:nil];
    
    //crossovers
    
    CCPHelpTopic *crossovers = [[CCPHelpTopic alloc]
                                initWithTitle:NSLocalizedString(@"What is a crossover title", nil)
                                andTag:@"crossovers"
                                andText:NSLocalizedString(@"What is a crossover?", nil)
                                orSubtopics:nil];
    
    //what does parblue mean
    
    CCPHelpTopic *parblueMeaning = [[CCPHelpTopic alloc]
                                    initWithTitle:NSLocalizedString(@"What does \"parblue\" mean title", nil)
                                    andTag:@"parblueMeaning"
                                    andText:NSLocalizedString(@"What does \"parblue\" mean?", nil)
                                    orSubtopics:nil];
    
    //what are the parblue mutations
    
    CCPHelpTopic *parblueMutations = [[CCPHelpTopic alloc]
                                      initWithTitle:NSLocalizedString(@"What are the parblue mutations title", nil)
                                      andTag:@"parblueMutations"
                                      andText:NSLocalizedString(@"What are the parblue mutations?", nil)
                                      orSubtopics:nil];
    
    //entering parblue in breeder
    
    CCPHelpTopic *enteringParblueInBreeder = [[CCPHelpTopic alloc]
                                              initWithTitle:NSLocalizedString(@"How do I enter parblue types in the Virtual Breeder title", nil)
                                              andTag:@"enteringParblueInBreeder"
                                              andText:NSLocalizedString(@"How do I enter parblue types in the Virtual Breeder", nil)
                                              orSubtopics:nil];
    
    //what does phenotype mean
    
    CCPHelpTopic *phenotypeMeaning = [[CCPHelpTopic alloc]
                                      initWithTitle:NSLocalizedString(@"What does \"phenotype\" mean title", nil)
                                      andTag:@"phenotypeMeaning"
                                      andText:NSLocalizedString(@"What does \"phenotype\" mean?", nil)
                                      orSubtopics:nil];
    
    //FAQ
    //why no albino
    
    CCPHelpTopic *whyNoAlbino = [[CCPHelpTopic alloc]
                                 initWithTitle:NSLocalizedString(@"Why isn't \"albino\" an option in the Virtual Breeder title", nil)
                                 andTag:@"whyNoAlbino"
                                 andText:NSLocalizedString(@"Why isn't \"albino\" an option in the Virtual Breeder", nil)
                                 orSubtopics:nil];
    
    //unexpected results
    
    CCPHelpTopic *unexpectedResults = [[CCPHelpTopic alloc]
                                       initWithTitle:NSLocalizedString(@"Why don't my chicks match the virtual breeder's results title", nil)
                                       andTag:@"unexpectedResults"
                                       andText:NSLocalizedString(@"Why don't my chicks match the virtual breeder's results", nil)
                                       orSubtopics:nil];
    
    
    //create topic collections
    
    NSMutableArray *parblueSubtopics = [[NSMutableArray alloc] initWithObjects:
                                        parblueMeaning,
                                        parblueMutations,
                                        enteringParblueInBreeder,
                                        phenotypeMeaning,
                                        nil];
    
    NSMutableArray *geneticsSubtopics = [[NSMutableArray alloc] initWithObjects:
                                         whatIsAMutation,
                                         inheritance,
                                         X1X2,
                                         crossovers,
                                         nil];
    
    NSMutableArray *FAQSubtopics = [[NSMutableArray alloc] initWithObjects:
                                    whyNoAlbino,
                                    unexpectedResults,
                                    phenotypeMeaning,
                                    nil];
        
        
    CCPHelpTopic *parblueTopics = [[CCPHelpTopic alloc]
                                   initWithTitle:NSLocalizedString(@"parblue topics title", nil)
                                   andTag:@"parblueTopics"
                                   andText:nil
                                   orSubtopics:parblueSubtopics];
    
    CCPHelpTopic *geneticsTopics = [[CCPHelpTopic alloc]
                                    initWithTitle:NSLocalizedString(@"Genetics lesson title", nil)
                                    andTag:@"geneticsTopics"
                                    andText:nil
                                    orSubtopics:geneticsSubtopics];
    
    CCPHelpTopic *FAQTopics = [[CCPHelpTopic alloc]
                               initWithTitle:NSLocalizedString(@"FAQ title", nil)
                               andTag:@"FAQTopics"
                               andText:nil
                               orSubtopics:FAQSubtopics];
       
        //mutations is a special case, since it opens a different table view controller type
        CCPHelpTopic *mutationsTopics = [[CCPHelpTopic alloc]
                                   initWithTitle:NSLocalizedString(@"mutations title", nil)
                                   andTag:@"mutationsTopics"
                                   andText:nil
                                   orSubtopics:nil];
        
        NSMutableArray *mainSubtopics = [[NSMutableArray alloc] initWithObjects:
                                         basicBreederInstructions,
                                         geneticsTopics,
                                         mutationsTopics,
                                         parblueTopics,
                                         FAQTopics,
                                         nil];

        
        CCPHelpTopic *mainTopics = [[CCPHelpTopic alloc]
                                    initWithTitle:@"main"
                                    andTag:@"mainTopics"
                                    andText:nil
                                    orSubtopics:mainSubtopics];
       
    
    //top-level dictionary, contains all topics and collections
    
        allHelpTopicsDictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                   mainTopics, @"mainTopics",
                                   basicBreederInstructions, @"basicBreederInstructions",
                                   geneticsTopics, @"geneticsTopics",
                                   mutationsTopics, @"mutationsTopics",
                                   parblueTopics, @"parblueTopics",
                                   FAQTopics, @"FAQTopics",
                                   whatIsAMutation, @"whatIsAMutation",
                                   inheritance, @"inheritance",
                                   X1X2, @"X1X2",
                                   crossovers, @"crossovers",
                                   parblueMeaning, @"parblueMeaning",
                                   parblueMutations, @"parblueMutations",
                                   enteringParblueInBreeder, @"enteringParblueInBreeder",
                                   phenotypeMeaning, @"phenotypeMeaning",
                                   whyNoAlbino, @"whyNoAlbino",
                                   unexpectedResults, @"unexpectedResults",
                                   nil];
        

}

    return allHelpTopicsDictionary;
}


@end
