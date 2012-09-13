//
//  CGGLUtils.h
//  TraerLibrary
//
//  Created by Henryk on 10.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import "FIMath.h"


#define FI_DEFAULT_CIRCLE_RESOLUTION 40

#pragma mark ---- Camera ----

typedef struct{
    FIVector3D viewPosition;
    FIVector3D viewDirecton;
    FIVector3D viewUpVector;
    FIVector3D rotationPoint;
    GLfloat   aperture;
    GLfloat   viewWidth;
    GLfloat   viewHeight;
}FICamera;

static inline FICamera FICameraMAKE(FIVector3D viewPosition,FIVector3D viewDirection, FIVector3D viewUpVector, FIVector3D rotationPoint,
                                        GLfloat aperture, GLfloat viewWidth, GLfloat viewHeight)
{
    FICamera cam;
    cam.viewPosition  = viewPosition;
    cam.viewDirecton  = viewDirection;
    cam.viewUpVector  = viewUpVector;
    cam.rotationPoint = rotationPoint;
    cam.aperture      = aperture;
    cam.viewWidth     = viewWidth;
    cam.viewHeight    = viewHeight;
    return cam;
}

static inline void FICameraSet(FICamera* camera, FIVector3D viewPosition,FIVector3D viewDirection, FIVector3D viewUpVector, FIVector3D rotationPoint, GLfloat aperture, GLfloat viewWidth, GLfloat viewHeight)
{
    camera->viewPosition  = viewPosition;
    camera->viewDirecton  = viewDirection;
    camera->viewUpVector  = viewUpVector;
    camera->rotationPoint = rotationPoint;
    camera->aperture      = aperture;
    camera->viewWidth     = viewWidth;
    camera->viewHeight    = viewHeight;
}

#pragma mark ----  Matrices ----

static inline void fiLoadOrthoMatrix(GLfloat* matrix, GLfloat left, GLfloat right,
                                                        GLfloat bottom, GLfloat top,
                                                        GLfloat near, GLfloat far)
{
    GLfloat r_l = right - left;
    GLfloat t_b = top - bottom;
    GLfloat f_n = far - near;
    GLfloat tx = - (right + left) / (right - left);
    GLfloat ty = - (top + bottom) / (top - bottom);
    GLfloat tz = - (far + near) / (far - near);
    
    matrix[0] = 2.0f / r_l;
    matrix[1] = 0.0f;
    matrix[2] = 0.0f;
    matrix[3] = tx;
    
    matrix[4] = 0.0f;
    matrix[5] = 2.0f / t_b;
    matrix[6] = 0.0f;
    matrix[7] = ty;
    
    matrix[8] = 0.0f;
    matrix[9] = 0.0f;
    matrix[10] = 2.0f / f_n;
    matrix[11] = tz;
    
    matrix[12] = 0.0f;
    matrix[13] = 0.0f;
    matrix[14] = 0.0f;
    matrix[15] = 1.0f;
}

static inline void fiRotateX(GLfloat angle){glRotatef(angle, 1, 0, 0);}
static inline void fiRotateY(GLfloat angle){glRotatef(angle, 0, 1, 0);}
static inline void fiRotateZ(GLfloat angle){glRotatef(angle, 0, 0, 1);}

static inline void fiTranslate(const FIVector3D* v)
{
    glTranslatef(v->x, v->y, v->z);
}

#pragma mark ---- Color ----

typedef struct
{
    GLfloat r;
    GLfloat g;
    GLfloat b;
    GLfloat a;
}FIColor;

static inline FIColor FIColorMAKERGBA(GLfloat r,GLfloat g,GLfloat b, GLfloat a)
{
    FIColor c;
    c.r = r;
    c.g = g;
    c.b = b;
    c.a = a;
    return c;
}

static inline FIColor FIColorMAKERGB(GLfloat r, GLfloat g, GLfloat b){return FIColorMAKERGBA(r, g, b, 1.0f);}
static inline FIColor FIColorMAKEKA(GLfloat k,GLfloat a)             {return FIColorMAKERGBA(k, k, k, a);}
static inline FIColor FIColorMAKEK(GLfloat k,GLfloat a)              {return FIColorMAKERGBA(k, k, k, 1.0f);}

static inline FIColor FIColorBRIGHTBEIGE(){return FIColorMAKERGB(0.90, 0.85, 0.689);};
static inline FIColor FIColorWHITE()      {return FIColorMAKERGBA(1, 1, 1, 1);}
static inline FIColor FIColorBLACK()      {return FIColorMAKERGBA(0, 0, 0, 1);}
static inline FIColor FIColorRED()        {return FIColorMAKERGBA(1, 0, 0, 1);}
static inline FIColor FIColorGREEN()      {return FIColorMAKERGBA(0, 1, 0, 1);}
static inline FIColor FIColorBLUE()       {return FIColorMAKERGBA(0, 0, 1, 1);}

static inline void FIColorSetRGBA(FIColor* color, GLfloat r, GLfloat g, GLfloat b, GLfloat a)
{
    color->r = r;
    color->g = g;
    color->b = b;
    color->a = a;
}

static inline void FIColorSetRGB(FIColor* color, GLfloat r, GLfloat g, GLfloat b){FIColorSetRGBA(color, r, g, b, color->a);}
static inline void FIColorSetKA(FIColor* color, GLfloat k, GLfloat a){FIColorSetRGBA(color, k, k, k, a);}
static inline void FIColorSetK(FIColor* color, GLfloat k){FIColorSetRGBA(color, k, k, k, color->a);}

static inline void fiColor(const FIColor* color)
{
    glColor4f(color->r, color->g, color->b, color->a);
}

#pragma mark ---- Primitives ----

enum FIDrawMode {
    CGGLDrawMode_SOLID = 0,
    CGGLDrawMode_STROKED = 1
    };

static enum FIDrawMode _currentDrawMode = CGGLDrawMode_SOLID;

static inline void fiSetDrawMode(enum FIDrawMode mode)
{
    _currentDrawMode = mode;
}

static const GLint cube_num_vertices = 8;

static const GLfloat cube_vertices [8][3] = {
    {1.0, 1.0, 1.0}, {1.0, -1.0, 1.0}, {-1.0, -1.0, 1.0}, {-1.0, 1.0, 1.0},
    {1.0, 1.0, -1.0}, {1.0, -1.0, -1.0}, {-1.0, -1.0, -1.0}, {-1.0, 1.0, -1.0} };

static const GLfloat cube_vertex_colors [8][3] = {
    {1.0, 1.0, 1.0}, {1.0, 1.0, 0.0}, {0.0, 1.0, 0.0}, {0.0, 1.0, 1.0},
    {1.0, 0.0, 1.0}, {1.0, 0.0, 0.0}, {0.0, 0.0, 0.0}, {0.0, 0.0, 1.0} };

static const GLint cube_num_faces = 6;

static const short cube_faces [6][4] = {
    {3, 2, 1, 0}, {2, 3, 7, 6}, {0, 1, 5, 4}, {3, 0, 4, 7}, {1, 2, 6, 5}, {4, 5, 6, 7} };


static inline void fiDrawCube(GLfloat size)
{
    int i = -1;
    int j;
    glBegin(_currentDrawMode == CGGLDrawMode_SOLID ? GL_QUADS :
            _currentDrawMode == CGGLDrawMode_STROKED ? GL_LINE_STRIP :
            GL_QUADS);
    while (++i < cube_num_faces)
    {
        j = -1;
        while (++j < 4)
        {
            glVertex3f(cube_vertices[cube_faces[i][j]][0] * size, cube_vertices[cube_faces[i][j]][1] * size, cube_vertices[cube_faces[i][j]][2] * size);
        }
    }
    
    glEnd();
}

static inline void fiDrawDebugCube(GLfloat size)
{
    int i = -1;
    int j;
    glBegin(GL_QUADS);
    while (++i < cube_num_faces)
    {
        j = -1;
        while (++j < 4)
        {
            glColor3f (cube_vertex_colors[cube_faces[i][j]][0], cube_vertex_colors[cube_faces[i][j]][1], cube_vertex_colors[cube_faces[i][j]][2]);
            glVertex3f(cube_vertices[cube_faces[i][j]][0] * size, cube_vertices[cube_faces[i][j]][1] * size, cube_vertices[cube_faces[i][j]][2] * size);
        }
    }   
    glEnd();
}

static inline void fiDrawDebugCubeAtVector3D(GLfloat size, const FIVector3D* v)
{
    glPushMatrix();
    fiTranslate(v);
    fiDrawDebugCube(size);
    glPopMatrix();
}

static inline void fiDrawDebugCubeA(GLfloat size,float alpha)
{
    int i = -1;
    int j;
    glBegin(GL_QUADS);
    while (++i < cube_num_faces)
    {
        j = -1;
        while (++j < 4)
        {
            glColor4f (cube_vertex_colors[cube_faces[i][j]][0], cube_vertex_colors[cube_faces[i][j]][1], alpha,alpha);
            glVertex3f(cube_vertices[cube_faces[i][j]][0] * size, cube_vertices[cube_faces[i][j]][1] * size, cube_vertices[cube_faces[i][j]][2] * size);
        }
    }
    glEnd();
}

#pragma mark ---- Draw Methods ----

static inline int fiGetNumberOfArcIterations(float rX, float rY, float startAngle, float stopAngle, double reslution)
{
    double error = reslution;
    double maxRadius = (rX >= rY) ? rX : rY;
    error = (error > maxRadius) ? 0.5 : error;
    double maxStep = 2.0 * asin(error/(2.0 * maxRadius));
    return (int)(ceil(FI_DEGREE2RADIANS(stopAngle-startAngle)/maxStep));
}

static inline void fiDrawEllipseWithResolution(float x, float y, float radiusX, float radiusY, double resolution)
{
    int iterations = fiGetNumberOfArcIterations(radiusX, radiusY, 0.0f, 360.0f ,resolution);
    double step = FI_TWO_PI/ iterations;
    int i = 0;
    glBegin(GL_TRIANGLE_STRIP);
    while (i <= iterations)
    {
        double a = step * i;
        glVertex3f(x + radiusX * cos(a), y + radiusY * sin(a), 0.0f);
        glVertex3f(x, y, 0.0f);
        ++i;
    }
    glEnd();
}

static inline void fiDrawCircleWithResolution(float x, float y, float radius, double resolution)
{
    fiDrawEllipseWithResolution(x, y, radius, radius, resolution);
}

static inline void fiDrawCircleWithResolutionVector3D(const FIVector3D* v,float radius, double resolution)
{
    fiDrawCircleWithResolution(v->x,v->y,radius,resolution);
}

static inline void fiDrawEllipseTexturedWithResolution(float x, float y, float radiusX, float radiusY, double resolution)
{
    int iterations = fiGetNumberOfArcIterations(radiusX, radiusY, 0.0, 360, resolution);
    double step = FI_TWO_PI/ iterations;
    int i = 0;
    double a;
    float ccosa, csina;
    float ncosa, nsina;
    
    glPushMatrix();
    glTranslatef(x, y, 0.0f);
    glBegin(GL_TRIANGLE_STRIP);
    while (i <= iterations-1)
    {
        a = step * i;
        ccosa = cosf(a);
        csina = sinf(a);
        a = step * (i+1);
        ncosa = cosf(a);
        nsina = sinf(a);
        glTexCoord2f(ccosa, csina);
        glVertex3f(radiusX * ccosa, radiusY * csina, 0.0f);
        glTexCoord2f(0.5f, 0.5f);
        glVertex3f(x, y, 0.0f);
        glTexCoord2f(ncosa, nsina);
        glVertex2f(radiusX * ncosa, radiusY * nsina);
        ++i;
    }
    glEnd();
    glPopMatrix();
}

static inline void fiVertexLine(float x0, float y0, float z0, float x1, float y1, float z1)
{
    glVertex3f(x0,y0,z0);
    glVertex3f(x1,y1,z1);
}

static inline void fiDrawLine(float x0, float y0, float z0, float x1, float y1, float z1)
{
    glBegin(GL_LINES);
    fiVertexLine(x0,y0,z0,x1,y1,z1);
    glEnd();
}

static inline void fiDrawLineVector3D(const FIVector3D* v0,const FIVector3D* v1)
{
    fiDrawLine(v0->x, v0->y, v0->z, v1->x, v1->y, v1->z);
}





