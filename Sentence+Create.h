//
//  Sentence+Create.h
//  YolarooGrammar
//
//  Created by MGM on 4/4/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Sentence.h"

@interface Sentence (Create)

+ (Sentence*) createSentenceWithUUID: (NSString*) theUUID withContext: (NSManagedObjectContext* ) context;

@end
