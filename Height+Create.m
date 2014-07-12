//
//  Height+Create.m
//  YolarooGrammar
//
//  Created by MGM on 4/30/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Height+Create.h"

@implementation Height (Create)

+ (Height *) heightWithNumber: (NSNumber *) theNumber withContext:(NSManagedObjectContext *) context
{
    Height *theHeight = nil;
    if (theNumber) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Height"];
        request.predicate = [NSPredicate predicateWithFormat:@"height = %@", theNumber];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
            
            theHeight = [NSEntityDescription insertNewObjectForEntityForName:@"Height"
                                                        inManagedObjectContext:context];
            
            double total = (double)[theNumber integerValue]/2.54;
            NSInteger feet = (NSInteger)total / 12;
            NSInteger inches = (NSInteger)total % 12;

            theHeight.name = [NSString stringWithFormat:@"%@cm \n(%ld-foot-%ld)", [theNumber stringValue],(long)feet,(long)inches];
            theHeight.metaType = @"height";
            theHeight.height = theNumber;
        }
        else {
            theHeight = [matches lastObject];
        }
    }
    return theHeight;
}

+ (Height *) heightWithString: (NSString *) theNumber withContext:(NSManagedObjectContext *) context
{
    Height *theHeight = nil;
    if (theNumber) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Height"];
        request.predicate = [NSPredicate predicateWithFormat:@"height = %@", @([theNumber integerValue])];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
            
            theHeight = [NSEntityDescription insertNewObjectForEntityForName:@"Height"
                                                      inManagedObjectContext:context];
            
            theHeight.name = theNumber;
            theHeight.metaType = @"height";
            theHeight.height = @([theNumber integerValue]);
        }
        else {
            theHeight = [matches lastObject];
        }
    }
    return theHeight;
}

@end
