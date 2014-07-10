//
//  DRYBlockResponderTests.m
//  DRYBlockResponderTests
//
//  Created by Alex Manarpies on 16/10/13.
//  Copyright (c) 2014 AppFoundry. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DRYResponder.h"
#import "DRYBlockResponder.h"

@interface DRYBlockResponderTests : XCTestCase

@end

@implementation DRYBlockResponderTests {
    DRYBlockResponder *_responder;
    id _result;
    id _error;
    id _userInfo;
    NSUInteger _status;
    dispatch_queue_t _queue;
    dispatch_semaphore_t _asyncSemaphore;
}

- (void)setUp {
    [super setUp];
    _asyncSemaphore = dispatch_semaphore_create(0);
    _responder = [[DRYBlockResponder alloc] initWithResultBlock:^(id result) {
        _queue = dispatch_get_current_queue();
        _result = result;
        dispatch_semaphore_signal(_asyncSemaphore);
    }                                             andErrorBlock:^(NSError *error) {
        _queue = dispatch_get_current_queue();
        _error = error;
        dispatch_semaphore_signal(_asyncSemaphore);
    }                                            andStatusBlock:^(NSUInteger status, NSDictionary *userInfo) {
        _queue = dispatch_get_current_queue();
        _status = status;
        _userInfo = userInfo;
        dispatch_semaphore_signal(_asyncSemaphore);
    }];
}

- (void)testInitWithResultAndErrorBlockAndStatusBlock {
    XCTAssertNotNil(_responder, @"Responder should not be nil");
}

- (void)testInitWithResultAndError {
    id <DRYResponder> responder = [[DRYBlockResponder alloc] initWithResultBlock:^(id result) {
        //
    }                                                              andErrorBlock:^(NSError *error) {
        //
    }];
    XCTAssertNotNil(responder, @"Responder should not be nil");
}

- (void)testHandleResultShouldCallResultBlock {
    [_responder handleResult:@"result"];
    XCTAssertEqual(_result, @"result");
}

- (void)testHandleResultShouldBeCalledOnMainThread {
    [_responder handleResult:@"result"];
    XCTAssertEqualObjects(_queue, dispatch_get_main_queue());
}

- (void)testHandleErrorShouldCallErrorBlock {
    NSError *error = [NSError errorWithDomain:@"A" code:0 userInfo:nil];
    [_responder handleError:error];
    XCTAssertEqual(_error, error);
}

- (void)testhandleStatusShouldCallStatusBlock {
    NSDictionary *info = @{@"test" : @"val"};
    NSUInteger status = 1;
    [_responder handleStatus:status withUserInfo:info];
    XCTAssertEqual(_userInfo, info);
    XCTAssertEqual(_status, status);
}

- (void)testHandleResultHappensOnGivenQueue {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _responder.completionQueue = queue;
    [_responder handleResult:nil];
    [self waitForQueue:queue];
}

- (void)testHandleErrorShouldBeCalledOnMainThread {
    [_responder handleError:nil];
    XCTAssertEqualObjects(_queue, dispatch_get_main_queue());
}

- (void)testHandleErrorHappensOnGivenThread {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _responder.completionQueue = queue;
    [_responder handleError:nil];
    [self waitForQueue:queue];
}


- (void)testHandleStatusShouldBeCalledOnMainThread {
    [_responder handleStatus:0 withUserInfo:nil];
    XCTAssertEqualObjects(_queue, dispatch_get_main_queue());
}

- (void)testHandleStatusHappensOnGivenThread {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _responder.completionQueue = queue;
    [_responder handleStatus:0 withUserInfo:nil];
    [self waitForQueue:queue];
}

- (void)testAlsoWorksWhenHandleIsCalledOnBackgroundQueueAndDispatchToThatSameQueue {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _responder.completionQueue = queue;
    dispatch_async(queue, ^{
        [_responder handleResult:nil];
    });

    [self waitForQueue:queue];
}

- (void)waitForQueue:(dispatch_queue_t)queue {
    if (dispatch_semaphore_wait(_asyncSemaphore, dispatch_time(DISPATCH_TIME_NOW, (int64_t) (2.0 * NSEC_PER_SEC)))) {
        XCTFail(@"Time out");
    } else {
        XCTAssertEqualObjects(_queue, queue);
    }
}

@end
