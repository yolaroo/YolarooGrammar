//
//  Character+Create.m
//  YolarooGrammar
//
//  Created by MGM on 4/3/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Character+Create.h"

@implementation Character (Create)


+ (Character*) createCharacter: (NSArray*) dataArray withContext: (NSManagedObjectContext* ) context
{
    Character*theCharacter = nil;

    if ([dataArray count] && [[dataArray objectAtIndex:0]length] && [[dataArray objectAtIndex:1]length]) {
    
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Character"];
        request.predicate = [NSPredicate predicateWithFormat:@"uuID = %@", [dataArray objectAtIndex:0]];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];

        if (!matches || ([matches count] > 1)) {

        } else if (![matches count]) {
            
            theCharacter = [NSEntityDescription insertNewObjectForEntityForName:@"Character"
                                                         inManagedObjectContext:context];

            theCharacter.uuID = [dataArray objectAtIndex:0];
            theCharacter.name =[dataArray objectAtIndex:1];
            theCharacter.displayOrder =[dataArray objectAtIndex:2];
            theCharacter.whatBirthday =[dataArray objectAtIndex:3];
            theCharacter.whatGender =[dataArray objectAtIndex:4];
            theCharacter.whatHairColor = [dataArray objectAtIndex:5];
            theCharacter.isPlural =[dataArray objectAtIndex:6];
            theCharacter.whatSpecie = [dataArray objectAtIndex:7];
            theCharacter.whatLocation = [dataArray objectAtIndex:8];
            theCharacter.whatHome = [dataArray objectAtIndex:9];
            theCharacter.whatLike = [dataArray objectAtIndex:10];
            theCharacter.whatDislike = [dataArray objectAtIndex:11];
            theCharacter.whatJob = [dataArray objectAtIndex:12];
            theCharacter.whatClothes = [dataArray objectAtIndex:13];
            theCharacter.whatGoal = [dataArray objectAtIndex:14];
            theCharacter.whatAge = [dataArray objectAtIndex:15];
            theCharacter.whatEyeColor = [dataArray objectAtIndex:16];
            theCharacter.whatHeight = [dataArray objectAtIndex:17];
            theCharacter.whatWeight = [dataArray objectAtIndex:18];
            theCharacter.whatDisposition = [dataArray objectAtIndex:19];
            theCharacter.whatNationality = [dataArray objectAtIndex:20];
            theCharacter.whatEvent = [dataArray objectAtIndex:21];

        } else {
            theCharacter = [matches lastObject];
        }
    }
    return theCharacter;
}

@end
