//
//  Testable.h
//  TraerLibrary
//
//  Created by Henryk on 12.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Testable <NSObject>

-(void)setup;
-(void)update;
-(void)setViewWidth:(float)w;
-(void)setViewHeight:(float)h;
-(void)onKeyDown:(NSEvent*)event;
-(void)onMouseDown:(NSEvent*)event;
-(void)onMouseUp:(NSEvent*)event;
-(void)onMouseDragged:(NSEvent*)event;
-(void)onMouseMoved:(NSEvent*)event;

@end
