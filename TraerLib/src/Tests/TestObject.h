//
//  Test.h
//  TraerLibrary
//
//  Created by Henryk on 13.09.12.
//  Copyright (c) 2012 Henryk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Testable.h"

@interface TestObject : NSObject <Testable>
{
    @protected
    
    float width;
    float height;
}

@end
