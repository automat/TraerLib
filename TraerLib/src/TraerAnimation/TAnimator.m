//
//  TAnimator.m
//  TraerLibrary
//
//  Created by Henryk on 05.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import "TAnimator.h"

@implementation TAnimator

-(id)initWithSmoothness:(float)value
{
    if(self = [super init])
    {
        smoothness = value;
        smoothers = [[NSMutableArray alloc]init];
    }
    return self;
}

+(id)animatorWithSmoothness:(float)value
{
    return [[TAnimator alloc]initWithSmoothness:value];
}

-(TSmoother*)makeSmoother
{
    TSmoother* s = [[TSmoother alloc]initWithSmoothness:smoothness];
    [smoothers addObject:s];
    return s;
}

-(TSmoother2D*)makeSmoother2D
{
    TSmoother2D* s = [[TSmoother2D alloc]initWithSmoothness:smoothness];
    [smoothers addObject:s];
    return s;
}

-(TSmoother3D*)makeSmoother3D
{
    TSmoother3D* s = [[TSmoother3D alloc]initWithSmoothness:smoothness];
    [smoothers addObject:s];
    return s;
}

-(void)tick
{
    for (id <TTickable> s in smoothers)
    {
        [s tick];
    }
}

-(void)setSmoothness:(float)paramFloat
{
    for(id <TTickable> s in smoothers)
    {
        [s setSmoothness:paramFloat];
    }
}

@end
