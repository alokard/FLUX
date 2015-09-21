//
//  FLXDomainMiddleware.h
//  MasterApp
//
//  Created by Alexey Fayzullov on 9/9/15.
//  Copyright (c) 2015 Techery. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FLXBaseAction;
@class FLXBaseStore;

@protocol FLXDomainMiddleware <NSObject>

@optional

- (void)onActionDispatching:(FLXBaseAction *)action;
- (void)onStoreRegistration:(FLXBaseStore *)store;

@end