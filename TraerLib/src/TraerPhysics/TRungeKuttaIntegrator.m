//
//  TRungeKuttaIntegrator.m
//  TraerLibrary
//
//  Created by Henryk on 06.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import "TRungeKuttaIntegrator.h"
#import "TParticleSystem.h"
#import "TParticle.h"

@implementation TVector3DWrapper
@synthesize vector;
//-(FIVector3D*)vector{return &v;}
-(id)init{if(self = [super init]){vector = FIVector3DEMPTY();}return self;}
+(TVector3DWrapper*)vector3D{return [[TVector3DWrapper alloc]init];}
@end

@implementation TRungeKuttaIntegrator

@synthesize particleSystem;

-(id)initWithParticleSystem:(TParticleSystem *)s
{
    if(self = [super init])
    {
        particleSystem = s;
        
        originalPositions  = [[NSMutableArray alloc]init];
		originalVelocities = [[NSMutableArray alloc]init];
		k1Forces           = [[NSMutableArray alloc]init];
		k1Velocities       = [[NSMutableArray alloc]init];
		k2Forces           = [[NSMutableArray alloc]init];
		k2Velocities       = [[NSMutableArray alloc]init];
		k3Forces           = [[NSMutableArray alloc]init];
		k3Velocities       = [[NSMutableArray alloc]init];
		k4Forces           = [[NSMutableArray alloc]init];
		k4Velocities       = [[NSMutableArray alloc]init];
    }
    return self;
}

+(id)integratorWithParticleSystem:(TParticleSystem *)s
{
    return [[TRungeKuttaIntegrator alloc]initWithParticleSystem:s];
}

-(void)allocateParticles
{
    while ([particleSystem.particles count] > [originalPositions count])
    {
        [originalPositions  addObject:[TVector3DWrapper vector3D]];
        [originalVelocities addObject:[TVector3DWrapper vector3D]];
        [k1Forces           addObject:[TVector3DWrapper vector3D]];
        [k1Velocities       addObject:[TVector3DWrapper vector3D]];
        [k2Forces           addObject:[TVector3DWrapper vector3D]];
        [k2Velocities       addObject:[TVector3DWrapper vector3D]];
        [k3Forces           addObject:[TVector3DWrapper vector3D]];
        [k3Velocities       addObject:[TVector3DWrapper vector3D]];
        [k4Forces           addObject:[TVector3DWrapper vector3D]];
        [k4Velocities       addObject:[TVector3DWrapper vector3D]];
    }
}

-(void)step:(float)t
{
    [self allocateParticles];
   
    NSMutableArray* particles = [particleSystem particles];
    int i;
    int particlesLength = (int)[particles count];
    
    TParticle* p;
    
    FIVector3D originalPosition;
    FIVector3D originalVelocity;
    
    FIVector3D k1Velocity;
    FIVector3D k2Velocity;
    FIVector3D k3Velocity;
    FIVector3D k4Velocity;
    
    FIVector3D k1Force;
    FIVector3D k2Force;
    FIVector3D k3Force;
    FIVector3D k4Force;
    
    TVector3DWrapper* v;
    
    for (i=0; i<particlesLength; i++) {
        
        p = [particles objectAtIndex:i];
        
        if (! [p isFixed]) {
            v = [originalPositions objectAtIndex:i];
            v.vector = *(p.position);
            
            v = [originalVelocities objectAtIndex:i];
            v.vector = *(p.velocity);
        }
        
        FIVector3DClear(p.force);
        
    }
    
    [particleSystem applyForces];
    
    for (i=0; i<particlesLength; i++) {
        
        p = [particles objectAtIndex:i];
        
        if (! [p isFixed]) {
            v = [k1Forces objectAtIndex:i];
            v.vector = *(p.force);
            
            v = [k1Velocities objectAtIndex:i];
            v.vector = *(p.velocity);
        }
        
        FIVector3DClear(p.force);
    }
    
    
     for (i=0; i<particlesLength; i++) {
         
        p = [particles objectAtIndex:i];
        
        if (! [p isFixed]) {
            originalPosition = [[originalPositions objectAtIndex:i] vector];
            k1Velocity       = [[k1Velocities objectAtIndex:i] vector];
            
            p.position->x = originalPosition.x + k1Velocity.x * 0.5 * t;
            p.position->y = originalPosition.y + k1Velocity.y * 0.5 * t;
            
                        
            originalVelocity = [[originalVelocities objectAtIndex:i] vector];
            k1Force          = [[k1Forces objectAtIndex:i] vector];
            
            p.velocity->x = originalVelocity.x + k1Force.x * 0.5 * t / p.mass;
            p.velocity->y = originalVelocity.y + k1Force.y * 0.5 * t / p.mass;
            p.velocity->z = originalVelocity.z + k1Force.z * 0.5 * t / p.mass;
            
            
        }
        
    }
    
    [particleSystem applyForces];
    
   for (i=0; i<particlesLength; i++) {
        
        p = [particles objectAtIndex:i];
        
        if (! [p isFixed]) {
            v = [k2Forces objectAtIndex:i];
            v.vector = *(p.force);
            
            v = [k2Velocities objectAtIndex:i];
            v.vector = *(p.velocity);
        }
        
       FIVector3DClear(p.force);
    }
    
    for (i=0; i<particlesLength; i++) {
        
        p = [particles objectAtIndex:i];
        
        if (! [p isFixed]) {
            originalPosition = [[originalPositions objectAtIndex:i] vector];
            k2Velocity       = [[k2Velocities objectAtIndex:i] vector];
            
            p.position->x=originalPosition.x + k2Velocity.x * 0.5 * t;
            p.position->y=originalPosition.y + k2Velocity.y * 0.5 * t;
            p.position->z=originalPosition.z + k2Velocity.z * 0.5 * t;
            
            originalVelocity = [[originalVelocities objectAtIndex:i] vector];
            k2Force = [[k2Forces objectAtIndex:i] vector];
            
            p.velocity->x=originalVelocity.x + k2Force.x * 0.5 * t / p.mass;
            p.velocity->y=originalVelocity.y + k2Force.y * 0.5 * t / p.mass;
            p.velocity->z=originalVelocity.z + k2Force.z * 0.5 * t / p.mass;
            
        }
        
    }
    
    [particleSystem applyForces];
    
    for (i=0; i<particlesLength; i++) {
        
        p = [particles objectAtIndex:i];
        
        if (! [p isFixed]) {
            v = [k3Forces objectAtIndex:i];
            v.vector = *(p.force);
            
            v = [k3Velocities objectAtIndex:i];
            v.vector = *(p.velocity);
        }
        
        FIVector3DClear(p.force);
        
    }
    
    for (i=0; i<particlesLength; i++) {
        
        p = [particles objectAtIndex:i];
        
        if (! [p isFixed]) {
            originalPosition = [[originalPositions objectAtIndex:i] vector];
            k3Velocity = [[k3Velocities objectAtIndex:i] vector];
            
            p.position->x=originalPosition.x + k3Velocity.x * 0.5 * t;
            p.position->y=originalPosition.y + k3Velocity.y * 0.5 * t;
            p.position->z=originalPosition.z + k3Velocity.z * 0.5 * t;
            
            originalVelocity = [[originalVelocities objectAtIndex:i] vector];
            k3Force = [[k3Forces objectAtIndex:i] vector];
            
            p.velocity->x=originalVelocity.x + k3Force.x * 0.5 * t / p.mass;
            p.velocity->y=originalVelocity.y + k3Force.y * 0.5 * t / p.mass;
            p.velocity->z=originalVelocity.z + k3Force.z * 0.5 * t / p.mass;
            
        }
        
    }
    
    [particleSystem applyForces];
    
    for (i=0; i<particlesLength; i++) {
        
        p = [particles objectAtIndex:i];
        
        if (! [p isFixed]) {
            v = [k4Forces objectAtIndex:i];
            v.vector = *(p.force);
            
            v = [k4Velocities objectAtIndex:i];
            v.vector = *(p.velocity);
        }
        
        FIVector3DClear(p.force);
        
    }
    
    for (i=0; i<particlesLength; i++) {
        
        p = [particles objectAtIndex:i];
        p.age += t;
        
        if (! [p isFixed]) {
            
            // position
            
            originalPosition	= [[originalPositions objectAtIndex:i] vector];
            k1Velocity			= [[k1Velocities objectAtIndex:i] vector];
            k2Velocity			= [[k2Velocities objectAtIndex:i] vector];
            k3Velocity			= [[k3Velocities objectAtIndex:i] vector];
            k4Velocity			= [[k4Velocities objectAtIndex:i] vector];
            
            p.position->x=originalPosition.x + t / 6*(k1Velocity.x + 2*k2Velocity.x + 2*k3Velocity.x + k4Velocity.x);
            p.position->y=originalPosition.y + t / 6*(k1Velocity.y + 2*k2Velocity.y + 2*k3Velocity.y + k4Velocity.y);
            p.position->z=originalPosition.z + t / 6*(k1Velocity.z + 2*k2Velocity.z + 2*k3Velocity.z + k4Velocity.z);
            
            // velocity
            
            originalVelocity	= [[originalVelocities objectAtIndex:i] vector];
            k1Force				= [[k1Forces objectAtIndex:i] vector];
            k2Force				= [[k2Forces objectAtIndex:i] vector];
            k3Force				= [[k3Forces objectAtIndex:i] vector];
            k4Force				= [[k4Forces objectAtIndex:i] vector];
            
            p.velocity->x=originalVelocity.x + t / 6*p.mass * (k1Force.x + 2*k2Force.x + 2*k3Force.x + k4Force.x);
            p.velocity->y=originalVelocity.y + t / 6*p.mass * (k1Force.y + 2*k2Force.y + 2*k3Force.y + k4Force.y);
            p.velocity->z=originalVelocity.z + t / 6*p.mass * (k1Force.z + 2*k2Force.z + 2*k3Force.z + k4Force.z);
            
        }
        
    }

    /*
    int i = -1;
    TParticle* p;

    
    while( ++i < [particleSystem.particles count])
    {
        p = [particleSystem.particles objectAtIndex:i];
        
        if ( [p isFree] )
        {
            FIVector3DSetVector3D([[originalPositions  objectAtIndex:i] vector], p.position);
            FIVector3DSetVector3D([[originalVelocities objectAtIndex:i] vector], p.velocity);
        }
        
        FIVector3DClear([p force]);
    
        
    }
    
    
    [particleSystem applyForces];
    
    i = -1;
    
    while (++i < [particleSystem.particles count])
    {
        p = [particleSystem.particles objectAtIndex:i];
        
        if([p isFree])
        {
            FIVector3DSetVector3D([[k1Forces     objectAtIndex:i] vector], p.force);
            FIVector3DSetVector3D([[k1Velocities objectAtIndex:i] vector], p.velocity);
        }
        
        FIVector3DClear(p.force);
    }
    
    i = -1;
    
    FIVector3D* originalPosition;
    FIVector3D* k1Velocity;
    FIVector3D* originalVelocity;
    FIVector3D* k1Force;
    
    while(++i < [particleSystem.particles count])
    {
        p = [particleSystem.particles objectAtIndex:i];
        
        if([p isFree])
        {
            originalPosition = [[originalPositions objectAtIndex:i]vector];
            k1Velocity       = [[k1Velocities      objectAtIndex:i]vector];
            
            FIVector3DSetXYZ(p.position, originalPosition->x + k1Velocity->x * 0.5f * t,
                                        originalPosition->y + k1Velocity->y * 0.5f * t,
                                        originalPosition->z + k1Velocity->z * 0.5f * t);
            
            originalVelocity = [[originalVelocities objectAtIndex:i]vector];
            k1Force          = [[k1Forces           objectAtIndex:i]vector];
            
            FIVector3DSetXYZ(p.velocity, originalVelocity->x + k1Force->x * 0.5f * t / p.mass,
                                        originalVelocity->y + k1Force->y * 0.5f * t / p.mass,
                                        originalVelocity->z + k1Force->z * 0.5f * t / p.mass);
        }
    }
    
    [particleSystem applyForces];
    
    i = -1;
    
    while (++i < [particleSystem.particles count])
    {
        p = [particleSystem.particles objectAtIndex:i];
        
        if([p isFree])
        {
            FIVector3DSetVector3D([[k2Forces     objectAtIndex:i]vector], p.force);
            FIVector3DSetVector3D([[k2Velocities objectAtIndex:i]vector], p.velocity);
        }
        
        FIVector3DClear(p.force);
    }
    
    FIVector3D* k2Velocity;
    FIVector3D* k2Force;
    
    i = -1;
    
    while (++i < [particleSystem.particles count])
    {
        p = [particleSystem.particles objectAtIndex:i];
        
        if([p isFree])
        {
            originalPosition = [[originalPositions objectAtIndex:i]vector];
            k2Velocity       = [[k2Velocities      objectAtIndex:i]vector];
            
            FIVector3DSetXYZ(p.position, originalPosition->x + k2Velocity->x * 0.5f * t,
                                        originalPosition->y + k2Velocity->y * 0.5f * t,
                                        originalPosition->z + k2Velocity->z * 0.5f * t);
            
            originalVelocity = [[originalVelocities objectAtIndex:i]vector];
            k2Force          = [[k2Forces           objectAtIndex:i]vector];
            
            FIVector3DSetXYZ(p.position, originalVelocity->x + k2Force->x * 0.5f * t / p.mass,
                                        originalVelocity->y + k2Force->y * 0.5f * t / p.mass,
                                        originalVelocity->z + k2Force->z * 0.5f * t / p.mass);
        }
    }
    
    [particleSystem applyForces];
    
    i =-1;
    
    while (++i < [particleSystem.particles count])
    {
        p = [particleSystem.particles objectAtIndex:i];
        
        if([p isFree])
        {
            FIVector3DSetVector3D([[k3Forces objectAtIndex:i]vector],     p.force );
            FIVector3DSetVector3D([[k3Velocities objectAtIndex:i]vector], p.velocity);
        }
        
        FIVector3DClear(p.force);
    }
    
    i = -1;
    
    FIVector3D* k3Velocity;
    FIVector3D* k3Force;
    
    while (++i < [particleSystem.particles count])
    {
        p = [particleSystem.particles objectAtIndex:i];
        
        if([p isFree])
        {
            originalPosition = [[originalPositions objectAtIndex:i]vector];
            k3Velocity       = [[k3Velocities      objectAtIndex:i]vector];
            
            FIVector3DSetXYZ(p.position, originalPosition->x + k3Velocity->x * t,
                                        originalPosition->y + k3Velocity->y * t,
                                        originalPosition->z + k3Velocity->z * t);
            
            originalVelocity = [[originalVelocities objectAtIndex:i]vector];
            k3Force          = [[k3Forces           objectAtIndex:i]vector];
            
            FIVector3DSetXYZ(p.position, originalVelocity->x + k3Force->x * t / p.mass,
                                        originalVelocity->y + k3Force->y * t / p.mass,
                                        originalVelocity->z + k3Force->z * t / p.mass);
        }
    }
    
    [particleSystem applyForces];
    
    i = -1;
    
    while (++i < [particleSystem.particles count])
    {
        p = [particleSystem.particles objectAtIndex:i];
        
        if([p isFree])
        {
            FIVector3DSetVector3D([[k4Forces objectAtIndex:i]vector],     p.force );
            FIVector3DSetVector3D([[k4Velocities objectAtIndex:i]vector], p.velocity);
        }
        
        FIVector3DClear(p.force);
    }
    
    i = -1;
    
    FIVector3D* k4Velocity;
    FIVector3D* k4Force;
    
    while (++i < [particleSystem.particles count])
    {
        p = [particleSystem.particles objectAtIndex:i];
        
        p.age += t;
        
        if([p isFree])
        {
            originalPosition = [[originalPositions objectAtIndex:i]vector];
            k1Velocity       = [[k1Velocities      objectAtIndex:i]vector];
            k2Velocity       = [[k2Velocities      objectAtIndex:i]vector];
            k3Velocity       = [[k3Velocities      objectAtIndex:i]vector];
            k4Velocity       = [[k4Velocities      objectAtIndex:i]vector];
            
            FIVector3DSetXYZ(p.position, originalPosition->x + t / 6.0f + (k1Velocity->x + 2.0f * k2Velocity->x + 2.0f * k3Velocity->x + k4Velocity->x),
                                        originalPosition->y + t / 6.0f + (k1Velocity->y + 2.0f * k2Velocity->y + 2.0f * k3Velocity->y + k4Velocity->y),
                                        originalPosition->z + t / 6.0f + (k1Velocity->z + 2.0f * k2Velocity->z + 2.0f * k3Velocity->z + k4Velocity->z));
            
            originalVelocity = [[originalVelocities objectAtIndex:i]vector];
            k1Force          = [[k1Forces           objectAtIndex:i]vector];
            k2Force          = [[k2Forces           objectAtIndex:i]vector];
            k3Force          = [[k3Forces           objectAtIndex:i]vector];
            k4Force          = [[k4Forces           objectAtIndex:i]vector];
            
            FIVector3DSetXYZ(p.velocity, originalVelocity->x + t /  (6.0f * p.mass ) + (k1Force->x + 2.0f * k2Force->x + 2.0f * k3Force->x + k4Force->x),
                                        originalVelocity->y + t / (6.0f * p.mass ) + (k1Force->y + 2.0f * k2Force->y + 2.0f * k3Force->y + k4Force->y),
                                        originalVelocity->z + t / (6.0f * p.mass )  + (k1Force->z + 2.0f * k2Force->z + 2.0f * k3Force->z + k4Force->z));
        }
        
    }
    
    */

}










@end
