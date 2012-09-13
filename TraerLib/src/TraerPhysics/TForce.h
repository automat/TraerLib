//
//  TForce.h
//  TraerLibrary
//
//  Created by Henryk on 05.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TForce <NSObject>

-(void)turnOn;
-(void)turnOff;
-(BOOL)isOn;
-(BOOL)isOff;
-(void)apply;

@end
