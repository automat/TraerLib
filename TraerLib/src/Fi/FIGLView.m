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
        [t setViewWidth: [self width]];
        [t setViewHeight:[self height]];
        
        [t setup];
    }
    
    

    testIndex = 3;
    
    
}

-(void)drawGL
{
    [self setOrtographicProjection];
   
    [[tests objectAtIndex:testIndex]update];
}

-(void)keyDown:(NSEvent *)theEvent
{
    [[tests objectAtIndex:testIndex]onKeyDown:theEvent];
}

-(void)mouseDown:(NSEvent *)theEvent{[[tests objectAtIndex:testIndex]onMouseDown:theEvent];}
-(void)mouseUp:(NSEvent *)theEvent{[[tests objectAtIndex:testIndex]onMouseUp:theEvent];}
-(void)mouseDragged:(NSEvent *)theEvent{[[tests objectAtIndex:testIndex]onMouseDragged:theEvent];}
-(void)mouseMoved:(NSEvent *)theEvent{[[tests objectAtIndex:testIndex]onMouseMoved:theEvent];}


-(void)onResize
{
    [[tests objectAtIndex:testIndex]setViewWidth:[self width]];
    [[tests objectAtIndex:testIndex]setViewHeight:[self height]];
}

@end
