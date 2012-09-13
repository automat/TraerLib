//
//  Graph.h
//  TraerLibrary
//
//  Created by Henryk on 12.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TParticleSystem.h"

@class Node;
@class Edge;

@interface Graph : NSObject
{
    NSMutableDictionary* nodeMap;
    
    NSMutableArray* nodes;
    NSMutableArray* edges;
    
    TParticleSystem* ps;
    
    float viewWidth;
    float viewHeight;

}

@property (nonatomic,readwrite, setter = setSelectedNode:) Node* selectedNode;
@property (nonatomic,readwrite, setter = setDragNode:) Node* dragNode;
@property (nonatomic,readwrite, setter = setHoverNode:) Node* hoverNode;

-(Node*)getNodeWithID:(NSString*)ident;
-(void)removeNode:(Node*)n;

-(void)removeEdge:(Edge*)e;
-(Node*)addNewNodeWithID:(NSString*)ident;
-(Node*)addNewNodeWithParent:(Node *)aNode AndID:(NSString*)ident;
-(Edge*)addNewEdgeFrom:(Node*)nodeA To:(Node*)nodeB;

-(id)initWithParticleSystem:(TParticleSystem*)aParticleSystem;
-(id)initWithParticleSystem:(TParticleSystem *)aParticleSystem AndViewRect:(NSSize)rect;
+(id)graphWithParticleSystem:(TParticleSystem*)aParticleSystem;
+(id)graphWithParticleSystem:(TParticleSystem*)aParticleSystem AndViewRect:(NSSize)rect;;

-(void)addNode:(Node*)aNode;
-(void)addEdge:(Edge*)aEdge;

-(void)draw;

//checken wenn partikel aus ps remove dann forces und edges entfernen

-(NSMutableArray*)nodes;



@end
