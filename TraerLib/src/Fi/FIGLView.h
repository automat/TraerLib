//
//  CGGLView.h
//  TraerLibrary
//
//  Created by Henryk on 11.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import "FIOpenGLView.h"


@interface FIGLView : FIOpenGLView
{
    @private
    
    NSMutableArray* tests;
    int             testIndex;
}

@end
