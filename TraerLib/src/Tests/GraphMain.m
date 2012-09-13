//
//  GraphMain.m
//  TraerLibrary
//
//  Created by Henryk on 12.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import "GraphMain.h"
#import "FIMath.h"



@implementation GraphMain

-(id)init
{
    if(self = [super init])
    {
        
    }
    return self;
}

-(void)setup
{
    ps = [TParticleSystem particleSystemWithGravity:0.0 Drag:0.07];
    [ps setIntegrator:TPARTICLESYSTEM_RUNGE_KUTTA];
    g  = [Graph graphWithParticleSystem:ps AndViewRect:NSMakeSize(width, height)];
    
    Node* anchor = [g addNewNodeWithID:@" "];
    [[anchor particle] makeFixed];
    
    [g setSelectedNode:anchor];
    
    [self generateRandomTreeWithNode:anchor Depth:3 MaxCount:10];
}

-(void)generateRandomTreeWithNode:(Node*)root Depth:(int)d MaxCount:(int)mc;
{
    if(d <= 0)return;
    int c = fiRandomRange(1,mc);
    Node* n = nil;
    while(c-- > 0)
    {
        n = [g addNewNodeWithParent:root AndID:[NSString stringWithFormat:@"%d",(int)[[g nodes]count]]];
        [n setLabel:fiRandom() > 0.5 ? GROW : CONNECT];
        FIVector3DSetXYZ([[n particle] position], [[root particle] position]->x + (0.01 - (float)fiRandom() * 0.05),
                                                  [[root particle] position]->y + (0.01 - (float)fiRandom() * 0.05),
                                                   0.0);
        NSLog(@"%@",n);
        [self generateRandomTreeWithNode:n Depth:d-1 MaxCount:mc];
        
    }
    if(n != nil)
    {
        [g setSelectedNode:n];
    }
}

-(void)growRandom
{
    if([g selectedNode] != nil)
    {
        [self generateRandomTreeWithNode:[g selectedNode] Depth:1 MaxCount:4];
    }
    else
    {
        Node* a = [g addNewNodeWithID:@" "];
        [[a particle]makeFixed];
        
        [g setSelectedNode:a];
        [self generateRandomTreeWithNode:a Depth:3 MaxCount:4];
    }
}

-(void)update
{
    [ps tickWith:0.5];
    [g draw];
}
-(void)setViewWidth:(float)w{width = w;};
-(void)setViewHeight:(float)h{height = h;};
-(void)onKeyDown:(NSEvent *)event{}
-(void)onMouseDown:(NSEvent *)event{}
-(void)onMouseUp:(NSEvent *)event{}
-(void)onMouseDragged:(NSEvent *)event{}
-(void)onMouseMoved:(NSEvent *)event{}

@end
