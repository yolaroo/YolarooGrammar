//
//  AdjectiveClass.h
//  YolarooGrammar
//
//  Created by MGM on 5/29/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AdjectiveSemanticType, SententialAdjective;

@interface AdjectiveClass : NSManagedObject

@property (nonatomic, retain) NSString * basic;
@property (nonatomic, retain) NSString * comparative;
@property (nonatomic, retain) NSNumber * isPositive;
@property (nonatomic, retain) NSString * superlative;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) AdjectiveSemanticType *whatSemanticType;
@property (nonatomic, retain) NSSet *whatSententialAdjective;
@end

@interface AdjectiveClass (CoreDataGeneratedAccessors)

- (void)addWhatSententialAdjectiveObject:(SententialAdjective *)value;
- (void)removeWhatSententialAdjectiveObject:(SententialAdjective *)value;
- (void)addWhatSententialAdjective:(NSSet *)values;
- (void)removeWhatSententialAdjective:(NSSet *)values;

@end
