//
//  Animal.m
//  YolarooGrammar
//
//  Created by MGM on 2/25/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Animal.h"

@implementation Animal

@synthesize name=_name, type=_type,location=_location,hairColor=_hairColor,gender=_gender,plural=_plural,bodyParts=_bodyParts,clothes=_clothes,likes=_likes,hates=_hates;

#define DK 2
#define LOG if(DK == 1)

+ (Animal *) newAnimal:(NSString *)name type:(NSString *)type gender:(NSString*)gender plural: (BOOL)plural location:(NSString *)location hairColor:(NSString *)hairColor bodyParts:(NSArray *)bodyParts clothes:(NSArray *)clothes likes: (NSArray *) likes hates: (NSArray *) hates
{
    Animal *animal = [[Animal alloc] init];
    animal.name = name;
    animal.type = type;
    animal.gender = gender;
    animal.plural = false;
    animal.location = location;
    animal.hairColor = hairColor;
    animal.bodyParts = bodyParts;
    animal.clothes = clothes;
    animal.likes = likes;
    animal.hates = hates;
    
    return animal;
}

+ (Animal *) newAnimalFromArray:(NSArray *)myAnimalArray{
    Animal *animal = [[Animal alloc] init];
    animal.name = [myAnimalArray objectAtIndex:0];
    animal.type = [myAnimalArray objectAtIndex:1];
    animal.gender = [myAnimalArray objectAtIndex:2];
    animal.plural = false;
    animal.location = [myAnimalArray objectAtIndex:4];
    animal.hairColor = [myAnimalArray objectAtIndex:5];
    animal.bodyParts = [myAnimalArray objectAtIndex:6];
    animal.clothes = [myAnimalArray objectAtIndex:7];
    animal.likes = [myAnimalArray objectAtIndex:8];
    animal.hates = [myAnimalArray objectAtIndex:9];

    return animal;
}

//NSNumber numberWithBool

@end
