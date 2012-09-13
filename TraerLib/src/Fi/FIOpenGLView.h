//
//  CGCanvasViewGLBasic.h
//  TraerLibrary
//
//  Created by Henryk on 10.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FIGLUtils.h"

@interface FIOpenGLView : NSOpenGLView
{

@protected
    
    FICamera camera;
    
    CFAbsoluteTime time;
    NSTimer*       timer;
    
    GLint currentMatrixMode;
    

@private
    
    GLfloat   _initCamAperture;
    FIVector3D _initCamRotPoint;
    FIVector3D _initCamViewPos;
    FIVector3D _initCamViewDir;
    FIVector3D _initCamViewUp;
    GLfloat   _initCamViewWidth;
    GLfloat   _initCamViewHeight;
    
    BOOL      _cameraSet;
    
    float     _fps;
    
    BOOL      _shouldClear;
    BOOL      _debug;
    BOOL      _debugDrawLoop;
    BOOL      _debugCamera;
    BOOL      _animate;
    
    float     _nearPlane;
    float     _farPlane;
    
    GLfloat _orthographicMatrix[16];
    
    
    
    
}
#pragma mark ---- States ----

-(void)setAnimate:(BOOL)doAnimate;
-(BOOL)animates;
-(void)setClearBuffer:(BOOL)doClear;
-(void)setLog:(BOOL)doLog;
-(void)setLogDrawLoop:(BOOL)doLog;
-(void)setLogCamera:(BOOL)doLog;

-(void)setNearPlane:(float)nvalue AndFarPlane:(float)fValue;

-(void)setOpenGLStates;

#pragma mark ---- Overall Setup ----

-(void)setup;

#pragma mark ---- GL Draw Methods ----

-(void)resizeGL;
-(void)prepareOpenGL;
-(void)beginGL;
-(void)drawGL;
-(void)endGL;

#pragma mark ---- Projection & ModelView Matrix ----

-(void)setProjectionMatrix;
-(void)setModelViewMatrix;
-(void)loadOrthoProjectionMatrix;

#pragma mark ---- Projection Modes ----

-(void)setOrtographicProjection;
-(void)setIsometricProjection;


#pragma mark ---- Camera ----

-(void)setCameraWithViewPosition:(FIVector3D)aViewPosition viewDirection:(FIVector3D)aViewDirection viewUpVector:(FIVector3D)aViewUpVector rotationPoint:(FIVector3D)aRotationPoint
                        aperture:(GLfloat)aAperture viewWidth:(GLfloat)viewWidth viewHeight:(GLfloat)viewHeight;
-(void)resetCamera;

#pragma mark ---- Internal Animation ----

-(void)animationTimer:(NSTimer*)timer;

#pragma mark ---- Singleton Methods ----

+(FIOpenGLView*)sharedView;
+(float)sharedWidth;
+(float)sharedHeight;

#pragma mark ---- ... ----
-(float)width;
-(float)height;
-(void)setFPS:(float)value;
-(float)fps;
-(void)onResize;

@end
