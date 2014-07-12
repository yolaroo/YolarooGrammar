//
//  Story.h
//  YolarooGrammar
//
//  Created by MGM on 5/22/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Character, Sentence;

@interface Story : NSManagedObject

@property (nonatomic, retain) NSNumber * displayOrder;
@property (nonatomic, retain) NSNumber * isSaved;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * theStory;
@property (nonatomic, retain) NSString * uuID;
@property (nonatomic, retain) NSSet *whatCharacter;
@property (nonatomic, retain) NSSet *whatSentences;
@end

@interface Story (CoreDataGeneratedAccessors)

- (void)addWhatCharacterObject:(Character *)value;
- (void)removeWhatCharacterObject:(Character *)value;
- (void)addWhatCharacter:(NSSet *)values;
- (void)removeWhatCharacter:(NSSet *)values;

- (void)addWhatSentencesObject:(Sentence *)value;
- (void)removeWhatSentencesObject:(Sentence *)value;
- (void)addWhatSentences:(NSSet *)values;
- (void)removeWhatSentences:(NSSet *)values;

@end
