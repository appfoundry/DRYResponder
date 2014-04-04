//
//  BlockResponder.h
//  RESTDemo
//
//  Created by Michael Seghers on 20/06/12.
//  Copyright (c) 2012 iDA MediaFoundry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DRYResponder.h"

/**
 Block to be used by a responder for handing over results.
 */
typedef void (^ResultBlock)(id result);

/**
 Block to be used by a responder for reporting errors.
 */
typedef void (^ErrorBlock)(NSError * error);

/**
 Block to be used by a responder for handing over status reports.
 */
typedef void (^StatusBlock)(NSUInteger status, NSDictionary *userInfo);

/**
 Responder adoption using blocks.
 
 handleResult will call the ResultBlock with the result as argument, handleError will call the ErrorBlock with the error as argument and handleStatus
 will call the StatusBlock with the status and user info. The status block is optional, if it is missing, handleStatus will do nothing.
 */
@interface DRYBlockResponder : NSObject<DRYResponder>

/**
 Initializes a BlockResponder with the necessary blocks. This is the designated init method.
 
 If you initialize a block responder with this init method, you will not be able to track status updates. If you want to do this, you should call the
 initWithResultBlock:andErrorBlock:andStatusBlock: instead
 
 The blocks are copied.
 
 @param resultBlock The result block to be used for handing over results
 @param errorBlock The error block to be used for reporting errors
 @return this BlockResponder
 */
- (id)initWithResultBlock:(ResultBlock) resultBlock andErrorBlock:(ErrorBlock) errorBlock;

/**
 Initializes a BlockResponder with the necessary blocks.
 
 The blocks are copied.
 
 @param resultBlock The result block to be used for handing over results
 @param errorBlock The error block to be used for reporting errors
 @param statusBlock The status block to be used to track status updates
 @return this BlockResponder
 */
- (id)initWithResultBlock:(ResultBlock) resultBlock andErrorBlock:(ErrorBlock) errorBlock andStatusBlock:(StatusBlock) statusBlock;

@end
