//
//  Edge.m
//  TraerLibrary
//
//  Created by Henryk on 12.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import "Edge.h"
#import "Node.h"

@implementation Edge

-(void)setLabelWith:(NSString *)aString
{
    label = aString;
}

-(void)setColorWith:(FIColor)aColor
{
    color = aColor;
}



-(id)initWithNodeA:(Node *)aNodeA NodeB:(Node *)aNodeB Spring:(TSpring *)aSpring Graph:(Graph *)aGraph
{
    if(self = [super init])
    {
        a     = aNodeA;
        b     = aNodeB;
        s     = aSpring;
        graph = aGraph;
        
        label = @" ";
        
        color = FIColorMAKEK(0.5, 1);
    }
    return self;
}

+(id)edgeWithNodeA:(Node *)aNodeA NodeB:(Node *)aNodeB Spring:(TSpring *)aSpring Graph:(Graph *)aGraph
{
    return [[Edge alloc]initWithNodeA:aNodeA NodeB:aNodeB Spring:aSpring Graph:aGraph];
}

-(void)draw
{
    color = FIColorBLACK();
    fiColor(&color);
    fiDrawLineVector3D([[a particle] position], [[b particle] position]);
}

@end
