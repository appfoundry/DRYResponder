//
//  Responder.h
//  RESTDemo
//
//  Created by Michael Seghers on 20/06/12.
//  Copyright (c) 2014 AppFoundry. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 A responder is used in assynchronous operations to enable responding to the result and errors of such an operation.
 
 It is typically a wrapper around one or more delegates. This enables a looser coupling between the delegate and the operation class.
 */
@protocol DRYResponder <NSObject>

/**
 When the assynchronous operation is successful, it should call this method with it's result. The result may be nil.
 
 @param result The assynchronous operation's result, may be nil.
 */
- (void) handleResult:(id) result;

/**
 When the assynchrounous operation fails, it should call this method with the error at hand. The error should never be nil!
 
 @param error The error explaining the failure. Should never be nil!
 */
- (void) handleError:(NSError *) error;

@optional
/**
 When the assynchronous operation wants to report a certain status, it should call this method with the state. The state will typically
 be a defined enum, dependent on the context in which the responder is used. The operation can send extra usefull information throught
 the user info dictionary.
 
 @param status the status the assynchronous operation is in at the moment of this call
 @param userInfo extra usefull information about the assynchronous operation in this particular state
 */
- (void) handleStatus:(NSUInteger) status withUserInfo:(NSDictionary *) userInfo;

@end
