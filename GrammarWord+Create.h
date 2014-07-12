//
//  GrammarWord+Create.h
//  YolarooGrammar
//
//  Created by MGM on 4/29/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "GrammarWord.h"

@interface GrammarWord (Create)

+ (GrammarWord *)grammarWordWithName:(NSString *)name withSemanticType: (GrammarWordSemanticType* )mySemanticType inManagedObjectContext:(NSManagedObjectContext *)context;

+ (GrammarWord *)grammarWordForNewName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)context;

@end
