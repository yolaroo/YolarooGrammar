//
//  MainFoundation+EventOptionsDataForCharacter.m
//  YolarooGrammar
//
//  Created by MGM on 5/25/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+EventOptionsDataForCharacter.h"

#import "Event+Create.h"

@implementation MainFoundation (EventOptionsDataForCharacter)

- (Event*) myEventReturn: (EventDefine)value withTitle: (NSString*)title withContext: (NSManagedObjectContext*) context
{
    return [Event eventWithTitle:title withArray:[self eventData:[self eventReturn:value] withContext:context] withContext:context];
}

//
//// data
//

- (NSArray*) eventData: (NSArray*)data withContext: (NSManagedObjectContext*) context
{
    NSMutableArray* myArray = [[NSMutableArray alloc]initWithArray:data];
    NSString* newString = [self randomWordFromSemanticTypeForEvent:[data lastObject] withContext:context];
    [myArray removeLastObject];
    [myArray addObject:newString];
    return [myArray copy];
}

- (NSArray*) eventReturn: (EventDefine)value
{
    return [[self eventArrayList] objectAtIndex:value];
}

- (NSArray*) eventArrayList
{
    NSArray* array01 = @[@"read",    @"book",        @"books"];
    NSArray* array02 = @[@"watch",   @"movie",       @"movies"];
    NSArray* array03 = @[@"drink",   @"something",   @"drinks"];
    NSArray* array04 = @[@"fly",     @"somehthing",  @"aerial vehicles"];
    NSArray* array05 = @[@"drive",   @"something",   @"vehicles"];
    NSArray* array06 = @[@"eat",     @"food",        @"food"];
    NSArray* array07 = @[@"walk to", @"somewhere",   @"locations"];
    NSArray* array08 = @[@"drive to",@"location",    @"locations"];
    NSArray* array09 = @[@"fly to",  @"somewhere",   @"countries"];
    NSArray* array10 = @[@"travel to",@"place",      @"landmarks"];
    
    return @[array01,array02,array03,array04,array05,array06,array07,array08,array09,array10];
}

//
//// fetch
//

- (NSString*)randomWordFromSemanticTypeForEvent:(NSString*)typeName withContext: (NSManagedObjectContext*) context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Word" inManagedObjectContext:context];
    
    NSPredicate *predicateSemanticType  = [NSPredicate predicateWithFormat:@"whatSemanticType.name = %@", typeName];
    NSArray *subPredicates = [NSArray arrayWithObjects:predicateSemanticType, nil];
    NSPredicate *andPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
    fetchRequest.predicate = andPredicate;
    
    NSError* error;
    NSArray *fetchedRecords = [context executeFetchRequest:fetchRequest error:&error];
    
    Word*myWord = [[self shuffleArray:fetchedRecords]firstObject];

    return myWord.english;
}

- (EventDefine) returnRandomEvent
{
    NSInteger myInt = arc4random() % 9;
    switch (myInt) {
        case 0:
            return kEventRead;
            break;
        case 1:
            return kEventWatch;
            break;
        case 2:
            return kEventDrink;
            break;
        case 3:
            return kEventFly;
            break;
        case 4:
            return kEventEat;
            break;
        case 5:
            return kEventWalkto;
            break;
        case 6:
            return kEventDriveto;
            break;
        case 7:
            return kEventFlyto;
            break;
        case 8:
            return kEventTravelto;
            break;
        default:
            return kEventEat;
            break;
    }
}

@end
