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

-(void)setup
{
    ps = [TParticleSystem particleSystemWithGravity:0.0 Drag:0.07];
    [ps setIntegrator:TPARTICLESYSTEM_RUNGE_KUTTA];
    
    
    centroid = [TSmoother3D smootherWithSmoothness:0.8];
    [centroid setValueX:0 Y:0 Z:1.0];
    
    g  = [Graph graphWithParticleSystem:ps AndViewRect:NSMakeSize(width, height)];
    
    [self createGraph];
}

-(void)createGraph
{
    Node* anchor = [g addNewNodeWithID:@" "];
    [[anchor particle] makeFixed];
    
    [g setSelectedNode:anchor];
    
    [self generateRandomTreeWithNode:anchor Depth:6 MaxCount:5];
     NSLog(@"Nodes created: %i", (int)[[g nodes]count]);
}

-(void)generateRandomTreeWithNode:(Node*)root Depth:(int)d MaxCount:(int)mc;
{
    if(d <= 0)return;
    int c = fiRandomRange(1,mc);
    Node* n = nil;
    [root setRoot:YES];
    while(c-- > 0)
    {
        n = [g addNewNodeWithParent:root AndID:[NSString stringWithFormat:@"%d",(int)[[g nodes]count]]];
        [n setLabel:fiRandom() > 0.5 ? GROW : CONNECT];
        FIVector3DSetXYZ([[n particle] position], [[root particle] position]->x + (0.01 - (float)fiRandom() * 0.05),
                                                  [[root particle] position]->y + (0.01 - (float)fiRandom() * 0.05),
                                                   0.0);
        
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
    [self updateCentroid];
    
    [centroid tick];
    float scaleValue = fiMin(centroid.z, 1.0);
    glPushMatrix();
    glTranslatef(width*0.5, height*0.5, 0);
    glScalef(scaleValue, scaleValue, 1.0);
    glTranslatef(-centroid.x, -centroid.y, 0);
    [g draw];
    glPopMatrix();
    
    
    
    
}

-(void)updateCentroid
{
    int pcount = (int)[[ps particles]count];
    
    if(pcount == 0)return;
    
    float xMax = -INFINITY;
    float xMin =  INFINITY;
    float yMax = -INFINITY;
    float yMin =  INFINITY;
   
    TParticle* p;
    
    for (int i  = 0; i < pcount; ++i)
    {
        p = [ps particleAt:i];
        xMax = fiMax(xMax, p.position->x);
        xMin = fiMin(xMin, p.position->x);
        yMax = fiMax(yMax, p.position->y);
        yMin = fiMin(yMin, p.position->y);
    }
    
    float deltaX = xMax - xMin;
    float deltaY = yMax - yMin;
    
    if(deltaY > deltaX)
    {
        [centroid setValueX:xMin + deltaX * 0.5 Y:yMin + deltaY * 0.5 Z: height / (deltaY + 50)];
        
    }
    else
    {
        [centroid setValueX:xMin + deltaX * 0.5 Y:yMin + deltaY * 0.5 Z: width / (deltaX + 50)];
    }
    
    
}



-(void)setViewWidth:(float)w Height:(float)h{width = w;height = h;}
-(void)onKeyDown:(NSEvent *)event
{
    char key = [[event characters]characterAtIndex:0];
    switch (key) {
        case ' ':
            
            [g clear];
            [self createGraph];
            break;
            
        default:
            break;
    }

}

-(void)onMouseDown:(NSEvent *)event{}
-(void)onMouseUp:(NSEvent *)event{}
-(void)onMouseDragged:(NSEvent *)event{}
-(void)onMouseMoved:(NSEvent *)event{}

@end
