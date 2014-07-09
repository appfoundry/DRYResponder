//
// Created by Michael Seghers on 09/07/14.
// Copyright (c) 2014 AppFoundry. All rights reserved.
//

#import "DRYURLSessionTaskCallHandle.h"


@interface DRYURLSessionTaskCallHandle () {
    NSURLSessionTask *_task;
}
@end

@implementation DRYURLSessionTaskCallHandle

- (id)initWithTask:(NSURLSessionTask *)task {
    self = [super init];
    if (self) {
        _task = task;
    }
    return self;
}

- (void)cancel {
    [_task cancel];
}


@end