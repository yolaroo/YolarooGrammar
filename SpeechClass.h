//
//  SpeechClass.h
//  YolarooGrammar
//
//  Created by MGM on 5/20/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpeechClass : NSObject

- (BOOL) runSpeech: (NSArray*) speechArray;
- (void) stopSpeech;
- (void) changeSoundDefaults;

@end
