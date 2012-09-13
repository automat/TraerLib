//
//  TAttraction.m
//  TraerLibrary
//
//  Created by Henryk on 06.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import "TAttraction.h"

@implementation TAttraction

-(id)initWithParticle:(TParticle *)pa AndParticle:(TParticle *)pb Strength:(float)ak DistanceMin:(float)dm
{
    if(self = [super init])
    {
        a = pa;
        b = pb;
        k = ak;
        on = YES;
        distanceMin = dm;
        distanceMinSquared = distanceMin * distanceMin;
    }
    return self;
}

+(id)attractionWithWithParticle:(TParticle *)pa AndParticle:(TParticle *)pb Strength:(float)ak DistanceMin:(float)dm
{
    return [[TAttraction alloc]initWithParticle:pa AndParticle:pb Strength:ak DistanceMin:dm];
}

-(void)setA:(TParticle *)p
{
    a = p;
}

-(void)setB:(TParticle *)p
{
    b = p;
}

-(void)setMinimumDistance:(float)d
{
    distanceMin = d;
    distanceMinSquared = distanceMin * distanceMin;
}

-(void)turnOff
{
    on = NO;
}

-(void)turnOn
{
    on = YES;
}

-(void)setStrength:(float)ak
{
    k = ak;
}

-(TParticle*)oneEnd
{
    return a;
}

-(TParticle*)theOtherEnd
{
    return b;
}

-(void)apply
{
    if ( on && ( [a isFree] || [b isFree] ) )
    {
        float a2bX = a.position->x - b.position->x;
        float a2bY = a.position->y - b.position->y;
        float a2bZ = a.position->z - b.position->z;
        
        float a2bDistanceSquared = a2bX*a2bX + a2bY*a2bY + a2bZ*a2bZ;
        
        if ( a2bDistanceSquared < distanceMinSquared )
            a2bDistanceSquared = distanceMinSquared;
        
        float force = k * a.mass * b.mass / a2bDistanceSquared;
        
        float length = sqrtf( a2bDistanceSquared );
        
        // make unit vector
        
        a2bX /= length;
        a2bY /= length;
        a2bZ /= length;
        
        // multiply by force
        
        a2bX *= force;
        a2bY *= force;
        a2bZ *= force;
        
        // apply
        
        if ( [a isFree] )
            FIVector3DAddXYZ(a.force, -a2bX, -a2bY, -a2bZ);
        if ( [b isFree] )
            FIVector3DAddXYZ(b.force,a2bX, a2bY, a2bZ );
    }
}

-(float)strength
{
    return k;
}

-(BOOL)isOn
{
    return on;
}

-(BOOL)isOff
{
    return !on;
}

@end
