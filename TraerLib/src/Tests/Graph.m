//
//  Graph.m
//  TraerLibrary
//
//  Created by Henryk on 12.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import "Graph.h"
#import "Node.h"
#import "Edge.h"

static const float DEFAULT_SPRING_CONSTANT = 0.5;
static const float DEFAULT_DAMPING_CONSTANT = .2;
static const int   DEFAULT_RESTLENGTH = 2;

static const float DEFAULT_SPRING_CONSTANT_PARENT = .2;
static const float DEFAULT_DAMPING_CONSTANT_PARENT = .2;
static const int   DEFAULT_RESTLENGTH_PARENT = 2;

static const int   DEFAULT_MAGNET_CONSTANT = -200;
static const int   DEFAULT_MAGNET_DISTANCE = 10;

static const float SET_SPRING_CONSTANT = 0.5;
static const float SET_DAMPING_CONSTANT = .2;
static const int   SET_RESTLENGTH = 2;

static const float SET_SPRING_CONSTANT_PARENT = .2;
static const float SET_DAMPING_CONSTANT_PARENT = .2;
static const int   SET_RESTLENGTH_PARENT = 2;

static const int   SET_MAGNET_CONSTANT = -2000;
static const int   SET_MAGNET_DISTANCE = 5;


@implementation Graph

@synthesize selectedNode;
@synthesize dragNode;
@synthesize hoverNode;

-(Node*)getNodeWithID:(NSString *)ident
{
    return [nodeMap objectForKey:ident];
}

-(void)clear
{
    selectedNode = nil;
    hoverNode    = nil;
    dragNode     = nil;
    
    [edges removeAllObjects];
    [nodes removeAllObjects];
    [nodeMap removeAllObjects];
    [ps clear];
    
}

-(void)removeNode:(Node *)n
{
    [nodes removeObject:n];
    [nodeMap removeObjectForKey:[n ID]];
    //[[n particle] kill];
    [ps removeParticle:[n particle]];
    if(selectedNode == n)selectedNode = nil;
    if(hoverNode    == n)hoverNode    = nil;
    if(dragNode     == n)dragNode     = nil;
}

-(void)removeEdge:(Edge*)e
{
    [edges removeObject:e];
}

-(Node*)addNewNodeWithID:(NSString *)ident
{
    TParticle* p = [ps makeParticleWithMass:1.0 X:viewWidth * 0.5 Y:viewHeight * 0.5 Z:0];
    Node* n = [Node nodeWithParticle:p Graph:self Ident:ident];
    [self addNode:n];
    return n;
}

-(Node*)addNewNodeWithParent:(Node *)aNode AndID:(NSString *)ident
{
    TParticle* p = [ps makeParticleWithMass:1.0 X:viewWidth * 0.5 Y:viewHeight * 0.5 Z:0];
    Node* n      = [Node nodeWithParticle:p Graph:self Ident:ident];
    [self addNode:n];
    [self addNewEdgeFrom:aNode To:n];
    
    int j = -1;
    while (++j < [nodes count])
    {
        if([nodes objectAtIndex:j] != n)[ps makeAttractionWithParticle:p AndParticle:[[nodes objectAtIndex:j]particle] Strength:SET_MAGNET_CONSTANT MinDistance:SET_MAGNET_DISTANCE];
    }
    return n;
}

-(Edge*)addNewEdgeFrom:(Node *)nodeA To:(Node *)nodeB
{
    TSpring* s = [ps makeSpringWithParticle:[nodeA particle] AndParticle:[nodeB particle] Strength:SET_SPRING_CONSTANT_PARENT Damping:SET_DAMPING_CONSTANT_PARENT RestLength:SET_RESTLENGTH_PARENT];
    Edge*    e = [Edge edgeWithNodeA:nodeA NodeB:nodeB Spring:s Graph:self];
    [self addEdge:e];
    
    return e;
}

-(id)initWithParticleSystem:(TParticleSystem *)aParticleSystem
{
    if(self = [super init])
    {
        ps = aParticleSystem;
        nodes   = [NSMutableArray array];
        edges   = [NSMutableArray array];
        nodeMap = [NSMutableDictionary dictionary];
        
        viewWidth  = 100;
        viewHeight = 100;
    }
    return self;
}

-(id)initWithParticleSystem:(TParticleSystem *)aParticleSystem AndViewRect:(NSSize)rect
{
    if(self = [super init])
    {
        ps = aParticleSystem;
        nodes   = [NSMutableArray array];
        edges   = [NSMutableArray array];
        nodeMap = [NSMutableDictionary dictionary];
        
        viewWidth  = rect.width;
        viewHeight = rect.height;
    }
    return self;
}

+(id)graphWithParticleSystem:(TParticleSystem *)aParticleSystem
{
    return [[Graph alloc]initWithParticleSystem:aParticleSystem];
}

+(id)graphWithParticleSystem:(TParticleSystem *)aParticleSystem AndViewRect:(NSSize)rect
{
    return [[Graph alloc]initWithParticleSystem:aParticleSystem AndViewRect:rect];
}

-(void)addNode:(Node *)aNode
{
    [nodes addObject:aNode];
    [nodeMap setObject:aNode forKey:[aNode ID]];
}

-(void)addEdge:(Edge *)aEdge
{
    [edges addObject:aEdge];
}

-(void)draw
{
    for (Edge* e in edges)
    {
        [e draw];
    }
    
    for(Node* n in nodes)
    {
        [n draw];
    }
}

-(NSMutableArray*)nodes
{
    return nodes;
}


-(void)setSelectedNode:(Node *)sNode
{
    if(selectedNode != nil)[selectedNode setSelected:NO];
    
    selectedNode = sNode;
    
    if(sNode != nil)[sNode setSelected:YES];
}

-(void)setDragNode:(Node *)dNode
{
    if (dragNode != nil) {
        [dragNode setDragging:NO];
    }
    
    dragNode = dNode;
    
    if (dNode != nil)
        [dNode setDragging:YES];
}

-(void)setHoverNode:(Node *)hNode
{
    if (hoverNode != nil) {
        [dragNode setHovering:NO];
    }
    
    hoverNode = hNode;
    
    if (hNode != nil)
        [hNode setHovering:YES];
}



@end
