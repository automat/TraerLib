//
//  TSmoother3D.m
//  TraerLibrary
//
//  Created by Henryk on 05.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import "TSmoother3D.h"


@implementation TSmoother3D

-(id)initWithSmoothness:(float)smoothness
{
    if(self = [super init])
    {
        sx = [[TSmoother alloc]initWithSmoothness:smoothness];
        sy = [[TSmoother alloc]initWithSmoothness:smoothness];
        sz = [[TSmoother alloc]initWithSmoothness:smoothness];
    }
    return self;
}

-(id)initWithInitialX:(float)initialX InitialY:(float)initialy InitialZ:(float)initialZ Smoothness:(float)smoothness
{
    if(self = [super init])
    {
        sx = [[TSmoother alloc]initWithSmoothness:smoothness AndStart:initialX];
        sy = [[TSmoother alloc]initWithSmoothness:smoothness AndStart:initialy];
        sz = [[TSmoother alloc]initWithSmoothness:smoothness AndStart:initialZ];
    }
    return self;
}


+(id)smootherWithSmoothness:(float)smoothness
{
    return [[TSmoother3D alloc]initWithSmoothness:smoothness];
}

+(id)smootherWithInitialX:(float)initialX InitialY:(float)initialy InitialZ:(float)initialZ Smoothness:(float)smoothness
{
    return [[TSmoother3D alloc]initWithInitialX:initialX InitialY:initialy InitialZ:initialZ Smoothness:smoothness];
}

-(void)setTargetX:(float)x
{
    [sx setTarget:x];
}

-(void)setTargetY:(float)y
{
    [sy setTarget:y];
}

-(void)setTargetZ:(float)z
{
    [sz setTarget:z];
}

-(float)targetX
{
    return [sx target];
}

-(float)targetY
{
    return [sy target];
}

-(float)targetZ
{
    return [sz target];
}

-(void)setTargetX:(float)x Y:(float)y Z:(float)z
{
    [sx setTarget:x];
    [sy setTarget:y];
    [sz setTarget:z];
}

-(void)setValueX:(float)x Y:(float)y Z:(float)z
{
    [sx setValue:x];
    [sy setValue:y];
    [sz setValue:z];
}

-(void)setX:(float)x
{
    [sx setValue:x];
}

-(void)setY:(float)y
{
    [sy setValue:y];
}

-(void)setZ:(float)z
{
    [sz setValue:z];
}

-(void)setSmoothness:(float)paramFloat
{
    [sx setSmoothness:paramFloat];
    [sy setSmoothness:paramFloat];
    [sz setSmoothness:paramFloat];
}

-(void)tick
{
    [sx tick];
    [sy tick];
    [sz tick];
}

-(float)x
{
    return [sx value];
}

-(float)y
{
    return [sy value];
}

-(float)z
{
    return [sz value];
}

-(NSString*)description
{
    return [@"TSMoother2D " stringByAppendingFormat:@"valueX: %.2f valueY: %.2f valueZ: %.2f",[self x],[self y],[self z]];
}



@end
