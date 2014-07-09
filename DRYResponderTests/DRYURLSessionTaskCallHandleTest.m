//
//  DRYNSURLSessionTaskCallHandleTest.m
//  DRYResponder
//
//  Created by Michael Seghers on 09/07/14.
//  Copyright (c) 2014 AppFoundry. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DRYURLSessionTaskCallHandle.h"

@interface DRYURLSessionTaskCallHandleTest : XCTestCase

@end

@interface CustomTask : NSURLSessionTask

@property(nonatomic) BOOL cancelled;

@end

@implementation DRYURLSessionTaskCallHandleTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCancel {
    CustomTask *task = [[CustomTask alloc] init];
    DRYURLSessionTaskCallHandle *callHandle = [[DRYURLSessionTaskCallHandle alloc] initWithTask:task];
    [callHandle cancel];
    XCTAssertTrue(task.cancelled);
}

@end

@implementation CustomTask

- (void)cancel {
    self.cancelled = YES;
}

@end
