//
//  CGGLView.m
//  TraerLibrary
//
//  Created by Henryk on 11.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import "FIGLView.h"
#import "TestTraerAnimation.h"
#import "TestSimplePendulum.h"
#import "TestBouncyBalls.h"

#import "GraphMain.h"

@implementation FIGLView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)setup
{
    [self setFPS:55.0f];
    [self setLog:YES];
    [self setLogDrawLoop:NO];
    [self setAnimate:YES];
    [self setClearBuffer:YES];
    
    tests = [[NSMutableArray alloc]init];
    [tests addObject:[[TestTraerAnimation alloc]init]]; //0 TraerAnimation
    [tests addObject:[[TestSimplePendulum alloc]init]]; //1 TraerPhysics
    [tests addObject:[[TestBouncyBalls    alloc]init]]; //2
    [tests addObject:[[GraphMain    alloc]init]];
    
    for(id <Testable> t in tests)
    {
        [t setViewWidth:[self width]Height:[self height]];
        
        [t setup];
    }
    
    testIndex = 1;
    
    currTest = [tests objectAtIndex:testIndex];
    
    
}

-(void)drawGL
{
    [self setOrtographicProjection];
   
    [currTest update];
}

-(void)keyDown:(NSEvent *)theEvent     {[currTest onKeyDown:theEvent];}
-(void)mouseDown:(NSEvent *)theEvent   {[currTest onMouseDown:theEvent];}
-(void)mouseUp:(NSEvent *)theEvent     {[currTest onMouseUp:theEvent];}
-(void)mouseDragged:(NSEvent *)theEvent{[currTest onMouseDragged:theEvent];}
-(void)mouseMoved:(NSEvent *)theEvent  {[currTest onMouseMoved:theEvent];}
-(void)onResize                        {[currTest setViewWidth:[self width]Height:[self height]];
                                        [currTest onResize];}

@end
