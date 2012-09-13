//
//  TSmoother2D.m
//  TraerLibrary
//
//  Created by Henryk on 05.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import "TSmoother2D.h"

@implementation TSmoother2D

-(id)initWithSmoothness:(float)smoothness
{
    if(self = [super init])
    {
        sx = [[TSmoother alloc]initWithSmoothness:smoothness];
        sy = [[TSmoother alloc]initWithSmoothness:smoothness];
    }
    return self;
}

-(id)initWithInitialX:(float)initialX InitialY:(float)initialY Smoothness:(float)smoothness
{
    if(self =  [super init])
    {
        sx = [[TSmoother alloc]initWithSmoothness:smoothness AndStart:initialX];
        sy = [[TSmoother alloc]initWithSmoothness:smoothness AndStart:initialY];
    }
    return self;
}

+(id)smootherWithSmoothness:(float)smoothness
{
    return [[TSmoother2D alloc]initWithSmoothness:smoothness];
}

+(id)smootherInitialX:(float)initialX InitialY:(float)initialY Smoothness:(float)smoothness
{
    return [[TSmoother2D alloc]initWithInitialX:initialX InitialY:initialY Smoothness:smoothness];
}

-(void)setTargetX:(float)x Y:(float)y
{
    [sx setTarget:x];
    [sy setTarget:y];
}

-(void)setValueX:(float)x Y:(float)y
{
    [sx setValue:x];
    [sy setValue:y];
}

-(void)setX:(float)x
{
    [sx setValue:x];
}

-(void)setY:(float)y
{
    [sy setValue:y];
}

-(void)setTargetX:(float)x
{
    [sx setTarget:x];
}

-(void)setTargetY:(float)y
{
    [sy setTarget:y];
}

-(float)targetX
{
    return [sx target];
}

-(float)targetY
{
    return [sy target];
}

-(void)setSmoothness:(float)paramFloat
{
    [sx setSmoothness:paramFloat];
    [sy setSmoothness:paramFloat];
}

-(void)tick
{
    [sx tick];
    [sy tick];
}

-(float)x
{
    return [sx value];
}

-(float)y
{
    return [sy value];
}

-(NSString*)description
{
    return [@"TSMoother2D " stringByAppendingFormat:@"valueX: %.2f valueY: %.2f",[self x],[self y]];
}


@end
