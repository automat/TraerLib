//
//  TestTraerAnimation.h
//  TraerLibrary
//
//  Created by Henryk on 12.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestObject.h"
#import "FIGLUtils.h"
#import "TAnimator.h"
#import "TSmoother.h"
#import "TSmoother3D.h"

@interface TestTraerAnimation : TestObject
{
    @private
    
    TSmoother*   fader;
    TSmoother3D* rotator;
    TAnimator*   a;
    float        delta;
  
}

@end
