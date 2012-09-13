//
//  Node.h
//  TraerLibrary
//
//  Created by Henryk on 12.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TParticle.h"
#import "FIGLUtils.h"

@class Graph;

@interface Node : NSObject
{
    @private
    
    TParticle* p;
    NSString*  label;
    NSString*  ident;
    int        w;
    int        h;
    
    FIColor    color;
    
    BOOL       isSelected;
    BOOL       isHovering;
    BOOL       isDragging;
    
    Graph*     g;
    
    float      lastTouch;
    
    BOOL       isRoot;
}

-(id)initWithParticle:(TParticle*)aParticle Graph:(Graph*)aGraph Ident:(NSString*)aIdent;
+(id)nodeWithParticle:(TParticle*)aParticle Graph:(Graph*)aGraph Ident:(NSString*)aIdent;

-(NSString*)ID;
-(void)setPositionWithX:(float)x Y:(float)y Z:(float)z;
-(BOOL)containsPointWithX:(float)x Y:(float)y;
-(void)setSize:(float)size;
-(float)size;
-(void)setLabel:(NSString*)l;
-(NSString*)label;
-(float)ageSinceLastTouch;

-(void)draw;
-(TParticle*)particle;

-(void)setSelected:(BOOL)b;
-(void)setHovering:(BOOL)b;
-(void)setDragging:(BOOL)b;

-(void)setRoot:(BOOL)b;
@end
