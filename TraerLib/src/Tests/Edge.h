//
//  Edge.h
//  TraerLibrary
//
//  Created by Henryk on 12.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSpring.h"
#import "FIGLUtils.h"

@class Node;
@class Graph;

@interface Edge : NSObject
{
    @private
    
    TSpring*  s;
    NSString* label;
    FIColor   color;
    Graph*    graph;
    Node*     a;
    Node*     b;
}

-(void)setLabelWith:(NSString*)aString;
-(void)setColorWith:(FIColor)aColor;
-(void)draw;

-(id)initWithNodeA:(Node*)aNodeA NodeB:(Node*)aNodeB Spring:(TSpring*)aSpring Graph:(Graph*)aGraph;
+(id)edgeWithNodeA:(Node*)aNodeA NodeB:(Node*)aNodeB Spring:(TSpring*)aSpring Graph:(Graph*)aGraph;


@end
