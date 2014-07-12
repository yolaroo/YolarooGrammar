//
//  VerbWord.h
//  YolarooGrammar
//
//  Created by MGM on 4/30/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SententialVerb, VerbSemanticType;

@interface VerbWord : NSManagedObject

@property (nonatomic, retain) NSString * gerund;
@property (nonatomic, retain) NSString * infinitive;
@property (nonatomic, retain) NSString * past;
@property (nonatomic, retain) NSString * perfect;
@property (nonatomic, retain) NSString * simple;
@property (nonatomic, retain) NSString * thirdPersonSingular;
@property (nonatomic, retain) NSSet *whatSententialVerb;
@property (nonatomic, retain) VerbSemanticType *whatSemanticType;
@end

@interface VerbWord (CoreDataGeneratedAccessors)

- (void)addWhatSententialVerbObject:(SententialVerb *)value;
- (void)removeWhatSententialVerbObject:(SententialVerb *)value;
- (void)addWhatSententialVerb:(NSSet *)values;
- (void)removeWhatSententialVerb:(NSSet *)values;

@end
