//
//  CGCanvasViewGLBasic.m
//  TraerLibrary
//
//  Created by Henryk on 10.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import "FIOpenGLView.h"

#pragma mark ---- Internal FPS Timer ----

static CFAbsoluteTime startTime = 0.0f;
static void starStartTime(void){startTime = CFAbsoluteTimeGetCurrent ();}
static CFAbsoluteTime getElapsedTime(void){return CFAbsoluteTimeGetCurrent () - startTime;}

static const float DEFAULT_NEAR_PLANE = -200;
static const float DEFAULT_FAR_PLANE  = 200;

@implementation FIOpenGLView

#pragma mark ---- Class ----

- (id)initWithFrame:(NSRect)frame
{
    NSOpenGLPixelFormatAttribute attributes [] = {
        NSOpenGLPFAWindow,
        NSOpenGLPFADoubleBuffer,
        NSOpenGLPFADepthSize, (NSOpenGLPixelFormatAttribute)16, 
        /*Anti-Aliasing*/
        NSOpenGLPFAAccelerated,
        NSOpenGLPFAMultisample,
        NSOpenGLPFASupersample,
        NSOpenGLPFASampleBuffers, (NSOpenGLPixelFormatAttribute)1,
        NSOpenGLPFASamples, (NSOpenGLPixelFormatAttribute)4,
        (NSOpenGLPixelFormatAttribute)nil
    };
    
    
    NSOpenGLPixelFormat* pf = [[NSOpenGLPixelFormat alloc] initWithAttributes:attributes];
    
    self = [super initWithFrame:frame pixelFormat:pf];
    return self;
}

#pragma mark ---- States ----

-(void)setAnimate:(BOOL)doAnimate{_animate = doAnimate;};

-(BOOL)animates{return _animate;}

-(void)setClearBuffer:(BOOL)doClear{_shouldClear = doClear;}

-(void)setLog:(BOOL)doLog{_debug = doLog;}

-(void)setLogDrawLoop:(BOOL)doLog{_debugDrawLoop = doLog;}

-(void)setLogCamera:(BOOL)doLog{_debugCamera = doLog;}

-(void)setFPS:(float)value{_fps = 1/value;};

-(float)fps{return _fps;}

-(void)setNearPlane:(float)nvalue AndFarPlane:(float)fValue{_nearPlane = nvalue;_farPlane = fValue;}

#pragma mark ---- Overall Setup ----

//BASIC SETUP - OVERRIDE 
-(void)setup
{
    [self setFPS:33.0f];
    [self setLog:YES];
    [self setLogDrawLoop:NO];
    [self setAnimate:YES];
    [self setClearBuffer:YES];
   
    if(_debug)NSLog(@"CGCanvasViewBasicGL: Setup");
}

#pragma mark ---- GL Draw Methods ----

-(void)resizeGL
{
    NSRect rectView = [self bounds];
    
    if(camera.viewHeight != rectView.size.height || camera.viewWidth != rectView.size.width)
    {
        camera.viewHeight = rectView.size.height;
        camera.viewWidth  = rectView.size.width;
        
        glViewport(0, 0, camera.viewWidth, camera.viewHeight);
        [self loadOrthoProjectionMatrix];
        
        [self setProjectionMatrix];
        
        [self onResize];
        if(_debug)NSLog(@"CGCanvasViewBasicGL: View resized");
        
        
    }
}

-(void)prepareOpenGL
{
    GLint swapInt = 1;
    
    [[self openGLContext] setValues:&swapInt forParameter:NSOpenGLCPSwapInterval];
    [self setOpenGLStates];
	glPolygonOffset (1.0f, 1.0f);
   
	glClearColor(0.1, 0.09, 0.1, 0.0f);
    [self setNearPlane:DEFAULT_NEAR_PLANE AndFarPlane:DEFAULT_FAR_PLANE];
    [self resetCamera];
    
    if(_debug)NSLog(@"CGCanvasViewGLBasic: OpenGL prepared");
}

-(void)setOpenGLStates
{
    glEnable(GL_DEPTH_TEST);
    glShadeModel(GL_SMOOTH);
	glEnable(GL_CULL_FACE);
    glEnable(GL_MULTISAMPLE);
    glHint (GL_MULTISAMPLE_FILTER_HINT_NV, GL_NICEST);
  	glFrontFace(GL_CCW);
    
}


-(void)beginGL{[self setProjectionMatrix];[self setModelViewMatrix];if(_debugDrawLoop)NSLog(@"CGCanvasViewGLBasic: Draw: Begin GL");}

-(void)drawGL{if(_debugDrawLoop)NSLog(@"CGCanvasViewGLBasic: Draw: Draw GL");}

-(void)endGL{glFlush();if(_debugDrawLoop)NSLog(@"CGCanvasViewGLBasic: Draw: End GL");}

#pragma mark ---- Projection & ModelView Matrix ----

-(void)setProjectionMatrix
{
    
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    /*
    GLdouble ratio, radians, wd2;
    GLdouble left, right, top, bottom, near, far;
    GLfloat shapeSize = 7.0f;
    [[self openGLContext]makeCurrentContext];
    
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    
    near = -camera.viewPosition.z - shapeSize * 0.5;
	if (near < 0.00001)
		near = 0.00001;
	far = -camera.viewPosition.z + shapeSize * 0.5;
	if (far < 1.0)
		far = 1.0;
	radians = 0.0174532925 * camera.aperture / 2; // half aperture degrees to radians
	wd2 = near * tan(radians);
	ratio = camera.viewWidth / (float) camera.viewHeight;
	if (ratio >= 1.0) {
		left  = -ratio * wd2;
		right = ratio * wd2;
		top = wd2;
		bottom = -wd2;
	} else {
		left  = -wd2;
		right = wd2;
		top = wd2 / ratio;
		bottom = -wd2 / ratio;
	}
	glFrustum (left, right, bottom, top, near, far);
    */
     
   
}

-(void)setModelViewMatrix
{
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    /*
     [[self openGLContext] makeCurrentContext];
    
    glMatrixMode (GL_MODELVIEW);
    glLoadIdentity();
    gluLookAt (camera.viewPosition.x, camera.viewPosition.y, camera.viewPosition.z,
			   camera.viewPosition.x + camera.viewDirecton.x,
			   camera.viewPosition.y + camera.viewDirecton.y,
			   camera.viewPosition.z + camera.viewDirecton.z,
			   camera.viewUpVector.x, camera.viewUpVector.y ,camera.viewUpVector.z);
     
    */
}

//loads the current orthogonal projection matrix according
//to the current camera width and height
-(void)loadOrthoProjectionMatrix
{
    fiLoadOrthoMatrix(_orthographicMatrix,
                        0.0, camera.viewWidth,camera.viewHeight, 0.0, -200.0, 200.0);
}

#pragma mark ---- Projection Modes ----

//NOTE:
/*Replace glOrtho with CGGLloadOrthoMatrix
 */

-(void)setOrtographicProjection
{
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    glOrtho(0.0, camera.viewWidth,camera.viewHeight, 0.0, -200.0, 200.0);
}

-(void)setIsometricProjection{}

#pragma mark ---- Camera ----

//SETUP CAMERA
-(void)setCameraWithViewPosition:(FIVector3D)aViewPosition viewDirection:(FIVector3D)aViewDirection viewUpVector:(FIVector3D)aViewUpVector rotationPoint:(FIVector3D)aRotationPoint
                        aperture:(GLfloat)aAperture viewWidth:(GLfloat)viewWidth viewHeight:(GLfloat)viewHeight
{
    _initCamAperture   = aAperture;
    _initCamRotPoint   = aRotationPoint;
    _initCamViewPos    = aViewPosition;
    _initCamViewDir    = aViewDirection;
    _initCamViewUp     = aViewUpVector;
    _initCamViewHeight = viewHeight;
    _initCamViewWidth  = viewWidth;
    
    if (!_cameraSet)
    {
        camera = FICameraMAKE(_initCamViewPos, _initCamViewDir, _initCamViewUp, _initCamRotPoint,
                                  _initCamAperture, _initCamViewWidth, _initCamViewHeight);
        _cameraSet = YES;
    }
    else
    {
        FICameraSet(&camera, _initCamViewPos, _initCamViewDir, _initCamViewUp, _initCamRotPoint, _initCamAperture, _initCamViewWidth, _initCamViewHeight);
    }

    if(_debug)
    {
        NSLog(@"CGCanvasViewBasicGL: Camera set.");
        NSLog(@"CGCanvasViewBasicGL: Camera: viewPosition: %@ viewDirection: %@ viewUpVector: %@ rotationPoint: %@ aperture: %.2f viewWidth: %.2f viewHeight: %.2f",
              FIVector3DToNSString(&camera.viewPosition),FIVector3DToNSString(&camera.viewDirecton),FIVector3DToNSString(&camera.viewUpVector),
              FIVector3DToNSString(&camera.rotationPoint),camera.aperture, camera.viewWidth, camera.viewHeight);
    }
}

-(void)resetCamera
{
    if(!_cameraSet)
    {
        _initCamAperture = 40;
        _initCamRotPoint = FIVector3DOrigin();
        _initCamViewPos  = FIVector3DMAKE(0.0, 0.0, -10.0);
        _initCamViewDir  = FIVector3DMAKE(-_initCamViewDir.x, _initCamViewDir.y, _initCamViewDir.z);
        _initCamViewUp   = FIVector3DMAKE(0, 1, 0);
        
        NSRect rectView = [self bounds];
        
        _initCamViewWidth  = rectView.size.width;
        _initCamViewHeight = rectView.size.height;
        
        _cameraSet = YES;
        
        [self resetCamera];
    }
    else
    {
        [self setCameraWithViewPosition:_initCamViewPos viewDirection:_initCamViewDir viewUpVector:_initCamViewUp rotationPoint:_initCamRotPoint aperture:_initCamAperture viewWidth:_initCamViewWidth viewHeight:_initCamViewHeight];
        
        [self loadOrthoProjectionMatrix];
    }
}





#pragma mark ---- Awake from NIB ----


-(void)awakeFromNib
{
    starStartTime();
    time = CFAbsoluteTimeGetCurrent();
    [self setup];
    timer = [NSTimer timerWithTimeInterval:_fps target:self selector:@selector(animationTimer:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSEventTrackingRunLoopMode];
    
    
    
}

#pragma mark ---- Internal Animation ----

-(void)animationTimer:(NSTimer *)timer
{
    
    BOOL shouldDraw = NO;
    if(_animate)
    {
        CFTimeInterval deltaTime = CFAbsoluteTimeGetCurrent() - time;
        
        if(deltaTime > 10.0)return;
        else
        {
            shouldDraw = YES;
        }
    }
    time = CFAbsoluteTimeGetCurrent();
    if(shouldDraw == YES){[self drawRect:[self bounds]];}
   
}

- (void)drawRect:(NSRect)dirtyRect
{
    
    [self resizeGL];[self beginGL];
    if(_shouldClear == YES)glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);[self drawGL];
    //if([self inLiveResize] && !_animate)glFlush();[self endGL];
    [self endGL];
   
}


#pragma mark ---- Responder BOOLS ----

-(BOOL)acceptsFirstResponder{return YES;}
-(BOOL)becomeFirstResponder {return YES;}
-(BOOL)resignFirstResponder {return YES;}
-(BOOL)isFlipped{return YES;}
#pragma mark ---- Singleton Methods ----

+(FIOpenGLView*)sharedView
{
    static FIOpenGLView* instance = nil;
    
    @synchronized(self)
    {
        if(instance == nil)instance = [[FIOpenGLView alloc]init];
    }
    
    return instance;
}

+(float)sharedWidth {return [[FIOpenGLView sharedView] width];}
+(float)sharedHeight{return [[FIOpenGLView sharedView] height];}

#pragma mark ---- ... ----
-(float)width {return [self bounds].size.width;}
-(float)height{return [self bounds].size.height;}
-(void)onResize{};


@end
