//
//  TSmoother.h
//  TraerLibrary
//
//  Created by Henryk on 05.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTickable.h"

@interface TSmoother : NSObject <TTickable>
{
@private
    float a;
    float gain;
    float lastOutput;
    float input;
}

-(id)initWithSmoothness:(float)smoothness;
-(id)initWithSmoothness:(float)smoothness AndStart:(float)start;

+(id)smootherWithSmoothness:(float)smoothness;
+(id)smootherWithSmoothness:(float)smoothness AndStart:(float)start;

-(void)setSmoothness:(float)smoothness;
-(void)setTarget:(float)target;
-(void)setValue:(float)x;

-(float)target;

-(void)tick;

-(float)value;

-(NSString*)description;

@end
