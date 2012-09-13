//
//  TAttraction.h
//  TraerLibrary
//
//  Created by Henryk on 06.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TForce.h"
#import "TParticle.h"

@interface TAttraction : NSObject <TForce>
{
    @private
    
    TParticle* a;
    TParticle* b;
    
    float k;
    BOOL on;
    float distanceMin;
    float distanceMinSquared;
}

-(id)initWithParticle:(TParticle*)pa AndParticle:(TParticle*)pb Strength:(float)ak DistanceMin:(float)dm;
+(id)attractionWithWithParticle:(TParticle*)pa AndParticle:(TParticle*)pb Strength:(float)ak DistanceMin:(float)dm;

-(void)setA:(TParticle*)p;
-(void)setB:(TParticle*)p;

-(void)setMinimumDistance:(float)d;

-(void)turnOff;
-(void)turnOn;

-(void)setStrength:(float)ak;

-(TParticle*)oneEnd;
-(TParticle*)theOtherEnd;

-(void)apply;

-(float)strength;

-(BOOL)isOn;
-(BOOL)isOff;


@end
