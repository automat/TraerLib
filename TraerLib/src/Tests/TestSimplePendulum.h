//
//  TestSimplePendulum.h
//  TraerLibrary
//
//  Created by Henryk on 12.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestObject.h"
#import "TParticleSystem.h"
#import "TAnimator.h"
#import "TSmoother.h"

@interface TestSimplePendulum : TestObject
{
    @private
    
    TParticleSystem* physics;
    TParticle*       p;
    TParticle*       anchor;
    TSpring*         spring;
   
}



@end
