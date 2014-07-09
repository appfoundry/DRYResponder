//
//  DRYResponderTests.m
//  DRYResponderTests
//
//  Created by Alex Manarpies on 16/10/13.
//  Copyright (c) 2013 iDA MediaFoundry. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DRYResponder.h"
#import "DRYBlockResponder.h"

@interface DRYResponderTests : XCTestCase

@end

@implementation DRYResponderTests {
    id <DRYResponder> _responder;
    id _result;
    id _error;
    id _userInfo;
    NSUInteger _status;
}

- (void)setUp {
    [super setUp];
    _responder = [[DRYBlockResponder alloc] initWithResultBlock:^(id result) {
        _result = result;
    }                                             andErrorBlock:^(NSError *error) {
        _error = error;
    } andStatusBlock:^(NSUInteger status, NSDictionary *userInfo) {
        _status = status;
        _userInfo = userInfo;
    }];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
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

- (void)testHandleErrorShouldCallErrorBlock {
    NSError *error = [NSError errorWithDomain:@"A" code:0 userInfo:nil];
    [_responder handleError:error];
    XCTAssertEqual(_error, error);
}

- (void)testhandleStatusShouldCallStatusBlock {
    NSDictionary *info = @{@"test": @"val"};
    NSUInteger status = 1;
    [_responder handleStatus:status withUserInfo:info];
    XCTAssertEqual(_userInfo, info);
    XCTAssertEqual(_status, status);
}


@end
