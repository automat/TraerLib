//
//  FIMath.h
//  FingeLibrary
//
//  Created by Henryk on 05.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#pragma mark ---- Utils ----

#define FI_PI     3.14159265359f
#define FI_HALF   1.57079632679f
#define FI_TWO_PI 6.28318530718f
#define FI_RADIANS2DEGREE(rad) ((rad) / FI_PI * 180.0f)
#define FI_DEGREE2RADIANS(deg) ((deg) / 180.0f * FI_PI)

#pragma mark ---- Conversion ----

static inline float fiInterpolate(float value1, float value2, float ratio)
{
    float iR = 1.0f - ratio;
    return iR * value1 + ratio * value2;
}

static inline float fiNorm(float value, float start, float stop)
{
    return (value - start) / (stop - start);
}

static inline float fiMap(float value, float istart, float istop,float ostart, float ostop)
{
    return ostart + (ostop - ostart) * ((value - istart) / (istop - istart));
}

static inline float fiDist2D(float x1, float y1, float x2, float y2)
{
    float dx = x2 - x1;
    float dy = y2 - y1;
    
    return sqrtf(dx*dx+dy*dy);
}

static inline float fiDist3d(float x1, float y1, float z1, float x2, float y2, float z2)
{
    float dx = x2 - x1;
    float dy = y2 - y1;
    float dz = z2 - z1;
    
    return sqrtf(dx*dx + dy*dy + dz*dz);
}

static inline float fiRandom()
{
    return ((float)arc4random()/0x100000000);
}

static inline float fiRandomRange(float min, float max)
{
    return (((float)arc4random()/0x100000000)*(max-min)+min);
}

static inline void fiConstrain(float value, float max)
{
    value = value > max ? max : value;
}

static inline void fiConstrainRange(float value, float min, float max)
{
    value =  value > max ? max : value < min ? min : value;
}

#pragma mark ---- Vector3d ----

typedef struct{
    GLfloat x;
    GLfloat y;
    GLfloat z;
}FIVector3D;

static inline FIVector3D FIVector3DMAKE(GLfloat x, GLfloat y, GLfloat z)
{
    FIVector3D v;
    v.x = x;
    v.y = y;
    v.z = z;
    
    return v;
}

static inline FIVector3D FIVector3DEMPTY()
{
    return FIVector3DMAKE(0, 0, 0);
}

static inline void FIVector3DClear(FIVector3D* v)
{
    v->x = 0;
    v->y = 0;
    v->z = 0;
}

static inline void FIVector3DSetXYZ(FIVector3D* v,GLfloat x, GLfloat y, GLfloat z)
{
    v->x = x;
    v->y = y;
    v->z = z;
}

static inline void FIVector3DSetVector3D(FIVector3D* v1,const FIVector3D* v2)
{
    FIVector3DSetXYZ(v1, v2->x, v2->y, v2->z);
}

static inline void FIVector3DAddXYZ(FIVector3D* v,GLfloat x,GLfloat y,GLfloat z)
{
    v->x+=x;
    v->y+=y;
    v->z+=z;
}

static inline void FIVector3DAddVector3D(FIVector3D* v1,const FIVector3D* v2)
{
    FIVector3DAddXYZ(v1, v2->x, v2->y, v2->z);
}

static inline void FIVector3DSubXYZ(FIVector3D* v,GLfloat x,GLfloat y,GLfloat z)
{
    v->x-=x;
    v->y-=y;
    v->z-=z;
}

static inline void FIVector3DSubVector3D(FIVector3D* v1, const FIVector3D* v2)
{
    FIVector3DSubXYZ(v1, v2->x, v2->y, v2->z);
}

static inline void FIVector3DMultBy(FIVector3D* v, GLfloat n)
{
    v->x*=n;
    v->y*=n;
    v->z*=n;
}

static inline GLfloat FIVector3DDistanceToXYZSquared(const FIVector3D* v,GLfloat x,GLfloat y,GLfloat z)
{
    float dx = v->x-x;
    float dy = v->y-y;
    float dz = v->z-z;
    
    return dx*dx + dy*dy + dz*dz;
}

static inline GLfloat FIVector3DDistanceToXYZ(const FIVector3D* v,GLfloat x,GLfloat y, GLfloat z)
{
    return sqrtf(FIVector3DDistanceToXYZSquared(v, x, y, z));
}

static inline GLfloat FIVector3DDistanceToVector3D(const FIVector3D* v1,const FIVector3D* v2)
{
    return FIVector3DDistanceToXYZ(v1, v2->x, v2->y, v2->z);

}

static inline GLfloat FIVector3DDotVector3D(const FIVector3D* v1, const FIVector3D* v2)
{
    return v1->x * v2->x + v1->y * v2->y + v1->z * v2->z;
}

static inline GLfloat FIVector3DLengthSquared(const FIVector3D* v)
{
    return v->x*v->x + v->y*v->y + v->z*v->z;
}

static inline GLfloat FIVector3DLength(const FIVector3D* v)
{
    return sqrtf(FIVector3DLengthSquared(v));
}

static inline FIVector3D FIVector3DCrossVector3D(const FIVector3D* v1, const FIVector3D* v2)
{
    return FIVector3DMAKE(v1->y * v2->z - v1->z * v2->y,
                         v1->x * v2->z - v1->z * v2->x,
                         v1->x * v2->y - v1->y * v2->x);
}

static inline BOOL FIVector3DIsZero(const FIVector3D* v)
{
    return v->x == 0 && v->y == 0 && v->z == 0;
}

static inline FIVector3D FIVector3DOrigin()
{
    return FIVector3DMAKE(0, 0, 0);
}

static inline float FIVector3DHeading2D(const FIVector3D* v)
{
    return -1 * atan2f(-v->y, v->x);
}

static inline float FIVector3DAngleBetween(const FIVector3D* v1, const FIVector3D* v2)
{
    double dot = v1->x * v2->x + v1->y * v2->y + v1->z * v2->z;
    double v1mag = sqrtf(v1->x * v1->x + v1->y * v1->y + v1->z * v1->z);
    double v2mag = sqrtf(v2->x * v2->x + v2->y * v2->y + v2->z * v2->z);
    // This should be a number between -1 and 1, since it's "normalized"
    double amt = dot / (v1mag * v2mag);
    
    if (amt <= -1) {
        return FI_PI;
    } else if (amt >= 1) {
        // http://code.google.com/p/processing/issues/detail?id=435
        return 0;
    }
    
    return acosf(amt);
}

static inline NSString* FIVector3DToNSString(FIVector3D* v)
{
    return [NSString stringWithFormat:@"{%.2f, %.2f, %.2f}",v->x,v->y,v->z];
}



#pragma mark ---- Vector2






