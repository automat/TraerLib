//
//  TSpring.m
//  TraerLibrary
//
//  Created by Henryk on 06.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import "TSpring.h"


@implementation TSpring

-(id)initWithParticle:(TParticle *)pa AndParticle:(TParticle *)pb SpringConstant:(float)ks Damping:(float)d RestLength:(float)r
{
    if(self = [super init])
    {
        springConstant = ks;
        damping        = d;
        restLength     = r;
        a              = pa;
        b              = pb;
        on             = YES;
    }
    return self;
}

+(id)springWithParticle:(TParticle *)pa AndParticle:(TParticle *)pb SpringConstant:(float)ks Damping:(float)d RestLength:(float)r
{
    return [[TSpring alloc]initWithParticle:pa AndParticle:pb SpringConstant:ks Damping:d RestLength:r];
}

-(void)turnOff
{
    on = NO;
}

-(void)turnOn
{
    on = YES;
}

-(BOOL)isOn
{
    return on;
}

-(BOOL)isOff
{
    return !on;
}

-(TParticle*)oneEnd
{
    return a;
}

-(TParticle*)theOtherEnd
{
    return b;
}

-(float)currentLength
{
    return FIVector3DDistanceToVector3D(a.position, b.position);
}

-(float)restLength
{
    return restLength;
}

-(float)strength
{
    return springConstant;
}

-(void)setStrength:(float)ks
{
    springConstant = ks;
}

-(float)damping
{
    return damping;
}

-(void)setDamping:(float)d
{
    damping = d;
}

-(void)setRestLength:(float)l
{
    restLength = l;
}

-(void)apply
{
    if(on && ([a isFree] || [b isFree]))
    {
        float a2bX = a.position->x - b.position->x;
		float a2bY = a.position->y - b.position->y;
		float a2bZ = a.position->z - b.position->z;
		
		float a2bDistance = sqrtf( a2bX*a2bX + a2bY*a2bY + a2bZ*a2bZ );
		
		if ( a2bDistance == 0 )
		{
			a2bX = 0;
			a2bY = 0;
			a2bZ = 0;
		}
		else
		{
			a2bX /= a2bDistance;
			a2bY /= a2bDistance;
			a2bZ /= a2bDistance;
		}
        
        float springForce = -( a2bDistance - restLength ) * springConstant;
       
        float Va2bX = a.velocity->x - b.velocity->x;
		float Va2bY = a.velocity->y - b.velocity->y;
		float Va2bZ = a.velocity->z - b.velocity->z;
        
		float dampingForce = -damping * ( a2bX*Va2bX + a2bY*Va2bY + a2bZ*Va2bZ );
        
        float r = springForce + dampingForce;
		
		a2bX *= r;
		a2bY *= r;
		a2bZ *= r;
	    
		if ( [a isFree] )
            FIVector3DAddXYZ(a.force,a2bX, a2bY, a2bZ );
        if ( [b isFree] )
			FIVector3DAddXYZ(b.force,-a2bX, -a2bY, -a2bZ );
    }
}

-(void)setA:(TParticle *)p
{
    a = p;
}

-(void)setB:(TParticle *)p
{
    b = p;
}

@end
