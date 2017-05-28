//
//  RuntimeGlue.m
//  SwiftAMFManager
//
//  Created by Tony Henderson on 12/27/16.
//  Copyright © 2016 Tony Henderson. All rights reserved.
//

#import <Foundation/Foundation.h>
// RuntimeGlue.m

#import "RuntimeGlue.h"
#import <objc/runtime.h>

void setAssociatedObject_glue(NSObject *object, const NSString *key, NSObject *value) {
    objc_setAssociatedObject(object, (__bridge const void *)(key), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

NSObject *getAssociatedObject_glue(NSObject *object, const NSString* key) {
    return objc_getAssociatedObject(object, (__bridge const void *)(key));
}
