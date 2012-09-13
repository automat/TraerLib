//
//  GraphMain.h
//  TraerLibrary
//
//  Created by Henryk on 12.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestObject.h"
#import "TParticleSystem.h"
#import "Graph.h"
#import "Node.h"
#import "TSmoother3D.h"

@interface GraphMain : TestObject
{
    @private
    
    TParticleSystem* ps;
    Graph* g;
    
    NSString* GROW;
    NSString* CONNECT;
    
    TSmoother3D* centroid;
}

-(void)generateRandomTreeWithNode:(Node*)root Depth:(int)d MaxCount:(int)mc;
-(void)growRandom;

@end
