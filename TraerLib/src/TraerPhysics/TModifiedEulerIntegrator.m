//
//  TModifiedEulerIntegrator.m
//  TraerLibrary
//
//  Created by Henryk on 06.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import "TModifiedEulerIntegrator.h"
#import "TParticleSystem.h"
#import "TParticle.h"
#import "FIMath.h"

@implementation TModifiedEulerIntegrator

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
    return [[TModifiedEulerIntegrator alloc]initWithParticleSystem:s];
}

-(void)step:(float)t
{
    [particleSystem clearForces];
    [particleSystem applyForces];
    
    float halftt = 0.5f * t * t;
    float ax,ay,az;
    
    for (TParticle* p in [particleSystem particles])
    {
        if([p isFree])
        {
            ax = p.force->x/p.mass;
            ay = p.force->y/p.mass;
            az = p.force->z/p.mass;
            
            FIVector3DAddXYZ(p.position, p.velocity->x/t,
                            p.velocity->y/t,
                            p.velocity->z/t);
            
            FIVector3DAddXYZ(p.position, ax * halftt,
                            ay * halftt,
                            az * halftt);
            
            FIVector3DAddXYZ(p.velocity, ax/t,
                            ay/t,
                            az/t);
        }
        
    }
}

@end
