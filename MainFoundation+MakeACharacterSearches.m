//
//  MainFoundation+MakeACharacterSearches.m
//  YolarooGrammar
//
//  Created by MGM on 5/28/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+MakeACharacterSearches.h"

@implementation MainFoundation (MakeACharacterSearches)

//
////
//

- (NSArray*) goalInfinitiveList
{
    return @[
             @"to learn to play",
             @"to read",
             @"to go to",
             @"to be",
             ];
}

- (NSArray*) goalCategoryListForSemanticSearch
{
    return @[
             @"instruments",
             @"books",
             @"landmarks",
             @"jobs",
             ];
}


- (NSArray*) eventTypeList
{
    return @[
             @"read",
             @"watch",
             @"drink",
             @"fly",
             @"drive",
             @"eat",
             @"walk to",
             @"drive to",
             @"fly to",
             @"travel to"
             ];
}

- (NSArray*) eventCategoryListForSemanticSearch
{
    return @[
             @"books",
             @"movies",
             @"drinks",
             @"aerial vehicles",
             @"vehicles",
             @"food",
             @"locations",
             @"locations",
             @"countries",
             @"landmarks",
             ];
}

- (NSArray*) eventObjectList
{
 return @ [
           @"book",
           @"movie",
           @"something",
           @"something",
           @"something",
           @"food",
           @"somewhere",
           @"location",
           @"somewhere",
           @"place",
           ];
}

//
////
//

- (NSArray*) monthArray {
    return @[@"january",@"february",@"march",@"april",@"may",@"june",@"july",@"august",@"september",@"october",@"november",@"december"];
}

- (NSDate*) dateFromMonth: (NSInteger)monthNumber {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMMM"];
    return [dateFormatter dateFromString:[[self monthArray] objectAtIndex:monthNumber]];
}

- (NSArray*) dayListForEachMonth : (NSDate*) monthDate {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange rangeOfDaysThisMonth = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:monthDate];
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSEraCalendarUnit) fromDate:monthDate];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM d"];

    NSMutableArray *datesThisMonth = [NSMutableArray array];
    for (NSInteger i = rangeOfDaysThisMonth.location; i < NSMaxRange(rangeOfDaysThisMonth); ++i) {
        [components setDay:i];
        NSDate *dayInMonth = [calendar dateFromComponents:components];
        [datesThisMonth addObject:[formatter stringFromDate:dayInMonth]];
        
    }
    return datesThisMonth;
}

//
////
//

- (NSArray*) DateMACS
{
    NSMutableArray * completeDateArray = [[NSMutableArray alloc]init];
    NSArray*myMonthArray = [self monthArray];
    for (int i = 0; i < [myMonthArray count]; i++) {
        NSDate* myDate = [self dateFromMonth:i];
        NSArray*daysInMonth = [self dayListForEachMonth:myDate];
        
        for (NSInteger j = 0; j < [daysInMonth count]; j++) {
            //NSString*xxx = [NSString stringWithFormat:@"%@ %d%@",[daysInMonth objectAtIndex:j],j+1,[self addSuffixToNumber:j+1]  ];
            [completeDateArray addObject:[daysInMonth objectAtIndex:j] ];
        }
    }
    return [completeDateArray copy];
}

- (NSArray*) AgeMACS
{
    NSMutableArray * numbArray = [[NSMutableArray alloc]init];
    for (int i = 1; i <= 80; i++) {
        [numbArray addObject:[NSString stringWithFormat:@"%d years old",i]];
    }
    return [numbArray copy];
}

- (NSArray*) weightMACS
{
    NSMutableArray * numbArray = [[NSMutableArray alloc]init];
    for (int i = 1; i <= 170; i=i+5) {
        NSInteger conversion = (long)i*1.5085509;
        [numbArray addObject:[NSString stringWithFormat:@"%dkg %ldlbs",i,(long)conversion]];
    }
    return [numbArray copy];
}

- (NSArray*) heightMACS
{
    NSMutableArray * numbArray = [[NSMutableArray alloc]init];
    for (int i = 5; i <= 300; i=i+5) {
        double total = (double)i/2.54;
        NSInteger feet = (long)total / 12;
        NSInteger inches = (long)total % 12;
        [numbArray addObject:[NSString stringWithFormat:@"%dcm %ld-foot-%ld",i,(long)feet,(long)inches]];
    }
    return [numbArray copy];
}

- (NSArray*) dispositionListMACS:(NSManagedObjectContext*) context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"AdjectiveSemanticType" inManagedObjectContext:context];
    
    NSArray* characterArray = @[@"common copular",
                                @"positive",
                                @"ability positive",
                                @"social",
                                @"psychological positive",
                                @"negative"];
    
    NSMutableArray *subPredicates = [[NSMutableArray alloc]init];
    
    for (NSString* STR in characterArray) {
        [subPredicates addObject:[NSPredicate predicateWithFormat:@"name = %@",STR]];
    }
    
    NSPredicate * orPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:[subPredicates copy]];
    fetchRequest.predicate = orPredicate;
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];

    NSError* error;
    NSArray *fetchedRecords = [context executeFetchRequest:fetchRequest error:&error];
    
    return fetchedRecords;
}

- (NSArray*) descriptionListMACS:(NSManagedObjectContext*) context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"AdjectiveSemanticType" inManagedObjectContext:context];
    
    NSArray* characterArray = @[@"looks positive",
                                @"comparison measurement"];
    
    NSMutableArray *subPredicates = [[NSMutableArray alloc]init];
    
    for (NSString* STR in characterArray) {
        [subPredicates addObject:[NSPredicate predicateWithFormat:@"name = %@",STR]];
    }
    
    NSPredicate * orPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:[subPredicates copy]];
    fetchRequest.predicate = orPredicate;
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError* error;
    NSArray *fetchedRecords = [context executeFetchRequest:fetchRequest error:&error];
    
    return fetchedRecords;
}

- (NSArray*) characterTypesMACS: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"SemanticType" inManagedObjectContext:newContext];

    NSArray* characterArray = @[@"species",
                                @"shellfish",
                                @"amphibians",
                                @"reptiles",
                                @"aquatic animals",
                                @"aquatic mammals",
                                @"birds",
                                @"bugs",
                                @"worms",
                                @"dinosaurs",
                                @"dogs",
                                @"snakes",
                                @"mythical creatures"];
    
    NSMutableArray *subPredicates = [[NSMutableArray alloc]init];

    for (NSString* STR in characterArray) {
        [subPredicates addObject:[NSPredicate predicateWithFormat:@"name = %@",STR]];
    }
    
    NSPredicate * orPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:[subPredicates copy]];
    fetchRequest.predicate = orPredicate;
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

- (NSArray*) clothesListMACS: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"SemanticType" inManagedObjectContext:newContext];
    
    NSArray* clothesArray = @[  @"clothes outer wear",
                                @"clothes footwear",
                                @"clothes women's footwear",
                                @"clothes women's wear",
                                @"clothes men's wear",
                                @"clothes",
                                @"clothes tops",
                                @"clothes bottoms",
                                @"clothes accessories",
                                @"clothes undergarments",
                                @"luxury goods"];
    
    NSMutableArray *subPredicates = [[NSMutableArray alloc]init];
    
    for (NSString* STR in clothesArray) {
        [subPredicates addObject:[NSPredicate predicateWithFormat:@"name = %@",STR]];
    }
    
    NSPredicate * orPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:[subPredicates copy]];
    fetchRequest.predicate = orPredicate;
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

- (NSArray*) foodListMACS: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"SemanticType" inManagedObjectContext:newContext];
    
    NSArray* foodArray = @[ @"food",
                            @"fruits",
                            @"meat",
                            @"sauces",
                            @"desserts",
                            @"fruits",
                            @"beans",
                            @"berries",
                            @"grains",
                            @"nuts",
                            @"vegetables",
                            @"root vegetables",
                            @"gourds"];
    
    NSMutableArray *subPredicates = [[NSMutableArray alloc]init];
    
    for (NSString* STR in foodArray) {
        [subPredicates addObject:[NSPredicate predicateWithFormat:@"name = %@",STR]];
    }
    
    NSPredicate * orPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:[subPredicates copy]];
    fetchRequest.predicate = orPredicate;
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

- (NSArray*) dislikeListMACS: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"SemanticType" inManagedObjectContext:newContext];
    
    NSArray* dislikesArray = @[ @"food",
                            @"fruits",
                            @"sauces",
                            @"desserts",
                            @"fruits",
                            @"beans",
                            @"berries",
                            @"grains",
                            @"nuts",
                            @"vegetables",
                            @"root vegetables",
                            @"gourds",
                            @"pests",
                            @"species",
                            @"shellfish",
                            @"amphibians",
                            @"reptiles",
                            @"aquatic animals",
                            @"aquatic mammals",
                            @"birds",
                            @"bugs",
                            @"worms",
                            @"dinosaurs",
                            @"dogs",
                            @"snakes",
                            @"mythical creatures",
                            @"clothes outer wear",
                            @"clothes footwear",
                            @"clothes women's footwear",
                            @"clothes women's wear",
                            @"clothes men's wear",
                            @"clothes",
                            @"clothes tops",
                            @"clothes bottoms",
                            @"clothes accessories",
                            @"clothes undergarments",
                            @"luxury goods",
                            @"natural disasters",
                            @"sports",
                            @"natural locations",
                            @"days of the week",
                            @"electronics",
                            @"meat",
                            ];
    
    NSMutableArray *subPredicates = [[NSMutableArray alloc]init];
    
    for (NSString* STR in dislikesArray) {
        [subPredicates addObject:[NSPredicate predicateWithFormat:@"name = %@",STR]];
    }
    
    NSPredicate * orPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:[subPredicates copy]];
    fetchRequest.predicate = orPredicate;
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

- (NSArray*) locationListMACS: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"SemanticType" inManagedObjectContext:newContext];
    
    NSArray* locationsArray = @[ @"countries",
                            @"landmarks",
                            @"natural locations",
                            @"locations",
                            @"rooms",
                            @"planets",
                            @"transportation locations",
                            ];
    
    NSMutableArray *subPredicates = [[NSMutableArray alloc]init];
    
    for (NSString* STR in locationsArray) {
        [subPredicates addObject:[NSPredicate predicateWithFormat:@"name = %@",STR]];
    }
    
    NSPredicate * orPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:[subPredicates copy]];
    fetchRequest.predicate = orPredicate;
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

//
////
//

- (NSArray*) wordListMACS:(WordValue)myWordValue withContext: (NSManagedObjectContext*) context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Word" inManagedObjectContext:context];
    
    NSPredicate *predicateSemanticType  = [NSPredicate predicateWithFormat:@"whatSemanticType.name = %@", [[self foundationWordListArray]objectAtIndex:myWordValue]];
    
    NSArray *subPredicates = [NSArray arrayWithObjects:predicateSemanticType, nil];
    NSPredicate *andPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
    fetchRequest.predicate = andPredicate;
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];

    
    NSError* error;
    NSArray *fetchedRecords = [context executeFetchRequest:fetchRequest error:&error];
    
    return fetchedRecords;
}

- (NSArray*) adjectListMACS:(AdjectiveValue)myAdjectiveValue withContext: (NSManagedObjectContext*) context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"AdjectiveClass" inManagedObjectContext:context];
    NSPredicate *predicateSemanticType  = [NSPredicate predicateWithFormat:@"whatSemanticType.name = %@", [[self foundationAdjectiveListArray]objectAtIndex:myAdjectiveValue]];
    
    NSArray *subPredicates = [NSArray arrayWithObjects:predicateSemanticType, nil];
    NSPredicate *andPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
    fetchRequest.predicate = andPredicate;
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError* error;
    NSArray *fetchedRecords = [context executeFetchRequest:fetchRequest error:&error];
    
    return fetchedRecords;
}

@end
