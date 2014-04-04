//
//  ServiceCall.h
//  RESTDemo
//
//  Created by Michael Seghers on 20/06/12.
//  Copyright (c) 2012 iDA MediaFoundry. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 A call handle enables a caller of an assnchronous operation to cancel it's inquiry. In this way the operations knows that the caller is no longer intrested in the result. In most cases the caller will not even be available to receive the result anymore after it cancelled.
 
 The called operation should never retain the returned call handle, it is the caller that should take ownership. As soon as the operation is finished (see Responder) or cancelled, the caller should also release it's ownership to this handle.
 */
@protocol DRYCallHandle <NSObject>

/**
 Notifies the ongoing assynchronous operation that the caller is no longer interested in a result. The caller should also directly release it's ownership to this object after calling this method.
 */
- (void) cancel;

@end
