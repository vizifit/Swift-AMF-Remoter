//
//  RuntimeGlue.h
//  SwiftAMFManager
//
//  Created by Tony Henderson on 12/27/16.
//  Copyright © 2016 Tony Henderson. All rights reserved.
//

@import Foundation;

void setAssociatedObject_glue(NSObject *object, const NSString *key, NSObject *value);
NSObject *getAssociatedObject_glue(NSObject *object, const NSString* key);
