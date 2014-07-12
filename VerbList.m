//
//  VerbList.m
//  YolarooGrammar
//
//  Created by MGM on 4/11/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "VerbList.h"

@implementation VerbList

#define DK 2
#define LOG if(DK == 1)

+ (VerbList*) newVerbList:(NSString*)myClassName myModel: (VerbModel*)myModel
{
    VerbList * myWordList = [[VerbList alloc] init];
    
    NSInteger theClassNumber = [myModel.theCategoryNameList indexOfObject:myClassName];
    NSDictionary* classDictionary = [myModel.theCompleteArray objectAtIndex:theClassNumber];
    NSArray *wordArray = [classDictionary objectForKey:@"list"]; //2nd level count
    NSUInteger wordArrayCount = [wordArray count];

    LOG NSLog(@"-- verb list count -- %lu --", (unsigned long)wordArrayCount);
    
    NSMutableArray *temparray = [NSMutableArray arrayWithCapacity:wordArrayCount];
    for(int i=0;i<wordArrayCount;i++)
    {
        VerbWordData*theVerb = [[VerbWordData alloc]init];
        theVerb.infinitive = [[[[[[[
                        myModel.theCompleteDictionary objectForKey:@"verbs"]
                        objectAtIndex:theClassNumber]
                        objectForKey:@"list"]
                        objectAtIndex:i]
                        objectForKey: @"forms"]
                        objectAtIndex:0]
                        objectForKey:@"infinitive"];

        theVerb.past = [[[[[[[
                        myModel.theCompleteDictionary objectForKey:@"verbs"]
                        objectAtIndex:theClassNumber]
                        objectForKey:@"list"]
                        objectAtIndex:i]
                        objectForKey: @"forms"]
                        objectAtIndex:0]
                        objectForKey:@"past"];
        
        theVerb.perfect = [[[[[[[
                        myModel.theCompleteDictionary objectForKey:@"verbs"]
                        objectAtIndex:theClassNumber]
                        objectForKey:@"list"]
                        objectAtIndex:i]
                        objectForKey: @"forms"]
                        objectAtIndex:0]
                        objectForKey:@"perfect"];
        
        theVerb.simple = [[[[[[[
                        myModel.theCompleteDictionary objectForKey:@"verbs"]
                        objectAtIndex:theClassNumber]
                        objectForKey:@"list"]
                        objectAtIndex:i]
                        objectForKey: @"forms"]
                        objectAtIndex:0]
                        objectForKey:@"simple"];
        
        theVerb.thirdPersonSingular = [[[[[[[
                        myModel.theCompleteDictionary objectForKey:@"verbs"]
                        objectAtIndex:theClassNumber]
                        objectForKey:@"list"]
                        objectAtIndex:i]
                        objectForKey: @"forms"]
                        objectAtIndex:0]
                        objectForKey:@"thirdPersonSingular"];
        
        theVerb.gerund = [[[[[[[
                        myModel.theCompleteDictionary objectForKey:@"verbs"]
                        objectAtIndex:theClassNumber]
                        objectForKey:@"list"]
                        objectAtIndex:i]
                        objectForKey: @"forms"]
                        objectAtIndex:0]
                        objectForKey:@"gerund"];
        
        LOG NSLog(@"-- Verb List - First Object - %@",myClassName);
        //theVerb.semanticType = myClassName;
        [temparray addObject:theVerb];
        theVerb = nil;
    }    
    myWordList.list = [NSArray arrayWithArray:temparray];
    return myWordList;
}

@end
