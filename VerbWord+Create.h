//
//  VerbWord+Create.h
//  YolarooGrammar
//
//  Created by MGM on 4/12/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "VerbWord.h"
#import "VerbWordData.h"

@interface VerbWord (Create)

+ (VerbWord*) createVerbWord: (VerbWordData*) myVerbWord withSemanticType:(VerbSemanticType*) mySemanticType withContext: (NSManagedObjectContext* ) context;

@end
