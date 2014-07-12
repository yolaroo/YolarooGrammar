//
//  MainFoundation+SynonymDataLoad.m
//  YolarooGrammar
//
//  Created by MGM on 5/11/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+SynonymDataLoad.h"

#import "SynonymList.h"
#import "SynonymModel.h"
#import "SynonymWord.h"

#import "SynonymObjectClass+Create.h"
#import "SynonymWordClass+Create.h"

@implementation MainFoundation (SynonymDataLoad)

#define DK 2
#define LOG if(DK == 1)

#pragma mark - Data Load

- (void) synonymDataLoaderIntoNSManagedObjectContext: (NSManagedObjectContext*) context
{
    SynonymModel* mySynonymModel  = [self setMySynonymModel];
    LOG NSLog(@"** MODEL **");
    NSArray* mySynonymClassArray = mySynonymModel.theSynonymNameList;
    LOG NSLog(@"** LIST **");
    
    for (NSString* ACA in mySynonymClassArray){
        
        NSArray*mySynonymList = [self getSynonymList:ACA withModel: mySynonymModel];
        
        NSInteger theClassNumber = [mySynonymModel.theSynonymNameList indexOfObject:ACA];
        NSString*myAntonym = [mySynonymModel.theAntonymNameList objectAtIndex:theClassNumber];

        SynonymObjectClass*mytype = [SynonymObjectClass synonymClassWithName:ACA withAntonym:myAntonym withContext:context];
        
        for (SynonymWord* AWD in mySynonymList) {
            SynonymWordClass* mySynonymWordClass = [SynonymWordClass synonymWordWithName:AWD.name withContext:context];
            NSSet* typeSet = [NSSet setWithObject:mytype];
            mySynonymWordClass.whatType = typeSet;
        }
        
        LOG NSLog(@"** Set of Adjectives Words Made **");
        
    }
    LOG NSLog(@"** Completed **");
    [self saveData:self.managedObjectContext];
}

- (NSArray*) getSynonymList:(NSString*)theType withModel: (SynonymModel*)theSynonymModel {
    NSArray* myArray;
    SynonymList* mySynonymList = [SynonymList newSynonymList:theType myModel:theSynonymModel];
    LOG NSLog(@"-- Adjective List Getter: %@ --",mySynonymList);
    
    myArray = mySynonymList.list;
    return myArray;
}


- (SynonymModel*) setMySynonymModel {
    SynonymModel* mySynonymModel = [SynonymModel newSynonymModel];
    LOG NSLog(@"Adjective Data Set - %@", mySynonymModel.theCompleteArray);
    return mySynonymModel;
}

@end
