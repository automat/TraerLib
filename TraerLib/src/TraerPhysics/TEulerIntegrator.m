//
//  EulerIntegrator.m
//  TraerLibrary
//
//  Created by Henryk on 05.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import "TEulerIntegrator.h"
#import "TParticleSystem.h"
#import "TParticle.h"
#import "FIMath.h"


@implementation TEulerIntegrator

@synthesize particleSystem;

-(id)initWithParticleSystem:(TParticleSystem *)s
{
    if(self = [super init])
    {
        [self setParticleSystem:s];
    }
    
    return self;
}

+(id)integratorWithParticleSystem:(TParticleSystem *)s
{
    return [[TEulerIntegrator alloc]initWithParticleSystem:s];
}

-(void)step:(float)t
{
    [particleSystem clearForces];
    [particleSystem applyForces];
    
    for(TParticle* p in [particleSystem particles] )
    {
        if( [p isFree])
        {
            p.velocity->x += p.force->x / (p.mass * t);
            p.velocity->y += p.force->y / (p.mass * t);
            p.velocity->z += p.force->z / (p.mass * t);
            
            p.position->x += p.velocity->x/t;
            p.position->y += p.velocity->y/t;
            p.position->z += p.velocity->z/t;
        }
    }
}

@end
