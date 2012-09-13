//
//  Node.m
//  TraerLibrary
//
//  Created by Henryk on 12.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import "Node.h"
//#import "Fi"


@implementation Node

-(id)initWithParticle:(TParticle *)aParticle Graph:(Graph *)aGraph Ident:(NSString *)aIdent
{
    if(self = [super init])
    {
        p = aParticle;
        g = aGraph;
        ident = aIdent;
        
        
        label = @" ";
        
        lastTouch = 0;
        
        color = FIColorMAKEK(1, 1);
        
        isSelected = false;
        isHovering = false;
        isDragging = false;
    }
    return self;
}

+(id)nodeWithParticle:(TParticle *)aParticle Graph:(Graph *)aGraph Ident:(NSString *)aIdent
{
    return [[Node alloc]initWithParticle:aParticle Graph:aGraph Ident:aIdent];
}

-(NSString*)ID{return ident;}

-(void)setPositionWithX:(float)x Y:(float)y Z:(float)z
{
    [p position]->x = x;
    [p position]->y = y;
    [p position]->z = z;
}

-(BOOL)containsPointWithX:(float)x Y:(float)y
{
    return YES;
}

-(void)setSize:(float)size
{
    h = size;
    w = size;
}

-(float)size
{
    return w;
}

-(void)setLabel:(NSString *)l
{
    label = l;
}

-(NSString*)label
{
    return label;
}

-(float)ageSinceLastTouch
{
    return [p age] - lastTouch;
}

-(void)draw
{
    color = FIColorWHITE();
    fiColor(&color);
    glPushMatrix();
    
    fiDrawCircleWithResolutionVector3D([p position], isRoot ? 6 : 3, 5);
    //fiDrawDebugCube(3);
    glPopMatrix();
    
    //NSLog(@"%@",FIVector3DToNSString([p position]));
}

-(TParticle*)particle{return p;}

-(void)setSelected:(BOOL)b
{
    isSelected = b;
    lastTouch  = [p age];
}

-(void)setHovering:(BOOL)b
{
    isHovering = b;
}

-(void)setDragging:(BOOL)b
{
   lastTouch  = [p age];
    isDragging = b;
    
    if(b)
    {
        [p makeFixed];
    }
    else{
        [p makeFree];
    }
}

-(void)setRoot:(BOOL)b
{
    isRoot = b;
}

@end
