//
//  SententialVerb.h
//  YolarooGrammar
//
//  Created by MGM on 4/28/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Auxiliary, Copula, Sentence, VerbWord;

@interface SententialVerb : NSManagedObject

@property (nonatomic, retain) NSNumber * hasAuxiliary;
@property (nonatomic, retain) NSNumber * isCopula;
@property (nonatomic, retain) NSNumber * isIndirectObjectPlural;
@property (nonatomic, retain) NSNumber * isSubjectPlural;
@property (nonatomic, retain) NSString * sentenceAspect;
@property (nonatomic, retain) NSString * sentenceModal;
@property (nonatomic, retain) NSString * sentenceTense;
@property (nonatomic, retain) NSString * theVerb;
@property (nonatomic, retain) NSString * theVerbPhrase;
@property (nonatomic, retain) NSSet *whatAuxiliary;
@property (nonatomic, retain) Copula *whatCopula;
@property (nonatomic, retain) NSSet *whatSentence;
@property (nonatomic, retain) VerbWord *whatVerbWord;
@end

@interface SententialVerb (CoreDataGeneratedAccessors)

- (void)addWhatAuxiliaryObject:(Auxiliary *)value;
- (void)removeWhatAuxiliaryObject:(Auxiliary *)value;
- (void)addWhatAuxiliary:(NSSet *)values;
- (void)removeWhatAuxiliary:(NSSet *)values;

- (void)addWhatSentenceObject:(Sentence *)value;
- (void)removeWhatSentenceObject:(Sentence *)value;
- (void)addWhatSentence:(NSSet *)values;
- (void)removeWhatSentence:(NSSet *)values;

@end
