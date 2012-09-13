//
//  TAnimator.h
//  TraerLibrary
//
//  Created by Henryk on 05.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTickable.h"
#import "TSmoother.h"
#import "TSmoother2D.h"
#import "TSmoother3D.h"

@interface TAnimator : NSObject <TTickable>
{
    @private
    
    NSMutableArray* smoothers;
    float smoothness;
}

-(id)initWithSmoothness:(float)value;
+(id)animatorWithSmoothness:(float)value;
-(TSmoother*)makeSmoother;
-(TSmoother2D*)makeSmoother2D;
-(TSmoother3D*)makeSmoother3D;

-(void)tick;

-(void)setSmoothness:(float)paramFloat;





@end
