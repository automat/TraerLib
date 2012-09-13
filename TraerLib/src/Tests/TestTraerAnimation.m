//
//  TestTraerAnimation.m
//  TraerLibrary
//
//  Created by Henryk on 12.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import "TestTraerAnimation.h"
#import "FIMath.h"

@implementation TestTraerAnimation

-(void)setup
{
    a = [TAnimator animatorWithSmoothness:0.9];
    rotator = [a makeSmoother3D];
    fader   = [a makeSmoother];
    delta   = 45;
}
-(void)update
{
    [a tick];
    
    glPushMatrix();
    glTranslatef(width*0.5, height*0.5, 0);
    fiRotateX(rotator.x);
    fiRotateY(rotator.y);
    fiRotateZ(rotator.z);
    fiDrawDebugCubeA(50 * (1 + fader.value),fader.value);
    glPopMatrix();
}

-(void)setViewWidth:(float)w
{
    width = w;
}

-(void)setViewHeight:(float)h
{
    height = h;
}

-(void)onKeyDown:(NSEvent*)theEvent
{
    char key = [[theEvent characters]characterAtIndex:0];
    
    switch (key) {
        case 'x':
            [rotator setTargetX:([rotator targetX] + delta)];
            break;
        case 'y':
            [rotator setTargetY:([rotator targetY] + delta)];
            break;
        case 'z':
            [rotator setTargetZ:([rotator targetZ] + delta)];
            break;
        case 'f':
            if([fader target] == 0)[fader setTarget:1.0];
            else [fader setTarget:0];
        default:
            break;
    }
}



@end
