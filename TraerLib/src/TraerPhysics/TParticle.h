//
//  TParticle.h
//  TraerLibrary
//
//  Created by Henryk on 05.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FIMath.h"

@interface TParticle : NSObject
{
    @protected
    
    FIVector3D position;
    FIVector3D velocity;
    FIVector3D force;
    
    float mass;
    float age;
    
    BOOL dead;
    BOOL fixed;
}

-(FIVector3D*)position;
-(FIVector3D*)velocity;
-(FIVector3D*)force;


-(id)initWithMass:(float)m;
+(id)particelWithMass:(float)m;

-(float)distanceTo:(TParticle*)p;

-(void)makeFixed;
-(BOOL)isFixed;
-(BOOL)isFree;
-(void)makeFree;

-(float)mass;
-(void)setMass:(float)m;


-(float)age;
-(void)setAge:(float)a;

-(void)reset;

@end
