//
//  AdjectiveClass+Create.h
//  YolarooGrammar
//
//  Created by MGM on 4/24/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "AdjectiveClass.h"
#import "AdjectiveWordData.h"

@interface AdjectiveClass (Create)

+ (AdjectiveClass *) adjectiveWithName: (AdjectiveWordData *) theAdjective withSemanticType: (AdjectiveSemanticType *) mySemanticType inManagedObjectContext:(NSManagedObjectContext *) context;


@end
