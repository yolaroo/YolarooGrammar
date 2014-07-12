//
//  Sentence.h
//  YolarooGrammar
//
//  Created by MGM on 2/26/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StorySentence : NSObject

@property (strong,nonatomic) NSString* suDeterminer;
@property (strong,nonatomic) NSString* subject;
@property (strong,nonatomic) NSString* verb;
@property (strong,nonatomic) NSString* obDeterminer;
@property (strong,nonatomic) NSString* object;
@property (strong,nonatomic) NSString* completeSentence;

+ (StorySentence *) newSentence:(NSString *)suDeterminer subject:(NSString *)subject verb:(NSString*)verb obDeterminer: (NSString *)obDeterminer object:(NSString *)object;

+ (StorySentence *) newSentencefromArray:(NSArray *)mySentenceArray;


@end
