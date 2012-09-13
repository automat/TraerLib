//
//  TSpring.h
//  TraerLibrary
//
//  Created by Henryk on 06.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TForce.h"
#import "TParticle.h"



@interface TSpring : NSObject <TForce>
{
    @private
    
    float springConstant;
    float damping;
    float restLength;
    
    TParticle* a;
    TParticle* b;
    
    BOOL on;
}

-(id)initWithParticle:(TParticle*)pa AndParticle:(TParticle*)pb SpringConstant:(float)ks Damping:(float)d RestLength:(float)r;
+(id)springWithParticle:(TParticle*)pa AndParticle:(TParticle*)pb SpringConstant:(float)ks Damping:(float)d RestLength:(float)r;

-(void)turnOff;
-(void)turnOn;

-(BOOL)isOn;
-(BOOL)isOff;

-(TParticle*)oneEnd;
-(TParticle*)theOtherEnd;

-(float)currentLength;
-(float)restLength;

-(float)strength;
-(void)setStrength:(float)ks;

-(float)damping;
-(void)setDamping:(float)d;

-(void)setRestLength:(float)l;

-(void)apply;

-(void)setA:(TParticle*) p;
-(void)setB:(TParticle*) p;

@end
