//
//  CCPBreeding.m

// takes care of all the gene recombination


//  Cockatiel Color Palette
//
//  Created by Kirsten Anderson on 3/13/15.
//  Copyright (c) 2015 Kirsten Anderson. All rights reserved.
//

#import "CCPBreeding.h"
#import "CCPBirdObject.h"
#import "CCPMutation.h"

@implementation CCPBreeding


//
//
//Keep method below in case I figure out a way to make the mutations more modular
//
//

//+ (NSMutableArray *)updateChickListsForMutation:(CCPMutation *)mutation withRecombination:(NSCountedSet *)countedSet andFullChickList:(NSMutableArray *)fullList {
//    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
//    
//    for (NSArray *chickType in countedSet) {
//        NSMutableArray *chicksToChange = [[NSMutableArray alloc] init];
//        for (int i = 0; i < fullList.count; i++) {
//            CCPBirdObject *bird = [[fullList objectAtIndex:i] mutableCopy];
//            int gene1 = [chickType[0] intValue];
//            int gene2 = [chickType [1] intValue];
//            [mutation setGene1:gene1];
//            [mutation setGene2:gene2];
//            
//            float total = (float)([countedSet countForObject:chickType] / 4.0);
//            float base = bird.frequencyIndex;
//            
//            bird.frequencyIndex = base * total;
//            
//            
//            //NSLog(@"gene1 %i, gene2 %i, inheritance %@, frequency %i, multiplier %i, %@", bird.pied.gene1, bird.pied.gene2, bird.pied.inheritance, bird.frequencyIndex, multiplier, [bird translateIntoWords]);
//            [chicksToChange addObject:bird];
//        }
//        [tempArray addObject:chicksToChange];
//    }
//    
//    NSMutableArray *newChicks = [[NSMutableArray alloc] init];
//    for (NSMutableArray *array in tempArray) {
//        [newChicks addObjectsFromArray:array];
//    }
//    
//    return newChicks;
//}

+(NSArray *)breedMale:(CCPBirdObject *)male toFemale:(CCPBirdObject *)female
{
    CCPBirdObject *firstChick = [[CCPBirdObject alloc] initWithGender:@"male"];
    
    NSMutableArray *chicks = [[NSMutableArray alloc] initWithObjects:firstChick, nil];
    
    //for each mutation, recombine the parents' genes
    //the recombine function returns a counted set of arrays; the arrays represent chicks' gene pairs
    
    //******************
    //pied
    //******************
    
    NSCountedSet *piedGenes = [self recombineAutosomalMale:male.pied female:female.pied];
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    //every unique chick type requires duplicating the existing list of chicks and changing the current mutation state
    for (NSArray *chickType in piedGenes) {
        NSMutableArray *chicksToChange = [[NSMutableArray alloc] init];
        for (int i = 0; i < chicks.count; i++) {
            CCPBirdObject *bird = [[chicks objectAtIndex:i] mutableCopy];
            int gene1 = [chickType[0] intValue];
            int gene2 = [chickType [1] intValue];
            [bird.pied setGene1:gene1];
            [bird.pied setGene2:gene2];
            
            float total = (float)([piedGenes countForObject:chickType] / 4.0);
            float base = bird.frequencyIndex;
            
            bird.frequencyIndex = base * total;
            
            //NSLog(@"gene1 %i, gene2 %i, inheritance %@, frequency %i, multiplier %i, %@", bird.pied.gene1, bird.pied.gene2, bird.pied.inheritance, bird.frequencyIndex, multiplier, [bird translateIntoWords]);
            [chicksToChange addObject:bird];
        }
        [tempArray addObject:chicksToChange];
    }
    
    //take all the temporary arrays of chicks and combine them into one array -- this is the new set of chicks that will be modified
    //for subsequent mutations
    NSMutableArray *newChicks = [[NSMutableArray alloc] init];
    for (NSMutableArray *array in tempArray) {
        [newChicks addObjectsFromArray:array];
    }
    
    chicks = [newChicks copy];
    
    //empty temporary arrays
    [newChicks removeAllObjects];
    [tempArray removeAllObjects];
    
    //******************
    //fallow
    //******************
    
    NSCountedSet *fallowGenes = [self recombineAutosomalMale:male.fallow female:female.fallow];
    
    for (NSArray *chickType in fallowGenes) {
        NSMutableArray *chicksToChange = [[NSMutableArray alloc] init];
        for (int i = 0; i < chicks.count; i++) {
            CCPBirdObject *bird = [[chicks objectAtIndex:i] mutableCopy];
            int gene1 = [chickType[0] intValue];
            int gene2 = [chickType [1] intValue];
            [bird.fallow setGene1:gene1];
            [bird.fallow setGene2:gene2];
            
            float total = (float)([fallowGenes countForObject:chickType] / 4.0);
            float base = bird.frequencyIndex;
            
            bird.frequencyIndex = base * total;
            
            
            //NSLog(@"gene1 %i, gene2 %i, inheritance %@, frequency %i, multiplier %i, %@", bird.pied.gene1, bird.pied.gene2, bird.pied.inheritance, bird.frequencyIndex, multiplier, [bird translateIntoWords]);
            [chicksToChange addObject:bird];
        }
        [tempArray addObject:chicksToChange];
    }
    
    newChicks = [[NSMutableArray alloc] init];
    for (NSMutableArray *array in tempArray) {
        [newChicks addObjectsFromArray:array];
    }
    
    chicks = [newChicks copy];
    
    [newChicks removeAllObjects];
    [tempArray removeAllObjects];
    
    //******************
    //recessive silver
    //******************
    
    NSCountedSet *recSilverGenes = [self recombineAutosomalMale:male.recSilver female:female.recSilver];
    
    for (NSArray *chickType in recSilverGenes) {
        NSMutableArray *chicksToChange = [[NSMutableArray alloc] init];
        for (int i = 0; i < chicks.count; i++) {
            CCPBirdObject *bird = [[chicks objectAtIndex:i] mutableCopy];
            int gene1 = [chickType[0] intValue];
            int gene2 = [chickType [1] intValue];
            [bird.recSilver setGene1:gene1];
            [bird.recSilver setGene2:gene2];
            
            float total = (float)([recSilverGenes countForObject:chickType] / 4.0);
            float base = bird.frequencyIndex;
            
            bird.frequencyIndex = base * total;
            
            //NSLog(@"gene1 %i, gene2 %i, inheritance %@, frequency %i, multiplier %i, %@", bird.pied.gene1, bird.pied.gene2, bird.pied.inheritance, bird.frequencyIndex, multiplier, [bird translateIntoWords]);
            [chicksToChange addObject:bird];
        }
        [tempArray addObject:chicksToChange];
    }
    
    newChicks = [[NSMutableArray alloc] init];
    for (NSMutableArray *array in tempArray) {
        [newChicks addObjectsFromArray:array];
    }
    
    chicks = [newChicks copy];
    
    [newChicks removeAllObjects];
    [tempArray removeAllObjects];
    
    
    //******************
    //olive
    //******************
    
    NSCountedSet *oliveGenes = [self recombineAutosomalMale:male.olive female:female.olive];
    
    for (NSArray *chickType in oliveGenes) {
        NSMutableArray *chicksToChange = [[NSMutableArray alloc] init];
        for (int i = 0; i < chicks.count; i++) {
            CCPBirdObject *bird = [[chicks objectAtIndex:i] mutableCopy];
            int gene1 = [chickType[0] intValue];
            int gene2 = [chickType [1] intValue];
            [bird.olive setGene1:gene1];
            [bird.olive setGene2:gene2];
            
            float total = (float)([oliveGenes countForObject:chickType] / 4.0);
            float base = bird.frequencyIndex;
            
            bird.frequencyIndex = base * total;
            
            [chicksToChange addObject:bird];
        }
        [tempArray addObject:chicksToChange];
    }
    
    newChicks = [[NSMutableArray alloc] init];
    for (NSMutableArray *array in tempArray) {
        [newChicks addObjectsFromArray:array];
    }
    
    chicks = [newChicks copy];
    
    [newChicks removeAllObjects];
    [tempArray removeAllObjects];
    
    //******************
    //parblue
    //******************
    
    NSCountedSet *parblueGenes = [self recombineAutosomalMale:male.parblue female:female.parblue];
    
    for (NSArray *chickType in parblueGenes) {
        NSMutableArray *chicksToChange = [[NSMutableArray alloc] init];
        for (int i = 0; i < chicks.count; i++) {
            CCPBirdObject *bird = [[chicks objectAtIndex:i] mutableCopy];
            int gene1 = [chickType[0] intValue];
            int gene2 = [chickType [1] intValue];
            [bird.parblue setGene1:gene1];
            [bird.parblue setGene2:gene2];
            
            float total = (float)([parblueGenes countForObject:chickType] / 4.0);
            
            float base = bird.frequencyIndex;
            
            bird.frequencyIndex = base * total;
            
            [chicksToChange addObject:bird];
        }
        [tempArray addObject:chicksToChange];
    }
    
    newChicks = [[NSMutableArray alloc] init];
    for (NSMutableArray *array in tempArray) {
        [newChicks addObjectsFromArray:array];
    }
    
    chicks = [newChicks copy];
    
    [newChicks removeAllObjects];
    [tempArray removeAllObjects];
    
    
    //******************
    //Dominant silver
    //******************
    
    NSCountedSet *domSilverGenes = [self recombineAutosomalMale:male.domSilver female:female.domSilver];
    
    for (NSArray *chickType in domSilverGenes) {
        NSMutableArray *chicksToChange = [[NSMutableArray alloc] init];
        for (int i = 0; i < chicks.count; i++) {
            CCPBirdObject *bird = [[chicks objectAtIndex:i] mutableCopy];
            int gene1 = [chickType[0] intValue];
            int gene2 = [chickType [1] intValue];
            [bird.domSilver setGene1:gene1];
            [bird.domSilver setGene2:gene2];
            
            float total = (float)([domSilverGenes countForObject:chickType] / 4.0);
            
            float base = bird.frequencyIndex;
            
            bird.frequencyIndex = base * total;
            
            [chicksToChange addObject:bird];
        }
        [tempArray addObject:chicksToChange];
    }
    
    newChicks = [[NSMutableArray alloc] init];
    for (NSMutableArray *array in tempArray) {
        [newChicks addObjectsFromArray:array];
    }
    
    chicks = [newChicks copy];
    
    [newChicks removeAllObjects];
    [tempArray removeAllObjects];
    
    
    //******************
    //Dominant yellowcheek
    //******************
    
    NSCountedSet *domYellowcheekGenes = [self recombineAutosomalMale:male.domYellowcheek female:female.domYellowcheek];
    
    for (NSArray *chickType in domYellowcheekGenes) {
        NSMutableArray *chicksToChange = [[NSMutableArray alloc] init];
        for (int i = 0; i < chicks.count; i++) {
            CCPBirdObject *bird = [[chicks objectAtIndex:i] mutableCopy];
            int gene1 = [chickType[0] intValue];
            int gene2 = [chickType [1] intValue];
            [bird.domYellowcheek setGene1:gene1];
            [bird.domYellowcheek setGene2:gene2];
            
            float total = (float)([domYellowcheekGenes countForObject:chickType] / 4.0);
            
            float base = bird.frequencyIndex;
            
            bird.frequencyIndex = base * total;
            
            [chicksToChange addObject:bird];
        }
        [tempArray addObject:chicksToChange];
    }
    
    newChicks = [[NSMutableArray alloc] init];
    for (NSMutableArray *array in tempArray) {
        [newChicks addObjectsFromArray:array];
    }
    
    chicks = [newChicks copy];
    
    [newChicks removeAllObjects];
    [tempArray removeAllObjects];
    
    
    //***************
    //sex-linked mutations
    //***************
    
    //duplicate offspring list into male and female chicks
    
    NSMutableArray *femaleChicks = [[NSMutableArray alloc] initWithArray:chicks copyItems:YES];
    NSMutableArray *maleChicks = [[NSMutableArray alloc] initWithArray:chicks copyItems:YES];
    
    for (CCPBirdObject *femaleBird in femaleChicks) {
        [femaleBird resetChickToFemale];
    }
    
    //all the SL mutations on each gene1 and each gene2 get passed on together
    //create arrays that group the gene1 and gene2 values for each parent bird
    
    NSMutableArray *gene1List = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:male.cinnamon.gene1], [NSNumber numberWithInt:male.lutino.gene1],[NSNumber numberWithInt:male.pearl.gene1],[NSNumber numberWithInt:male.SLYellowcheek.gene1], nil];
    NSMutableArray *gene2List = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:male.cinnamon.gene2], [NSNumber numberWithInt:male.lutino.gene2],[NSNumber numberWithInt:male.pearl.gene2],[NSNumber numberWithInt:male.SLYellowcheek.gene2], nil];
    NSMutableArray *femaleGene1List = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:female.cinnamon.gene1], [NSNumber numberWithInt:female.lutino.gene1],[NSNumber numberWithInt:female.pearl.gene1],[NSNumber numberWithInt:female.SLYellowcheek.gene1], nil];
    NSMutableArray *femaleGene2List = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:female.cinnamon.gene2], [NSNumber numberWithInt:female.lutino.gene2],[NSNumber numberWithInt:female.pearl.gene2],[NSNumber numberWithInt:female.SLYellowcheek.gene2], nil];
    

    
    [self resetSexLinkedMutations:gene1List forBirds:maleChicks andGene:1];
    
    [self resetSexLinkedMutations:femaleGene1List forBirds:maleChicks andGene:2];
    
    [self resetSexLinkedMutations:gene1List forBirds:femaleChicks andGene:1];
    
    [self resetSexLinkedMutations:femaleGene2List forBirds:femaleChicks andGene:2];
    
    NSMutableArray *crossoverMales = [[NSMutableArray alloc] init];
    NSMutableArray *crossoverFemales = [[NSMutableArray alloc] init];
    
    //duplicate chick arrays if male's X chromosomes carry different mutations
    //and recalculate frequency indices
    if (![gene1List isEqualToArray:gene2List]) {
        NSMutableArray *tempMales = [[NSMutableArray alloc] initWithArray:maleChicks copyItems:YES];
        
        NSMutableArray *tempFemales = [[NSMutableArray alloc] initWithArray:femaleChicks copyItems:YES];
        
        //do a check to see if male is split to more than one sl mutation
        int crossoverIndex = 0;
        for (int i = 0; i < [gene1List count]; i++) {
            if (gene1List[i] != gene2List[i]) {
                crossoverIndex++;
            }
        }
        
        //recombine male sl genes if crossoverIndex is greater than 1 (meaning he is split to more than 1 SL mutation)
        if (crossoverIndex > 1) {
        
            NSSet *allCrossoverCombosSet = [self recombineMaleSLGene1:gene1List andGene2:gene2List];
            NSMutableArray *tempCrossoverMaleArray = [[NSMutableArray alloc] init];
            NSMutableArray *tempCrossoverFemaleArray = [[NSMutableArray alloc] init];
            
            for (NSMutableArray *chickType in allCrossoverCombosSet) { //for each SL crossover type
                NSMutableArray *maleChicksToChange = [[NSMutableArray alloc] initWithArray:maleChicks copyItems:YES]; //copy current results list for each gender
                NSMutableArray *femaleChicksToChange = [[NSMutableArray alloc] initWithArray:femaleChicks copyItems:YES];
                
                [self resetSexLinkedMutations:chickType forBirds:maleChicksToChange andGene:1]; //change gene 1 of male chicks
                [self resetSexLinkedMutations:femaleGene1List forBirds:maleChicksToChange andGene:2]; //change gene 2 of male chicks
                [self resetSexLinkedMutations:chickType forBirds:femaleChicksToChange andGene:1]; //change gene 1 of female chicks
                
                [tempCrossoverMaleArray addObject:maleChicksToChange];
                [tempCrossoverFemaleArray addObject:femaleChicksToChange];
                
            }
            
            //take resulting arrays of crossover chicks and combine them into single crossover array
            for (NSMutableArray *array in tempCrossoverMaleArray) {
                [crossoverMales addObjectsFromArray:array];
            }
            
            [tempCrossoverMaleArray removeAllObjects];
            
            for (NSMutableArray *array in tempCrossoverFemaleArray) {
                [crossoverFemales addObjectsFromArray:array];
            }
            
            [tempCrossoverFemaleArray removeAllObjects];
        
        }
        
        
        
        [self resetSexLinkedMutations:gene2List forBirds:tempMales andGene:1];
        [self resetSexLinkedMutations:gene2List forBirds:tempFemales andGene:1];
        for (CCPBirdObject *bird in tempFemales) {
            bird.frequencyIndex /= 2;
        }
        
        for (CCPBirdObject *bird in femaleChicks) {
            bird.frequencyIndex /= 2;
        }
        
        for (CCPBirdObject *bird in tempMales) {
            bird.frequencyIndex /= 2;
        }
        
        for (CCPBirdObject *bird in maleChicks) {
            bird.frequencyIndex /= 2;
        }
        
        
        NSMutableArray *newMaleChicks = [NSMutableArray arrayWithArray:maleChicks];
        [newMaleChicks addObjectsFromArray:tempMales];
        maleChicks = [newMaleChicks copy];
        
        NSMutableArray *newFemaleChicks = [NSMutableArray arrayWithArray:femaleChicks];
        [newFemaleChicks addObjectsFromArray:tempFemales];
        femaleChicks = [newFemaleChicks copy];
        
        [newMaleChicks removeAllObjects];
        [newFemaleChicks removeAllObjects];
        
        [tempMales removeAllObjects];
        [tempFemales removeAllObjects];
        
        
        
    }
    
    NSMutableArray *results = [[NSMutableArray alloc] initWithObjects:maleChicks, femaleChicks, crossoverMales, crossoverFemales, nil];
    
    return results;
}

+(NSCountedSet *)recombineAutosomalMale:(CCPMutation *)male female:(CCPMutation *)female
{
    //get all chicks by recombining
    //puts largest number first (1 = mutation is present, 0== normal gene)
    NSArray *chick1 = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:MAX(male.gene1, female.gene1)], [NSNumber numberWithInt:MIN(male.gene1, female.gene1)], nil];
    NSArray *chick2 = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:MAX(male.gene1, female.gene2)], [NSNumber numberWithInt:MIN(male.gene1, female.gene2)], nil];
    NSArray *chick3 = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:MAX(male.gene2, female.gene1)], [NSNumber numberWithInt:MIN(male.gene2, female.gene1)], nil];
    NSArray *chick4 = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:MAX(male.gene2, female.gene2)], [NSNumber numberWithInt:MIN(male.gene2, female.gene2)], nil];
    
    NSMutableArray *allchicks = [[NSMutableArray alloc] initWithObjects:chick1, chick2, chick3, chick4, nil];
    
    NSCountedSet *countedChicks = [[NSCountedSet alloc] initWithArray:allchicks];
    
    return countedChicks;
}

+(NSCountedSet *)recombineSexlinkedMale:(CCPMutation *)male female:(CCPMutation *)female
{
    //get all chicks by recombining
    // if bird is male, puts largest number first (1 = mutation is present, 0== normal gene)
    //if bird is female, puts largest number last (2 = female Z chromosome, can't carry mutation)
    NSArray *chick1 = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:MAX(male.gene1, female.gene1)], [NSNumber numberWithInt:MIN(male.gene1, female.gene1)], nil];
    NSArray *chick2 = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:MAX(male.gene2, female.gene1)], [NSNumber numberWithInt:MIN(male.gene2, female.gene1)], nil];
    
    NSArray *chick3 = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:MIN(male.gene1, female.gene2)], [NSNumber numberWithInt:MAX(male.gene1, female.gene2)], nil];
    NSArray *chick4 = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:MIN(male.gene2, female.gene2)], [NSNumber numberWithInt:MAX(male.gene2, female.gene2)], nil];
    
    NSMutableArray *allchicks = [[NSMutableArray alloc] initWithObjects:chick1, chick2, chick3, chick4, nil];
    
    NSCountedSet *countedChicks = [[NSCountedSet alloc] initWithArray:allchicks];
    
    NSLog(@"%@", countedChicks);
    return countedChicks;
}


//recombine sex-linked mutations to get crossover possibilities

//Use the recombine fuction for all sl mutations, add to a separate list

//remove the combos that match non-crossover results


+(NSSet *)recombineMaleSLGene1:(NSMutableArray *)geneList1 andGene2:(NSMutableArray *)geneList2
{
    NSMutableArray *allSLCombos = [[NSMutableArray alloc] initWithObjects:geneList1, nil];
    NSMutableArray *tempCombosList = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [geneList1 count]; i++) { //for each gene pair
        
        
        for (NSMutableArray *currentGene in allSLCombos) { //in each unique gene combination

            NSMutableArray *currentGeneCopy = [NSMutableArray arrayWithArray:currentGene];
            
            NSNumber *tempGene1 = [geneList1 objectAtIndex:i];
            NSNumber *tempGene2 = [geneList2 objectAtIndex:i];
            if (!(tempGene1 == tempGene2)) { //compare values of mutation pairs, swap if they are different
                
                [currentGeneCopy replaceObjectAtIndex:i withObject:tempGene2];
                
                [tempCombosList addObject:currentGeneCopy];
          
            } else {
                continue;
            }
        }
        
        for (NSMutableArray *array in tempCombosList) {
            [allSLCombos addObject:array];
        }
        [tempCombosList removeAllObjects];

        
    }

    
    NSMutableSet *finalComboSet = [[NSCountedSet alloc] initWithArray:allSLCombos];
    
    //remove genes matching the original two
    [finalComboSet removeObject:geneList1];
    [finalComboSet removeObject:geneList2];
    
    return finalComboSet;
}
 
 

+(void)resetSexLinkedMutations:(NSMutableArray *)mutations forBirds:(NSMutableArray *)birds andGene:(int)gene
{
    
    for (CCPBirdObject *bird in birds) {
        if (gene == 1) {
            bird.cinnamon.gene1 = [mutations[0] intValue];
            bird.lutino.gene1 = [mutations[1] intValue];
            bird.pearl.gene1 = [mutations[2] intValue];
            bird.SLYellowcheek.gene1 = [mutations[3] intValue];
        } else if (gene == 2) {
            bird.cinnamon.gene2 = [mutations[0] intValue];
            bird.lutino.gene2 = [mutations[1] intValue];
            bird.pearl.gene2 = [mutations[2] intValue];
            bird.SLYellowcheek.gene2 = [mutations[3] intValue];
        }
    }

}

@end
