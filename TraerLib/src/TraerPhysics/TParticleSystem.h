//
//  TParticleSystem.h
//  TraerLibrary
//
//  Created by Henryk on 05.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TIntegrator.h"
#import "FIMath.h"
#import "TForce.h"


@class TParticle;
@class TSpring;
@class TAttraction;

#define TPARTICLESYSTEM_RUNGE_KUTTA 0
#define TPARTICLESYSTEM_MODIFIED_EULER 1
#define TPARTICLESYSTEM_EULER 3

#define TPARTICLESYSTEM_DEFAULT_GRAVITY 0.0
#define TPARTICLESYSTEM_DEFAULT_DRAG 0.001


@interface TParticleSystem : NSObject
{
    @protected
    
    id <TIntegrator> integrator;
}

@property (nonatomic,readwrite) NSMutableArray* particles;
@property (nonatomic,readwrite) NSMutableArray* springs;
@property (nonatomic,readwrite) NSMutableArray* attractions;
@property (nonatomic,readwrite) NSMutableArray* costumForces;

@property FIVector3D gravity;
@property float     drag;

@property BOOL hasDeadParticles;

-(void)setIntegrator:(int)i;
-(void)setGravityWithX:(float)x Y:(float)y Z:(float)z;
-(void)setGravityWithY:(float)y;

-(void)tick;
-(void)tickWith:(float)t;

-(TParticle*)makeParticleWithMass:(float)m X:(float)x Y:(float)y Z:(float)z;
-(TParticle*)makeParticle;

-(TSpring*)makeSpringWithParticle:(TParticle*)a AndParticle:(TParticle*)b Strength:(float)ks Damping:(float)d RestLength:(float)r;

-(TAttraction*)makeAttractionWithParticle:(TParticle*)a AndParticle:(TParticle*)b Strength:(float)k MinDistance:(float)minDistance;

-(void)clear;

-(id)initWithGravity:(float)g Drag:(float)d;
-(id)initWithGravityX:(float)gx Y:(float)y Z:(float)z AndDrag:(float)d;
-(id)init;

+(id)particleSystemWithGravity:(float)g Drag:(float)d;
+(id)particleSystemWithGravityX:(float)gx Y:(float)y Z:(float)z AndDrag:(float)d;
+(id)particleSystem;

-(void)applyForces;
-(void)clearForces;

-(int)numberOfParticles;
-(int)numberOfSprings;
-(int)numberOfAttractions;

-(TParticle*)particleAt:(int)index;
-(TSpring*)springAt:(int)index;
-(TAttraction*)attractionAt:(int)index;

-(void)addCostumForce:(id <TForce>)cf;
-(int)numberOfCostumForces;

-(id <TForce>)forceAt:(int)index;
-(id <TForce>)removeForceAt:(int)index;

-(void)removeParticle:(TParticle*)p;
-(TSpring*)removeSpringAtIndex:(int)index;
-(TAttraction*)removeAttractionAtIndex:(int)index;
-(void)removeAttraction:(TAttraction*)a;
-(void)removeSpring:(TSpring*)s;
-(void)removeCostumForce:(id <TForce>)f;



@end
