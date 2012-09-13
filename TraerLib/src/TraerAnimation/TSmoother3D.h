//
//  TSmoother3D.h
//  TraerLibrary
//
//  Created by Henryk on 05.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTickable.h"
#import "TSmoother.h"

@interface TSmoother3D : NSObject <TTickable>
{
    @private
    
    TSmoother* sx;
    TSmoother* sy;
    TSmoother* sz;
}

-(id)initWithSmoothness:(float)smoothness;
-(id)initWithInitialX:(float)initialX InitialY:(float)initialy InitialZ:(float)initialZ Smoothness:(float)smoothness;

+(id)smootherWithSmoothness:(float)smoothness;
+(id)smootherWithInitialX:(float)initialX InitialY:(float)initialy InitialZ:(float)initialZ Smoothness:(float)smoothness;

-(void)setTargetX:(float)x;
-(void)setTargetY:(float)y;
-(void)setTargetZ:(float)z;

-(float)targetX;
-(float)targetY;
-(float)targetZ;

-(void)setTargetX:(float)x Y:(float)y Z:(float)z;
-(void)setValueX:(float)x Y:(float)y Z:(float)z;

-(void)setX:(float)x;
-(void)setY:(float)y;
-(void)setZ:(float)z;

-(void)setSmoothness:(float)paramFloat;

-(void)tick;

-(float)x;
-(float)y;
-(float)z;


@end
