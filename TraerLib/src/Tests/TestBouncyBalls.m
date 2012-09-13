//
//  TestBouncyBalls.m
//  TraerLibrary
//
//  Created by Henryk on 13.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import "TestBouncyBalls.h"

@implementation TestBouncyBalls

-(void)setup
{
    physics = [TParticleSystem particleSystem];
    mouse   = [physics makeParticleWithMass:1.0 X:fiRandomRange(0, width) Y:fiRandomRange(0, height) Z:0];
    [mouse makeFixed];
    
    b = [physics makeParticleWithMass:1 X:fiRandomRange(0, width) Y:fiRandomRange(0, height) Z:0];
    c = [physics makeParticleWithMass:1 X:fiRandomRange(0, width) Y:fiRandomRange(0, height) Z:0];
    
    [physics makeAttractionWithParticle:mouse AndParticle:b Strength:10000  MinDistance:10];
    [physics makeAttractionWithParticle:mouse AndParticle:c Strength:10000  MinDistance:10];
    [physics makeAttractionWithParticle:b     AndParticle:c Strength:-10000 MinDistance:10];
    
    maxVel = 1;
    
}

-(void)update
{
    int i = 0;
    
    TParticle* p;
    
    while(++i < [[physics particles]count])
    {
        p = [physics particleAt:i];
        [self handleBoundaryCollisions:p];
        fiConstrainRange(p.velocity->x,-maxVel, maxVel);
        fiConstrainRange(p.velocity->y,-maxVel, maxVel);
        
        
    }
    
    [physics tick];
    
    FIColor color = FIColorBRIGHTBEIGE();
    fiColor(&color);
    fiDrawCircleWithResolutionVector3D(mouse.position, 30, 10);
    
    
    fiDrawCircleWithResolutionVector3D(b.position, 30, 10);
    fiDrawCircleWithResolutionVector3D(c.position, 30, 10);
}

-(void)onMouseDragged:(NSEvent *)event
{
    NSPoint mp = [event locationInWindow];
    FIVector3DSetXYZ([mouse position], mp.x, height-mp.y, 0);
}

-(void)handleBoundaryCollisions:(TParticle*)p
{
    if(p.position->x < 0 || p.position->x > width)
    {
        FIVector3DSetXYZ(p.velocity, -0.9*p.velocity->x, p.velocity->y, 0);
    }
    if(p.position->y < 0 || p.position->y > height)
    {
        FIVector3DSetXYZ(p.velocity, p.velocity->x, -0.9*p.velocity->y, 0);
    }
    
    fiConstrain(p.position->x, width);
    fiConstrain(p.position->y, height);
}



@end
