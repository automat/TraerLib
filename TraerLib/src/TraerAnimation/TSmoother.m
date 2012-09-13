//
//  TSmoother.m
//  TraerLibrary
//
//  Created by Henryk on 05.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import "TSmoother.h"


@implementation TSmoother

-(id)initWithSmoothness:(float)smoothness
{
    if(self = [super init])
    {
        [self setSmoothness:smoothness];
        [self setValue:0.0];
    }
    return self;
}

-(id)initWithSmoothness:(float)smoothness AndStart:(float)start
{
    if(self = [super init])
    {
        [self setSmoothness:smoothness];
        [self setValue:start];
    }
    return self;
}

-(void)setSmoothness:(float)smoothness
{
    a = -smoothness;
    gain = 1.0 + a;
}

-(void)setTarget:(float)target
{
    input = target;
}

-(void)setValue:(float)x
{
    input = x;
    lastOutput = x;
}

-(float)target
{
    return input;
}

-(void)tick
{
    lastOutput = gain * input - a * lastOutput;
}

-(float) value
{
    return lastOutput;
}

-(NSString*)description
{
    return [@"TSMoother " stringByAppendingFormat:@"value: %.2f",[self value]];
}

@end
