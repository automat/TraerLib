//
//  TModifiedEulerIntegrator.h
//  TraerLibrary
//
//  Created by Henryk on 06.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TIntegrator.h"

@class TParticleSystem;

@interface TModifiedEulerIntegrator : NSObject <TIntegrator>

@property (nonatomic,readwrite) TParticleSystem* particleSystem;

-(id)initWithParticleSystem:(TParticleSystem*)s;
+(id)integratorWithParticleSystem:(TParticleSystem*)s;

-(void)step:(float)t;

@end
