//
//  MainFoundation+VerbDataLoad.m
//  YolarooGrammar
//
//  Created by MGM on 4/12/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+VerbDataLoad.h"
#import "VerbWord+Create.h"
#import "VerbSemanticType+Create.h"

#import "VerbModel.h"
#import "VerbList.h"
#import "VerbSemanticType.h"

#define DK 2
#define LOG if(DK == 1)

#pragma mark - SQL Fetch

@implementation MainFoundation (VerbDataLoad)

#pragma mark - Data Load

- (void) verbDataLoaderIntoNSManagedObjectContext: (NSManagedObjectContext*)context
{
    VerbModel* myVerbModel  = [self setMyVerbModel];
    
    NSArray* myVerbSemanticTypeArray = myVerbModel.theCategoryNameList;

    LOG NSLog(@"** (array) %@ **", myVerbSemanticTypeArray);
    for (NSString* str in myVerbSemanticTypeArray) {
        LOG NSLog(@"** (Verb Category by String) %@ **", str);

        NSArray*myVerbList = [self getVerbList:str withModel: myVerbModel];
        LOG NSLog(@"** (verb count): %lu**",(unsigned long)[myVerbList count]);
        
        VerbSemanticType* myType = [VerbSemanticType semanticTypeForGrammarWordWithName:str inManagedObjectContext:context];
        
        for (VerbWordData* vwd in myVerbList) {
            LOG NSLog(@"** (infinitive) %@ **", vwd.infinitive);
            [VerbWord createVerbWord:vwd withSemanticType:myType withContext:context];
        }
    }
    [self saveData:self.managedObjectContext];
}

- (NSArray*) getVerbList:(NSString*)theType withModel: (VerbModel*)theVerbModel {
    NSArray* myArray;
    VerbList* myVerbList = [VerbList newVerbList:theType myModel:theVerbModel];
    LOG NSLog(@"-- Verb List Getter: %@ --",myVerbList);

    myArray = myVerbList.list;
    return myArray;
}

- (VerbModel*) setMyVerbModel {
    VerbModel* myDataModel = [VerbModel newVerbModel];
     LOG NSLog(@"Verb Data Set - %@", myDataModel.theCompleteArray);
    return myDataModel;
}

@end
