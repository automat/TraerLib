//
//  EulerIntegrator.h
//  TraerLibrary
//
//  Created by Henryk on 05.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TIntegrator.h"

@class TParticleSystem;

@interface TEulerIntegrator : NSObject <TIntegrator>

@property (nonatomic,readwrite) TParticleSystem* particleSystem;

-(id)initWithParticleSystem:(TParticleSystem*)s;
+(id)integratorWithParticleSystem:(TParticleSystem*)s;

-(void)step:(float)t;


@end
