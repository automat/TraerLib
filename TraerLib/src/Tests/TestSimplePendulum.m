//
//  TestSimplePendulum.m
//  TraerLibrary
//
//  Created by Henryk on 12.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import "TestSimplePendulum.h"
#import "TParticle.h"
#import "FIGLUtils.h"

@implementation TestSimplePendulum

-(void)setup
{
    physics = [TParticleSystem particleSystemWithGravity:5 Drag:0.2];
    [physics setIntegrator:TPARTICLESYSTEM_RUNGE_KUTTA];
    p       = [physics makeParticleWithMass:1.0 X:width*0.5 Y:height*0.5 Z:0];
    anchor  = [physics makeParticleWithMass:1.0 X:width*0.5 Y:height*0.5 Z:0];
    [anchor makeFixed];
    
    spring  = [physics makeSpringWithParticle:p AndParticle:anchor Strength:0.1 Damping:0.8 RestLength:100];
}

-(void)update
{
    [physics tick];
    
    
    FIColor color = FIColorMAKEK(0.5, 1);
    
    fiColor(&color);
    fiDrawLineVector3D([p position], [anchor position]);
    
    
    color = FIColorBRIGHTBEIGE();
    fiColor(&color);
    fiDrawCircleWithResolutionVector3D([anchor position], 5, 10);
    
    glPushMatrix();
    fiTranslate([p position]);
    glRotatef(90, 0, 1, 1);
    fiDrawDebugCube(30);
    glPopMatrix();
    
}

-(void)setViewWidth:(float)w{width = w;}
-(void)setViewHeight:(float)h{height = h;}

-(void)onKeyDown:(NSEvent *)event{}

-(void)onMouseDown:(NSEvent *)event
{
    NSPoint mp = [event locationInWindow];
    [p makeFixed];
    FIVector3DSetXYZ([p position], mp.x,height-mp.y, 0.0);
}

-(void)onMouseUp:(NSEvent *)event
{
    [p makeFree];
}

-(void)onMouseDragged:(NSEvent *)event
{
    NSPoint mp = [event locationInWindow];
    FIVector3DSetXYZ([p position], mp.x, height-mp.y, 0.0);
}

@end
