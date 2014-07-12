//
//  Animal.h
//  YolarooGrammar
//
//  Created by MGM on 2/25/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Animal : NSObject

@property (strong,nonatomic) NSString* name;
@property (strong,nonatomic) NSString* type;

@property (strong,nonatomic) NSString* gender;
@property (nonatomic) BOOL plural;

@property (strong,nonatomic) NSString* location;
@property (strong,nonatomic) NSString* hairColor;

@property (strong,nonatomic) NSArray* bodyParts;
@property (strong,nonatomic) NSArray* clothes;

@property (strong,nonatomic) NSArray* likes;
@property (strong,nonatomic) NSArray* hates;

+ (Animal *) newAnimal:(NSString *)name type:(NSString *)type gender:(NSString*)gender plural: (BOOL)plural location:(NSString *)location hairColor:(NSString *)hairColor bodyParts:(NSArray *)bodyParts clothes:(NSArray *)clothes likes: (NSArray *) likes hates: (NSArray *) hates;

+ (Animal *) newAnimalFromArray:(NSArray *)myAnimalArray;


@end
