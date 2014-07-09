//
// Created by Michael Seghers on 09/07/14.
// Copyright (c) 2014 AppFoundry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DRYCallHandle.h"


@interface DRYURLSessionTaskCallHandle : NSObject<DRYCallHandle>
- (id)initWithTask:(NSURLSessionTask *)task;
@end