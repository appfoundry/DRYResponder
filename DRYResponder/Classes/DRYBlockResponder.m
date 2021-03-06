//
//  BlockResponder.m
//  RESTDemo
//
//  Created by Michael Seghers on 20/06/12.
//  Copyright (c) 2014 AppFoundry. All rights reserved.
//

#import "DRYBlockResponder.h"

@implementation DRYBlockResponder {
    ResultBlock _resultBlock;
    ErrorBlock _errorBlock;
    StatusBlock _statusBlock;
}

- (id)initWithResultBlock:(ResultBlock)resultBlock andErrorBlock:(ErrorBlock)errorBlock {
    self = [super init];
    if (self) {
        _resultBlock = [resultBlock copy];
        _errorBlock = [errorBlock copy];
    }
    return self;
}

- (id)initWithResultBlock:(ResultBlock)resultBlock andErrorBlock:(ErrorBlock)errorBlock andStatusBlock:(StatusBlock)statusBlock {
    self = [self initWithResultBlock:resultBlock andErrorBlock:errorBlock];
    if (self) {
        _statusBlock = [statusBlock copy];
    }
    return self;
}

- (void)handleResult:(id)result {
    [self _executeBlockOnAppropriateQueue:^{
        _resultBlock(result);
    }];
}

- (void)handleError:(NSError *)error {
    [self _executeBlockOnAppropriateQueue:^{
        _errorBlock(error);
    }];
}

- (void)handleStatus:(NSUInteger)status withUserInfo:(NSDictionary *)userInfo {
    if (_statusBlock) {
        [self _executeBlockOnAppropriateQueue:^{
            _statusBlock(status, userInfo);
        }];
    }
}

- (void)_executeBlockOnAppropriateQueue:(void (^)())blockToCall {
    if ([self _completionShouldHappenOnMainThread]) {
        blockToCall();
    } else {
        dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
            blockToCall();
        });
    }
}

- (BOOL) _completionShouldHappenOnMainThread {
    return  [NSThread isMainThread] && (self.completionQueue == dispatch_get_main_queue() || self.completionQueue == nil);
}

@end
