//
//  TParticle.m
//  TraerLibrary
//
//  Created by Henryk on 05.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import "TParticle.h"

@implementation TParticle


-(id)initWithMass:(float)m
{
    if(self = [super init])
    {
        
        position = FIVector3DEMPTY();
        velocity = FIVector3DEMPTY();
        force    = FIVector3DEMPTY();
        
        mass  = m;
        fixed = NO;
        age   = 0;
        dead  = NO;
    }
    return self;
}

+(id)particelWithMass:(float)m
{
    return [[TParticle alloc]initWithMass:m];
}

-(float)distanceTo:(TParticle *)p
{
    return FIVector3DDistanceToVector3D(&position, &p->position);
}

-(void)makeFixed
{
    fixed = YES;
    FIVector3DClear(&velocity);
}

-(BOOL)isFixed
{
    return fixed;
}

-(BOOL)isFree
{
    return !fixed;
}

-(void)makeFree
{
    fixed = NO;
}

-(FIVector3D*)position
{
    return &position;
}

-(FIVector3D*)velocity
{
    return &velocity;
}

-(float)mass
{
    return mass;
}

-(void)setMass:(float)m
{
    mass = m;
}

-(FIVector3D*)force
{
    return &force;
}

-(float)age
{
    return age;
}

-(void)setAge:(float)a
{
    age = a;
}

-(void)reset
{
    age  = 0;
    dead = NO;
    FIVector3DClear(&position);
    FIVector3DClear(&velocity);
    FIVector3DClear(&force);
    mass = 1;
}




@end
