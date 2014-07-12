//
//  Word+Create.h
//  YolarooGrammar
//
//  Created by MGM on 3/31/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Word.h"

@interface Word (Create)

+ (Word *)wordWithName:(NSString *)name withSemanticType: (SemanticType* )mySemanticType withSyntacticType: (SyntacticType*) mySyntacticType withWordObject: (NSString*) wordObject inManagedObjectContext:(NSManagedObjectContext *)context;

+ (Word *)wordWithNameFromNil:(NSString *)name withContext: (NSManagedObjectContext *)context;

+ (Word *) emptyWordFetch:(NSManagedObjectContext*) newContext;
+ (Word *) wordCreateThatIsEmpty:(NSManagedObjectContext *)context;

@end
