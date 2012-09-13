//
//  TestBouncyBalls.h
//  TraerLibrary
//
//  Created by Henryk on 13.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestObject.h"
#import "TParticleSystem.h"
#import "TParticle.h"
#import "FIGLUtils.h"
#import "FIMath.h"

@interface TestBouncyBalls : TestObject
{
    @private
    
    TParticleSystem* physics;
    TParticle*       mouse;
    TParticle*       b;
    TParticle*       c;
    
    float maxVel;
}



@end
