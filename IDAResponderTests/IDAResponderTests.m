//
//  IDAResponderTests.m
//  IDAResponderTests
//
//  Created by Alex Manarpies on 16/10/13.
//  Copyright (c) 2013 iDA MediaFoundry. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "IDAResponder.h"
#import "IDABlockResponder.h"

@interface IDAResponderTests : XCTestCase

@end

@implementation IDAResponderTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testBasic
{
    id<IDAResponder> responder = [[IDABlockResponder alloc] initWithResultBlock:^(id result) {
        //
    } andErrorBlock:^(NSError *error) {
        //
    }];
    
    XCTAssertNotNil(responder, @"Responder should not be nil");
}

@end
