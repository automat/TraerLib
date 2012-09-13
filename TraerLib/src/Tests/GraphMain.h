//
//  GraphMain.h
//  TraerLibrary
//
//  Created by Henryk on 12.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Testable.h"
#import "TParticleSystem.h"
#import "Graph.h"
#import "Node.h"

@interface GraphMain : NSObject <Testable>
{
    @private
    
    TParticleSystem* ps;
    Graph* g;
    
    NSString* GROW;
    NSString* CONNECT;
    
    float width;
    float height;
}

-(void)generateRandomTreeWithNode:(Node*)root Depth:(int)d MaxCount:(int)mc;
-(void)growRandom;

@end
