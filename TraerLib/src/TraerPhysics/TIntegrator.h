//
//  TIntegrator.h
//  TraerLibrary
//
//  Created by Henryk on 05.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TParticleSystem;

@protocol TIntegrator <NSObject>

+(id)integratorWithParticleSystem:(TParticleSystem*)s;
-(void)step:(float)t;



@end
