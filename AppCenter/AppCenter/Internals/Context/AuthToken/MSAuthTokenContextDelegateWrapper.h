// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.

#import "MSAuthTokenContextDelegate.h"
#import "MSAuthTokenDelegate.h"

/**
 * addDelegate: in MSAuthTokenContext takes a MSAuthTokenContextDelegate, but our new MSAuthTokenDelegate has a different form,
 * so we need to create a wrapper which conforms to MSAuthTokenContextDelegate.
 */
@interface MSAuthTokenContextDelegateWrapper : NSObject <MSAuthTokenContextDelegate>

@property id<MSAuthTokenDelegate> delegate;

@property MSAuthTokenCompletionHandler authTokenCompletionHandler;

/**
 * Creates a delegate wrapper which will call the delegates for both MSAuthTokenContextDelegate and MSAuthTokenDelegate.
 *
 * @param authTokenDelegate The Auth token delegate to call when refreshing tokens.
 * @param authTokenCompletionHandler The completion handler to call after getting refresh tokens.
 *
 * @return The MSAuthTokenContextDelegateWrapper instance.
 */
- (instancetype)initWithAuthTokenDelegate:(id<MSAuthTokenDelegate>)authTokenDelegate
               authTokenCompletionHandler:(MSAuthTokenCompletionHandler)authTokenCompletionHandler;

@end