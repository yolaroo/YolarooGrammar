//
//  MainFoundation+VerbDefine.m
//  YolarooGrammar
//
//  Created by MGM on 4/14/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+VerbDefine.h"
#import "MainFoundation+SentenceUtility.h"

#import "Copula+Create.h"

#import "VerbWord.h"

@implementation MainFoundation (VerbDefine)

#define DK 2
#define LOG if(DK == 1)

- (bool) isEventClass: (NSDictionary*) dictionary {
    NSString*myString = [self stringFromDictionaryWithArray:dictionary withKey:@"verb" withType:@"metaType"];
    if ([myString isEqualToString:@"event"]){
        return true;
    }
    else {
        return false;
    }
}

- (SententialVerb*) makeVerbPhrase: (Character*) theCharacter withSubjectPhrase: (SubjectPhrase*) theSubjectPhrase withSentence: (Sentence*) theSentence withDefinition: (VerbDefine) myVerbDefinition withDictionary: (NSDictionary*) dictionary withContext: (NSManagedObjectContext*) context
{
    LOG NSLog(@"verb start");

    NSString*theVerb;
    BOOL isCopula = false;
    VerbWord* myVerbWord;
    if (myVerbDefinition == kVerbIsSet) {
        LOG NSLog(@"** (the verb) **");
        if ([[[[dictionary objectForKey:@"verb"] allObjects]firstObject] respondsToSelector:@selector(metaType)]) {
            LOG NSLog(@"** selector:metatype **");
            
            if ([self isEventClass:dictionary]) {
                NSInteger myIndex = 0;
                if ([theSentence.hasSingleObjectUnpack boolValue]){
                    myIndex = [theSentence.singleObjectUnpackIndex integerValue];
                }
                
                myVerbWord = [self verbFromName:[self stringFromDictionaryWithArrayAtIndex:dictionary withKey:@"verb" withType:@"verb" withIndex:myIndex] withContext:context];
                
                NSDictionary*smallDictionary = @{@"sentenceTense":theSentence.sentenceTense,
                                                 @"sentenceModal":theSentence.sentenceModal,
                                                 @"sentenceAspect":theSentence.sentenceAspect,
                                                 @"isSubjectplural":theSubjectPhrase.whatProperties.isPlural,
                                                 };
                
                theVerb = [self conjugatedVerbText:myVerbWord withDictionary:smallDictionary];
                
                LOG NSLog(@"-- the verb: %@ --",theVerb);

                smallDictionary = nil;

            }
            else {
                myVerbWord = [self verbFromName:[self stringFromDictionaryWithArray:dictionary withKey:@"verb" withType:@"metaType"] withContext:context];
                
                NSDictionary*smallDictionary = @{@"sentenceTense":theSentence.sentenceTense,
                                                 @"sentenceModal":theSentence.sentenceModal,
                                                 @"sentenceAspect":theSentence.sentenceAspect,
                                                 @"isSubjectplural":theSubjectPhrase.whatProperties.isPlural,
                                                 };
                
                theVerb = [self conjugatedVerbText:myVerbWord withDictionary:smallDictionary];
                
                LOG NSLog(@"-- the verb: %@ --",theVerb);

                smallDictionary = nil;
            }
        }
    }
    else if (myVerbDefinition == kVerbIsObject) {
        NSLog(@"verb object definition error");
    }
    else {
        LOG NSLog(@"-- other-type verb --");
        if (myVerbDefinition == kVerbIsString) {
            if ([[dictionary objectForKey:@"verb"] isEqualToString:@"BE"]) {
                LOG NSLog(@"-- be-type verb --");
                Copula*theCopula = [Copula getCopula:context];
                isCopula = true;
                if ([dictionary objectForKey:@"verb_tense"]) {
                    LOG NSLog(@" WARNING FOR VERB");
                }
                else {
                    if ([theSubjectPhrase.whatProperties.isPlural boolValue]) {
                        theVerb = theCopula.presentPlural;
                        LOG NSLog(@" PLURAL VERB");
                    }
                    else {
                        theVerb = theCopula.thirdPersonSingular;
                        LOG NSLog(@" NO PLURAL VERB");
                    }
                }
            }
            else {
                LOG [theSubjectPhrase.whatProperties.isPlural boolValue] ? NSLog(@"VerbPhrase is plural") : NSLog(@"VerbPhrase is NOT plural");

                myVerbWord = [self verbFromName:[dictionary objectForKey:@"verb"] withContext:context];
                NSDictionary*smallDictionary = @{@"sentenceTense":theSentence.sentenceTense,
                                                 @"sentenceModal":theSentence.sentenceModal,
                                                 @"sentenceAspect":theSentence.sentenceAspect,
                                                 @"isSubjectplural":theSubjectPhrase.whatProperties.isPlural,
                                                 };
                
                theVerb = [self conjugatedVerbText:myVerbWord withDictionary:smallDictionary];
                smallDictionary = nil;
            }
        }
        else {
            NSLog(@"verb error");
        }
    }
    
    NSDictionary* verbDictionary;
    if ([theVerb length]) {
        verbDictionary = @{@"theVerb":theVerb,
                           @"isCopula":[NSNumber numberWithBool:isCopula],
                           @"sentenceTense":theSentence.sentenceTense,
                           @"sentenceModal":theSentence.sentenceModal,
                           @"sentenceAspect":theSentence.sentenceAspect,
                           @"isSubjectplural":theSubjectPhrase.whatProperties.isPlural,
                           };
    }
    else {
        LOG NSLog(@"verb error");
        verbDictionary = @{@"theVerb":@"BE",
                           @"isCopula":[NSNumber numberWithBool:isCopula],
                           @"sentenceTense":theSentence.sentenceTense,
                           @"sentenceModal":theSentence.sentenceModal,
                           @"sentenceAspect":theSentence.sentenceAspect,
                           @"isSubjectplural":theSubjectPhrase.whatProperties.isPlural,
                           };
    }
    
    SententialVerb*theSententialVerb = [SententialVerb createSententialVerbForSentence:theSentence withDictionary:verbDictionary withContext:context];
    
    if (!isCopula){
        theSententialVerb.whatVerbWord = myVerbWord;
    }
    
    NSString*completeVerbString = [self sentenceSpaceFixer:[NSString stringWithFormat:@"%@",theVerb] withCaps: false];
    theSententialVerb.theVerbPhrase = completeVerbString;
    
    LOG NSLog(@"-- FINAL - VerbPhrase - %@ -- ",completeVerbString);
    
    verbDictionary = nil;
    theVerb = nil;
    myVerbWord = nil;
    completeVerbString = nil;
    
    LOG NSLog(@"verb end");

    return theSententialVerb;
}

//
//
////
//// Utility
////
//
//

- (VerbWord*) verbFromName: (NSString*)theWord withContext: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"VerbWord" inManagedObjectContext:newContext];
    LOG NSLog(@"-- \n -- verb: %@ -- \n", theWord);
    
    NSPredicate *infinitiveName = [NSPredicate predicateWithFormat:@"infinitive = %@", theWord];
    NSPredicate *pastName = [NSPredicate predicateWithFormat:@"past = %@", theWord];
    NSPredicate *perfectName = [NSPredicate predicateWithFormat:@"perfect = %@", theWord];
    NSPredicate *simpleName = [NSPredicate predicateWithFormat:@"simple = %@", theWord];
    NSPredicate *thirdPersonSingularName = [NSPredicate predicateWithFormat:@"thirdPersonSingular = %@", theWord];
    NSPredicate *gerundName = [NSPredicate predicateWithFormat:@"gerund = %@", theWord];

    NSArray *subPredicates = [NSArray arrayWithObjects:infinitiveName,pastName,perfectName,simpleName,thirdPersonSingularName,gerundName, nil];
    NSPredicate *orPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:subPredicates];
    
    fetchRequest.predicate = orPredicate;
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return [fetchedRecords firstObject];
}

- (NSString*) conjugatedVerbText: (VerbWord*) myVerb withDictionary: (NSDictionary*) dictionary {
    LOG NSLog(@"-- verb word test -- %@",myVerb.infinitive);
    LOG NSLog(@"VerbPhrase aspect- %@",[dictionary objectForKey:@"sentenceAspect"]);
    LOG NSLog(@"VerbPhrase modal- %@",[dictionary objectForKey:@"sentenceModal"]);
    LOG NSLog(@"VerbPhrase tense- %@",[dictionary objectForKey:@"sentenceTense"]);
    LOG [[dictionary objectForKey:@"isSubjectplural"]boolValue] ? NSLog(@"VerbPhrase is plural") : NSLog(@"VerbPhrase is NOT plural");
    
    if ([[dictionary objectForKey:@"sentenceAspect"] isEqualToString:@"infinitive"]) {
        return myVerb.infinitive;
    }
    else if ([[dictionary objectForKey:@"sentenceAspect"] isEqualToString:@"gerund"]) {
        return myVerb.gerund;
    }
    else if ([[dictionary objectForKey:@"sentenceTense"] isEqualToString:@"future"]) {
        if ([[dictionary objectForKey:@"sentenceAspect"] isEqualToString:@"perfect"]) {
            return [NSString stringWithFormat:@"will have %@",myVerb.perfect];
        }
        else {
            return [NSString stringWithFormat:@"will %@",myVerb.simple];
        }
    }
    else if ([[dictionary objectForKey:@"sentenceTense"] isEqualToString:@"past"]) {
        if ([[dictionary objectForKey:@"sentenceAspect"] isEqualToString:@"perfect"]) {
            return [NSString stringWithFormat:@"had %@",myVerb.perfect];
        }
        else {
            return myVerb.past;
        }
    }
    else if ([[dictionary objectForKey:@"sentenceTense"] isEqualToString:@"present"]) {
        if ([[dictionary objectForKey:@"sentenceModal"] isEqualToString:@"thirdPerson"] && ![[dictionary objectForKey:@"isSubjectplural"]boolValue]) {
            if ([[dictionary objectForKey:@"sentenceAspect"] isEqualToString:@"perfect"]) {
                LOG NSLog(@"-- perfect --");
                return [NSString stringWithFormat:@"has %@",myVerb.perfect];
            }
            else {
                LOG NSLog(@"-- present 3rd person singular --");
                return myVerb.thirdPersonSingular;
            }
        }
        else {
            if ([[dictionary objectForKey:@"sentenceAspect"] isEqualToString:@"perfect"]) {
                LOG NSLog(@"-- perfect!!!!! --");

                return [NSString stringWithFormat:@"have %@",myVerb.perfect];
            }
            else {
                LOG NSLog(@"-- simple!!!!! --");

                return myVerb.simple;
            }
        }
    }
    else {
        return @"<VERB_ERROR>";
    }
}

@end
