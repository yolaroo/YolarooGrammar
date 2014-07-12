//
//  MainFoundation+SaveDatabase.m
//  YolarooGrammar
//
//  Created by MGM on 3/31/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+SaveDatabase.h"

@implementation MainFoundation (SaveDatabase)

#define DK 2
#define LOG if(DK == 1)

- (void) saveToDesktop
{
    NSString* myStringName = [NSString stringWithFormat:@"%@.sqlite",@"basic"];
    NSString *storePath = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:myStringName];
    NSString *storeUrl = [NSURL fileURLWithPath:storePath];

    NSString* deskStorePath = [NSString stringWithFormat:@"/Users/%@/Desktop/newMySQL.CDBStore", NSUserName()];

    NSFileManager * fileManager = [ NSFileManager defaultManager];

    NSError*error;
    if (![fileManager copyItemAtPath:storeUrl toPath: deskStorePath error:&error]){
        NSLog(@"error with path");
    }
    else {
        LOG NSLog(@"Copied");
    }
}

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) lastObject];
}


@end


