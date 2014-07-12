//
//  Copula.h
//  YolarooGrammar
//
//  Created by MGM on 5/3/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SententialVerb;

@interface Copula : NSManagedObject

@property (nonatomic, retain) NSString * future;
@property (nonatomic, retain) NSString * infinitive;
@property (nonatomic, retain) NSString * pastPlural;
@property (nonatomic, retain) NSString * pastSingular;
@property (nonatomic, retain) NSString * presentPlural;
@property (nonatomic, retain) NSString * firstPersonSingular;
@property (nonatomic, retain) NSString * secondPersonSingular;
@property (nonatomic, retain) NSString * thirdPersonSingular;
@property (nonatomic, retain) NSSet *whatSententialVerb;
@end

@interface Copula (CoreDataGeneratedAccessors)

- (void)addWhatSententialVerbObject:(SententialVerb *)value;
- (void)removeWhatSententialVerbObject:(SententialVerb *)value;
- (void)addWhatSententialVerb:(NSSet *)values;
- (void)removeWhatSententialVerb:(NSSet *)values;

@end
