//
//  TSmoother2D.h
//  TraerLibrary
//
//  Created by Henryk on 05.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSmoother.h"
#import "TTickable.h"

@interface TSmoother2D : NSObject <TTickable>
{
    @private
    
    TSmoother* sx;
    TSmoother* sy;
}

-(id)initWithSmoothness:(float)smoothness;
-(id)initWithInitialX:(float)initialX InitialY:(float)initialY Smoothness:(float)smoothness;

+(id)smootherWithSmoothness:(float)smoothness;
+(id)smootherInitialX:(float)initialX InitialY:(float)initialY Smoothness:(float)smoothness;

-(void)setTargetX:(float)x Y:(float)y;
-(void)setValueX:(float)x Y:(float)y;
-(void)setX:(float)x;
-(void)setY:(float)y;
-(void)setTargetX:(float)x;
-(void)setTargetY:(float)y;
-(float)targetX;
-(float)targetY;

-(void)setSmoothness:(float)paramFloat;
-(void)tick;

-(float)x;
-(float)y;

-(NSString*)description;

@end
