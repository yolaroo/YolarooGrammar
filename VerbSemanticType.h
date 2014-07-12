//
//  VerbSemanticType.h
//  YolarooGrammar
//
//  Created by MGM on 4/30/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class VerbWord;

@interface VerbSemanticType : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * isIntransitive;
@property (nonatomic, retain) NSNumber * isDiTransitive;
@property (nonatomic, retain) NSSet *whatVerb;
@end

@interface VerbSemanticType (CoreDataGeneratedAccessors)

- (void)addWhatVerbObject:(VerbWord *)value;
- (void)removeWhatVerbObject:(VerbWord *)value;
- (void)addWhatVerb:(NSSet *)values;
- (void)removeWhatVerb:(NSSet *)values;

@end
