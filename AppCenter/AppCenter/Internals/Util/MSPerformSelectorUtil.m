// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.

#import "MSPerformSelectorUtil.h"
#import "MSAppCenterInternal.h"

@implementation MSPerformSelectorUtil

+ (void)performSelectorOnMainThread:(NSObject *)source withSelector:(SEL)selector withObjects:(NSObject *)objects, ... {
  NSMethodSignature *signature = [source methodSignatureForSelector:selector];
  if (!signature) {
    MSLogError([MSAppCenter logTag], @"MSUtility: Method not found.");
    return;
  }
  NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
  [invocation setTarget:source];
  [invocation setSelector:selector];
  va_list args;
  va_start(args, objects);
  int nextArgIndex = 2;
  for (NSObject *object = objects; object != [NSNull null]; object = va_arg(args, NSObject *)) {
    [invocation setArgument:&object atIndex:nextArgIndex];
    nextArgIndex++;
  }
  va_end(args);
  [invocation retainArguments];
  [invocation performSelectorOnMainThread:@selector(invoke) withObject:nil waitUntilDone:NO];
}

+ (NSInvocation *)performSelector:(id)source withSelector:(NSString *)selector withObjects:(NSArray *)objects {
  SEL selectors = NSSelectorFromString(selector);
  NSMethodSignature *signature = [(NSObject *)source methodSignatureForSelector:selectors];
  NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
  [invocation setTarget:source];
  [invocation setSelector:selectors];
  int index = 2;
  for (id value in objects) {
    void *values = (__bridge void *)value;
    [invocation setArgument:&values atIndex:index++];
  }
  [invocation retainArguments];
  [invocation invoke];
  return invocation;
}

@end