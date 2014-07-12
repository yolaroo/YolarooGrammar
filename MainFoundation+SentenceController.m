//
//  MainFoundation+SentenceController.m
//  YolarooGrammar
//
//  Created by MGM on 4/8/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+SentenceController.h"

#import "MainFoundation+CharacterCreate.h"
#import "MainFoundation+SentenceCreation.h"
#import "MainFoundation+StoryCreation.h"
#import "Story+Create.h"

#import "MainFoundation+StorySearch.h"

@implementation MainFoundation (SentenceController)

#define DK 2
#define LOG if(DK == 1)

- (Story*) myStoryBuilder: (NSManagedObjectContext*) context
{
    //auto make four
    ////
    //test
    LOG NSLog(@"Time Start");
    LOG [self timeTestStart];
    //test
    ////
    
    Character*theCharacter = [self writeCharacter:context];
    NSArray*theStorySentenceArray = [self exampleStoryObject:theCharacter];
    Story* myStory = [self storyDataLoad:theCharacter withSentenceArray:theStorySentenceArray withContext:context];
    myStory.displayOrder = [NSNumber numberWithInteger:(1 + [self completeStoryCount: self.managedObjectContext])];
    [self saveData:context];

    ////
    //test
    LOG NSLog(@"Story Done");
    LOG [self timeTestUpdate];
    //test
    ////
    return myStory;
}

- (void) buildTheStory: (NSManagedObjectContext*) context
{
    //database screen
    ////
    //test
    LOG NSLog(@"-- Time Start BTS --");
    LOG [self timeTestStart];
    //test
    ////
    
    Character*theCharacter = [self writeCharacter:context];
    NSArray*theStorySentenceArray = [self exampleStoryObject:theCharacter];
    Story*myStory = [self storyDataLoad:theCharacter withSentenceArray:theStorySentenceArray withContext:context];
    myStory.displayOrder = [NSNumber numberWithInteger:(1 + [self completeStoryCount: self.managedObjectContext])];

    ////
    //test
    LOG NSLog(@"-- Thead Completed with Story --");
    LOG [self timeTestUpdate];
    //test
    ////
    
    [self saveData:context];
}

- (void) buildTheStoryFromMaker:(Character*) theCharacter withContext: (NSManagedObjectContext*) context
{
    //database screen
    ////
    //test
    LOG NSLog(@"-- Time Start BTS --");
    LOG [self timeTestStart];
    //test
    ////
    
    NSLog(@"story build start");
    
    NSArray*theStorySentenceArray = [self exampleStoryObject:theCharacter];
    Story*myStory = [self storyDataLoad:theCharacter withSentenceArray:theStorySentenceArray withContext:context];
    myStory.displayOrder = [NSNumber numberWithInteger:(1 + [self completeStoryCount: self.managedObjectContext])];
    
    ////
    //test
    LOG NSLog(@"-- Thead Completed with Story --");
    LOG [self timeTestUpdate];
    //test
    ////
    
    [self saveData:context];
}



- (Story*) storyDataLoad: (Character*) theCharacter withSentenceArray: (NSArray*) theStorySentenceArray withContext:(NSManagedObjectContext*)context
{
    Story* theStoryObject = [Story createStory:[self buildUUID] withContext:context];
    
    ////
    //test
    LOG NSLog(@"-- Story Initialized --");
    LOG [self timeTestStart];
    //test
    ////
    
    NSMutableString* theStoryString = [[NSMutableString alloc]init];
    [theStoryString appendString:@""];
    NSMutableSet* mySetOfSentences= [[NSMutableSet alloc]init];
    
    for(int i = 0; i < [theStorySentenceArray count]; i++) {
        LOG NSLog(@"\n \nCount - %d \n \n",i);
        Sentence* theSentence = [self writeSentence:theCharacter withDictionary:[theStorySentenceArray objectAtIndex:i] withContext:context];
        
        if (theSentence != nil) {
            theSentence.displayOrder = [NSNumber numberWithInt:i];
            [mySetOfSentences addObject:theSentence];

            if (theSentence.theSentence!=nil){
                [theStoryString appendString:theSentence.theSentence];
                LOG NSLog(@"** Sentence - %@ **",theSentence.theSentence);
                [theStoryString appendString:@" \n "];
            }
        }
    }
    
    LOG NSLog(@"-- STORY BUILT LOOP FINISHED --");
    theStoryObject.theStory = [theStoryString copy];
    theStoryObject.whatSentences = [mySetOfSentences copy];
    NSSet* theCharacterSet = [NSSet setWithObjects:theCharacter, nil];
    theStoryObject.whatCharacter = theCharacterSet;
    LOG NSLog(@"\n/-- The Story -- \n%@",theStoryString);

    ////
    //test
    LOG NSLog(@"-- Story Done --");
    LOG [self timeTestUpdate];
    //test
    ////
    
    return theStoryObject;
}


@end
