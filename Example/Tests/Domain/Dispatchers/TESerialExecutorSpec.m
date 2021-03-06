//
//  TESerialExecutorSpec.m
//  MasterApp
//
//  Created by Alexey Fayzullov on 9/7/15.
//  Copyright (c) 2015 Techery. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "TESerialExecutor.h"

@interface TESerialExecutor (Testing)

@property (nonatomic, strong) dispatch_queue_t executionQueue;
- (NSString *)serviceId;

@end

SPEC_BEGIN(TESerialExecutorSpec)

TESerialExecutor __block *sut;

beforeEach(^{
    sut = [[TESerialExecutor alloc] init];
});

afterEach(^{
    sut = nil;
});

describe(@"initialization", ^{
    
    it(@"should create executionQueue", ^{
        
        [[sut.executionQueue shouldNot] beNil];
    });
});

describe(@"execute", ^{

    it(@"should call block in execution queue", ^{
        
        static void *kTestSpecificKey = (void*)"kTestSpecificKey";
        dispatch_queue_set_specific(sut.executionQueue, kTestSpecificKey, (void *)kTestSpecificKey, NULL);
        
        NSNumber *__block blockDidLaunch;
        NSNumber *__block didCallBlockInCorrectQueue;

        TEExecutorEmptyBlock block = ^{
            blockDidLaunch = @(YES);
            if(dispatch_get_specific(kTestSpecificKey))
            {
                didCallBlockInCorrectQueue = @(YES);
            }
        };
        
        [[blockDidLaunch shouldNotEventually] beNil];
        [[didCallBlockInCorrectQueue shouldNotEventually] beNil];
        
        [sut execute:block];
    });
    
});

SPEC_END