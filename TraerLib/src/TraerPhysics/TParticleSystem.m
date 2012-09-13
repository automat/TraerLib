//
//  TParticleSystem.m
//  TraerLibrary
//
//  Created by Henryk on 05.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import "TParticleSystem.h"
#import "TEulerIntegrator.h"
#import "TModifiedEulerIntegrator.h"
#import "TRungeKuttaIntegrator.h"

#import "TParticle.h"
#import "TSpring.h"
#import "TAttraction.h"

@implementation TParticleSystem

@synthesize particles;
@synthesize springs;
@synthesize attractions;
@synthesize costumForces;

@synthesize gravity;
@synthesize drag;

@synthesize hasDeadParticles;



-(void)setIntegrator:(int)i
{
    integrator = (i == 0) ? [TRungeKuttaIntegrator    integratorWithParticleSystem:self] :
                 (i == 1) ? [TModifiedEulerIntegrator integratorWithParticleSystem:self] :
                 (i == 2) ? [TEulerIntegrator         integratorWithParticleSystem:self] :
                  nil;
    
    if (integrator == nil) NSLog(@"ERROR: Choose integrator");
}

-(void)setGravityWithX:(float)x Y:(float)y Z:(float)z
{
    FIVector3DSetXYZ(&gravity, x, y, z);
}

-(void)setGravityWithY:(float)y
{
    FIVector3DSetXYZ(&gravity, 0, y, 0);
}

-(void)tick
{
    [self tickWith:1];
}

-(void)tickWith:(float)t
{
    [integrator step:t];
}

-(TParticle*)makeParticleWithMass:(float)m X:(float)x Y:(float)y Z:(float)z
{
    TParticle* p = [TParticle particelWithMass:m];
    FIVector3DSetXYZ(p.position, x, y, z);
    [particles addObject:p];
    return p;
}

-(TParticle*)makeParticle
{
    return [self makeParticleWithMass:1.0 X:0 Y:0 Z:0];
}

-(TSpring*)makeSpringWithParticle:(TParticle *)a AndParticle:(TParticle *)b Strength:(float)ks Damping:(float)d RestLength:(float)r
{
    TSpring* s = [TSpring springWithParticle:a AndParticle:b SpringConstant:ks Damping:d RestLength:r];
    [springs addObject:s];
    return s;
}

-(TAttraction*)makeAttractionWithParticle:(TParticle *)a AndParticle:(TParticle *)b Strength:(float)k MinDistance:(float)minDistance
{
    TAttraction* m = [TAttraction attractionWithWithParticle:a AndParticle:b Strength:k DistanceMin:minDistance];
    [attractions addObject:m];
    return m;
}

-(void)clear
{
    [particles   removeAllObjects];
    [springs     removeAllObjects];
    [attractions removeAllObjects];
}

-(id)initWithGravity:(float)g Drag:(float)d
{
    if(self = [super init])
    {
        integrator  = [TRungeKuttaIntegrator integratorWithParticleSystem:self];
        particles   = [[NSMutableArray alloc]init];
        springs     = [[NSMutableArray alloc]init];
        attractions = [[NSMutableArray alloc]init];
        gravity     = FIVector3DMAKE(0, g, 0);
        drag        = d;
    }
    return self;
}

-(id)initWithGravityX:(float)gx Y:(float)y Z:(float)z AndDrag:(float)d
{
    if(self = [super init])
    {
        integrator  = [TRungeKuttaIntegrator integratorWithParticleSystem:self];
        particles   = [[NSMutableArray alloc]init];
        springs     = [[NSMutableArray alloc]init];
        attractions = [[NSMutableArray alloc]init];
        gravity     = FIVector3DMAKE(gx, y, z);
        drag        = d;
    }
    return self;
}

-(id)init
{
    if(self = [super init])
    {
        integrator  = [TRungeKuttaIntegrator integratorWithParticleSystem:self];
        particles   = [[NSMutableArray alloc]init];
        springs     = [[NSMutableArray alloc]init];
        attractions = [[NSMutableArray alloc]init];
        gravity     = FIVector3DMAKE(0, TPARTICLESYSTEM_DEFAULT_GRAVITY, 0);
        drag        = TPARTICLESYSTEM_DEFAULT_DRAG;
    }
    return self;
}

+(id)particleSystemWithGravity:(float)g Drag:(float)d
{
    return [[TParticleSystem alloc]initWithGravity:g Drag:d];
}

+(id)particleSystemWithGravityX:(float)gx Y:(float)y Z:(float)z AndDrag:(float)d
{
    return [[TParticleSystem alloc]initWithGravityX:gx Y:y Z:z AndDrag:d];
}

+(id)particleSystem
{
    return [[TParticleSystem alloc]init];
}

-(void)applyForces
{
    if (!FIVector3DIsZero(&gravity))
    {
        for(TParticle* p in particles)
        {
            FIVector3DAddVector3D(p.force, &gravity);
        }
    }
    
    for(TParticle* p in particles)
    {
        FIVector3DAddXYZ(p.force, p.velocity->x * -drag, p.velocity->y * -drag, p.velocity->z * -drag);
    }
    
    for(TSpring* s in springs)
    {
        [s apply];
    }
    
    for(TAttraction* a in attractions)
    {
        [a apply];
    }
    
    //[attractions performSelector:@selector(apply)];
    
    for(id <TForce> c in costumForces)
    {
        [c apply];
    }
}


-(void)clearForces
{
    for(TParticle* p in particles)
    {
        FIVector3DClear(p.force);
    }
}

-(int)numberOfParticles
{
    return (int)[particles count];
}

-(int)numberOfSprings
{
    return (int)[springs count];
}

-(int)numberOfAttractions
{
    return (int)[attractions count];
}

-(TParticle*)particleAt:(int)index
{
    return [particles objectAtIndex:index];
}

-(TSpring*)springAt:(int)index
{
    return [springs objectAtIndex:index];
}

-(TAttraction*)attractionAt:(int)index
{
    return [attractions objectAtIndex:index];
}

-(void)addCostumForce:(id <TForce>)cf;
{
    [costumForces addObject:cf];
}

-(int)numberOfCostumForces
{
    return (int)[costumForces count];
}

-(id <TForce>)forceAt:(int)index
{
    return [costumForces objectAtIndex:index];
}

-(id <TForce>)removeForceAt:(int)index
{
    id <TForce> f = [costumForces objectAtIndex:index];
    [costumForces removeObjectAtIndex:index];
    return f;
}

-(void)removeParticle:(TParticle *)p
{
    [particles removeObject:p];
}

-(TSpring*)removeSpringAtIndex:(int)index
{
    TSpring* s = [springs objectAtIndex:index];
    [springs removeObjectAtIndex:index];
    return s;
}

-(TAttraction*)removeAttractionAtIndex:(int)index
{
    TAttraction* a = [attractions objectAtIndex:index];
    [attractions removeObjectAtIndex:index];
    return a;
}

-(void)removeAttraction:(TAttraction *)a
{
    [attractions removeObject:a];
}

-(void)removeSpring:(TSpring *)s
{
    [springs removeObject:s];
}

-(void)removeCostumForce:(id<TForce>)f
{
    [costumForces removeObject:f];
}






@end
