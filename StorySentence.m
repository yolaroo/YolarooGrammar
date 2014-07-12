//
//  Sentence.m
//  YolarooGrammar
//
//  Created by MGM on 2/26/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "StorySentence.h"

@implementation StorySentence

@synthesize suDeterminer=_suDeterminer, subject=_subject, verb=_verb, obDeterminer=_obDeterminer,object=_object,completeSentence=_completeSentence;

#define DK 2
#define LOG if(DK == 1)

+ (StorySentence *) newSentence:(NSString *)suDeterminer subject:(NSString *)subject verb:(NSString*)verb obDeterminer: (NSString *)obDeterminer object:(NSString *)object{
    StorySentence *sentence = [[StorySentence alloc] init];
    sentence.suDeterminer = suDeterminer;
    sentence.subject = subject;
    sentence.verb = verb;
    sentence.obDeterminer = obDeterminer;
    sentence.object = object;
    
    sentence.completeSentence = [NSString stringWithFormat:@"%@ %@ %@ %@ %@",sentence.suDeterminer,sentence.subject,sentence.verb,sentence.obDeterminer,sentence.object];
    return sentence;
}

+ (StorySentence *) newSentencefromArray:(NSArray *)mySentenceArray {
    StorySentence *sentence = [[StorySentence alloc] init];
    sentence.suDeterminer = [mySentenceArray objectAtIndex:0];
    sentence.subject = [mySentenceArray objectAtIndex:1];
    sentence.verb = [mySentenceArray objectAtIndex:2];
    sentence.obDeterminer = [mySentenceArray objectAtIndex:3];
    sentence.object = [mySentenceArray objectAtIndex:4];
    
    sentence.completeSentence = [NSString stringWithFormat:@"%@ %@ %@ %@ %@.",sentence.suDeterminer,sentence.subject,sentence.verb,sentence.obDeterminer,sentence.object];
    
    //remove blank space from empty
    if ([sentence.completeSentence hasPrefix:@" "]) {
        sentence.completeSentence = [sentence.completeSentence substringFromIndex:1];
    }
    
    sentence.completeSentence = [sentence.completeSentence stringByReplacingOccurrencesOfString:@"  " withString:@" "];
    sentence.completeSentence = [sentence.completeSentence stringByReplacingCharactersInRange :NSMakeRange(0,1) withString:[[sentence.completeSentence substringToIndex:1] capitalizedString]];
    return sentence;
}






@end
