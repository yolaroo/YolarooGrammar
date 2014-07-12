//
//  MainFoundation+SuperSearchForExtraObjects.m
//  YolarooGrammar
//
//  Created by MGM on 5/15/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+SuperSearchForExtraObjects.h"

@implementation MainFoundation (SuperSearchForExtraObjects)

#define DK 2
#define LOG if(DK == 1)


- (void) deleteAllExtraData: (NSManagedObjectContext*)newContext
{
    NSArray* firstWordArray = [self completeCharacterPropertiesList:newContext];
    for (NSManagedObject* NMO in firstWordArray) {
        [newContext deleteObject:NMO];
    }
    NSArray* secondWordArray = [self completeSentencePropertyList:newContext];
    for (NSManagedObject* NMO in secondWordArray) {
        [newContext deleteObject:NMO];
    }
    
    NSArray* thirdWordArray = [self completeExtraStoryListForDelete:newContext];
    for (NSManagedObject* NMO in thirdWordArray) {
        [newContext deleteObject:NMO];
    }
    NSArray* fourthWordArray = [self completeCharacterListForDelete:newContext];
    for (NSManagedObject* NMO in fourthWordArray) {
        [newContext deleteObject:NMO];
    }
    NSArray* fifthArray = [self newWordDelete:newContext];
    for (NSManagedObject* NMO in fifthArray) {
        [newContext deleteObject:NMO];
    }
    NSArray* sixthArray = [self newGrammarWordDelete:newContext];
    for (NSManagedObject* NMO in sixthArray) {
        [newContext deleteObject:NMO];
    }
    
    [self saveData:newContext];
}

//
////
//

- (NSArray*) newWordDelete: (NSManagedObjectContext*) newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Word" inManagedObjectContext:newContext];
    
    NSPredicate *predicateUser  = [NSPredicate predicateWithFormat:@"whatSemanticType.name = %@", @"new"];
    NSArray *subPredicates = [NSArray arrayWithObjects:predicateUser, nil];
    NSPredicate *andPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
    fetchRequest.predicate = andPredicate;
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

- (NSArray*) newGrammarWordDelete: (NSManagedObjectContext*) newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"GrammarWord" inManagedObjectContext:newContext];
    
    NSPredicate *predicateUser  = [NSPredicate predicateWithFormat:@"isUserGenerated = %@",[NSNumber numberWithBool:true]];
    NSArray *subPredicates = [NSArray arrayWithObjects:predicateUser, nil];
    NSPredicate *andPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
    fetchRequest.predicate = andPredicate;
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

//
////
//

- (NSArray*) completeExtraStoryListForDelete: (NSManagedObjectContext*) newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Story" inManagedObjectContext:newContext];
        
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    //NSLog(@"VerbList Fetch Count - %lu", (unsigned long)[fetchedRecords count]);
    return fetchedRecords;
}

- (NSArray*) completeCharacterListForDelete: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Character" inManagedObjectContext:newContext];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

//
////
//

- (NSArray*) completeSentencePropertyList: (NSManagedObjectContext*) context
{
    NSMutableArray* completeArray = [[NSMutableArray alloc] init];
    [completeArray addObjectsFromArray:[self completeCopulaList:context]];
    [completeArray addObjectsFromArray:[self completeSententialVerbList:context]];
    [completeArray addObjectsFromArray:[self completeSubjectPhraseList:context]];
    [completeArray addObjectsFromArray:[self completeNounPropertiesList:context]];
    [completeArray addObjectsFromArray:[self completeSententialAdjectiveList:context]];
    
    [completeArray addObjectsFromArray:[self completeDeterminerList:context]];
    [completeArray addObjectsFromArray:[self completePrepositionalPhraseList:context]];
    [completeArray addObjectsFromArray:[self completeSentenceList:context]];
    [completeArray addObjectsFromArray:[self completeEventList:context]];
    [completeArray addObjectsFromArray:[self completeNationalityList:context]];
    return [completeArray copy];
}

//
////
//


- (NSArray*) completeCharacterPropertiesList: (NSManagedObjectContext*)context
{
    NSMutableArray* completeArray = [[NSMutableArray alloc] init];
    [completeArray addObjectsFromArray:[self completeGenderList:context]];
    [completeArray addObjectsFromArray:[self completeBirthdayList:context]];
    [completeArray addObjectsFromArray:[self completeDispositionList:context]];
    [completeArray addObjectsFromArray:[self completeBodyPartList:context]];
    [completeArray addObjectsFromArray:[self completeLocationList:context]];
    [completeArray addObjectsFromArray:[self completeHomeList:context]];
    [completeArray addObjectsFromArray:[self completeEyeColorList:context]];
    [completeArray addObjectsFromArray:[self completeJobList:context]];
    [completeArray addObjectsFromArray:[self completeGoalList:context]];
    [completeArray addObjectsFromArray:[self completeHeightList:context]];
    [completeArray addObjectsFromArray:[self completeWeightList:context]];
    [completeArray addObjectsFromArray:[self completeSpecieList:context]];
    [completeArray addObjectsFromArray:[self completeAgeList:context]];

    return [completeArray copy];
}

- (NSArray*) completeStoryPropertiesList: (NSManagedObjectContext*)context
{
    NSArray* array01 = [self completeCopulaList:context];
    NSArray* array02 = [self completeSententialVerbList:context];
    NSArray* array03 = [self completeSubjectPhraseList:context];
    NSArray* array04 = [self completeNounPropertiesList:context];
    NSArray* array05 = [self completeSententialAdjectiveList:context];
    NSArray* array06 = [self completeDeterminerList:context];
    NSArray* array07 = [self completePrepositionalPhraseList:context];
    NSArray* array08 = [self completeSentenceList:context];
    NSArray* array09 = [self completeNationalityList:context];
    NSArray* array10 = [self completeEventList:context];

    LOG NSLog(@"--1. copula - %lu --",(unsigned long)[array01 count]);
    LOG NSLog(@"--2. verb - %lu --",(unsigned long)[array02 count]);
    LOG NSLog(@"--3. subject - %lu --",(unsigned long)[array03 count]);
    LOG NSLog(@"--4. noun property - %lu --",(unsigned long)[array04 count]);
    LOG NSLog(@"--5. adjective - %lu --",(unsigned long)[array05 count]);
    LOG NSLog(@"--6. determiner - %lu --",(unsigned long)[array06 count]);
    LOG NSLog(@"--7. preposition - %lu --",(unsigned long)[array07 count]);
    LOG NSLog(@"--8. sentence - %lu --",(unsigned long)[array08 count]);

    NSMutableArray* completeArray = [[NSMutableArray alloc] init];

    LOG NSLog(@"-- PL START --");
    [completeArray addObject:@"--Copula"];
    for (Copula* wrd in array01) {
        if ([wrd.infinitive length]){
            [completeArray addObject:wrd.infinitive];
        }
    }
    LOG NSLog(@"-- PL 01 --");
    [completeArray addObject:@"-"];
    [completeArray addObject:@"--SententialVerb"];
    for (SententialVerb* wrd in array02) {
        if ([wrd.theVerb length]){
            [completeArray addObject:wrd.theVerb];
        }
    }
    LOG NSLog(@"-- PL 02 --");
    [completeArray addObject:@"-"];
    [completeArray addObject:@"--SubjectPhrase"];
    for (SubjectPhrase* wrd in array03) {
        if ([wrd.theWord length]){
            [completeArray addObject:wrd.theWord];
        }
    }
    LOG NSLog(@"-- PL 03 --");
    [completeArray addObject:@"-"];
    [completeArray addObject:@"--NounProperties"];
    for (NounProperties* wrd in array04) {
        if ([wrd.name length]){
            [completeArray addObject:wrd.name];
        }
    }
    LOG NSLog(@"-- PL 04 --");
    [completeArray addObject:@"-"];
    [completeArray addObject:@"--SententialAdjective"];
    for (SententialAdjective* wrd in array05) {
        if ([wrd.theAdjective length]){
            [completeArray addObject:wrd.theAdjective];
        }
    }
    LOG NSLog(@"-- PL 05 --");
    [completeArray addObject:@"-"];
    [completeArray addObject:@"--Determiner"];
    for (Determiner* wrd in array06) {
        if ([wrd.theWord length]){
            [completeArray addObject:wrd.theDeterminer];
        }
    }
    LOG NSLog(@"-- PL 06 --");
    [completeArray addObject:@"-"];
    [completeArray addObject:@"--PrepositionalPhrase"];
    for (PrepositionalPhrase* wrd in array07) {
        if ([wrd.theWord length]){
            [completeArray addObject:wrd.theWord];
        }
    }
    LOG NSLog(@"-- PL 07 --");
    [completeArray addObject:@"-"];
    [completeArray addObject:@"--Sentence"];
    for (Sentence* wrd in array08) {
        if ([wrd.theSentence length]){
            [completeArray addObject:wrd.theSentence];
        }
    }
    LOG NSLog(@"-- PL 08 --");
    [completeArray addObject:@"-"];
    [completeArray addObject:@"--Nationality"];
    for (Nationality* wrd in array09) {
        if ([wrd.name length]){
            [completeArray addObject:wrd.name];
        }
    }
    LOG NSLog(@"-- PL 09 --");
    [completeArray addObject:@"-"];
    [completeArray addObject:@"--Event"];
    for (Event* wrd in array10) {
        if ([wrd.object length]){
            [completeArray addObject:wrd.object];
        }
    }
    LOG NSLog(@"-- PL DONE --");

    return [completeArray copy];
}

//
//
////////
//
////////
//
//

- (NSArray*) completeEventList: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:newContext];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

- (NSArray*) completeNationalityList: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Nationality" inManagedObjectContext:newContext];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}




//
//
////////
//
////////
//
//

- (NSArray*) completeAgeList: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Age" inManagedObjectContext:newContext];
        
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

- (NSArray*) completeGenderList: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Gender" inManagedObjectContext:newContext];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

- (NSArray*) completeBirthdayList: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Birthday" inManagedObjectContext:newContext];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

- (NSArray*) completeDispositionList: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Disposition" inManagedObjectContext:newContext];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

- (NSArray*) completeBodyPartList: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"BodyPart" inManagedObjectContext:newContext];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

- (NSArray*) completeLocationList: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Location" inManagedObjectContext:newContext];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

- (NSArray*) completeHomeList: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Home" inManagedObjectContext:newContext];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

- (NSArray*) completeEyeColorList: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"EyeColor" inManagedObjectContext:newContext];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

- (NSArray*) completeHairColorList: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"HairColor" inManagedObjectContext:newContext];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}


- (NSArray*) completeJobList: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"BodyPart" inManagedObjectContext:newContext];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

- (NSArray*) completeGoalList: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Goal" inManagedObjectContext:newContext];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

- (NSArray*) completeHeightList: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Height" inManagedObjectContext:newContext];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

- (NSArray*) completeWeightList: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Weight" inManagedObjectContext:newContext];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

- (NSArray*) completeSpecieList: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Specie" inManagedObjectContext:newContext];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

//
//
////////
//
////////
//
//

- (NSArray*) completeCopulaList: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Copula" inManagedObjectContext:newContext];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

- (NSArray*) completeSententialVerbList: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"SententialVerb" inManagedObjectContext:newContext];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

- (NSArray*) completeSubjectPhraseList: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"SubjectPhrase" inManagedObjectContext:newContext];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

- (NSArray*) completeNounPropertiesList: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"NounProperties" inManagedObjectContext:newContext];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

- (NSArray*) completeSententialAdjectiveList: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"SententialAdjective" inManagedObjectContext:newContext];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

- (NSArray*) completeDeterminerList: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Determiner" inManagedObjectContext:newContext];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

- (NSArray*) completePrepositionalPhraseList: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"PrepositionalPhrase" inManagedObjectContext:newContext];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

- (NSArray*) completeSentenceList: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Sentence" inManagedObjectContext:newContext];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}




@end
