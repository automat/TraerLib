//
//  TRungeKuttaIntegrator.h
//  TraerLibrary
//
//  Created by Henryk on 06.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TIntegrator.h"
#import "FIMath.h"

@class TParticleSystem;

@interface TVector3DWrapper : NSObject{}
@property FIVector3D vector;
+(TVector3DWrapper*)vector3D;
@end

@interface TRungeKuttaIntegrator : NSObject <TIntegrator>
{
    @private
    
    NSMutableArray* originalPositions;
	NSMutableArray* originalVelocities;
	NSMutableArray* k1Forces;
	NSMutableArray* k1Velocities;
	NSMutableArray* k2Forces;
	NSMutableArray* k2Velocities;
	NSMutableArray* k3Forces;
	NSMutableArray* k3Velocities;
	NSMutableArray* k4Forces;
	NSMutableArray* k4Velocities;
}

@property (nonatomic,readwrite) TParticleSystem* particleSystem;

-(id)initWithParticleSystem:(TParticleSystem*)s;
+(id)integratorWithParticleSystem:(TParticleSystem*)s;

-(void)allocateParticles;

-(void)step:(float)t;

@end
