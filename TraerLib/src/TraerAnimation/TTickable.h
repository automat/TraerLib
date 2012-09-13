//
//  TTickable.h
//  TraerLibrary
//
//  Created by Henryk on 05.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TTickable <NSObject>

-(void) tick;
-(void) setSmoothness:(float)paramFloat;

@end
