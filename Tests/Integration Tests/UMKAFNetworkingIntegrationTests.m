//
//  UMKAFNetworkingIntegrationTests.m
//  URLMock
//
//  Created by Prachi Gauriar on 8/21/2014.
//  Copyright (c) 2014 Two Toasters, LLC. All rights reserved.
//

#import "UMKIntegrationTestCase.h"

#import <AFNetworking/AFNetworking.h>

@interface UMKAFNetworkingIntegrationTests : UMKIntegrationTestCase

- (void)testMultiPartPostDataResponse;

@end


@implementation UMKAFNetworkingIntegrationTests

+ (void)setUp
{
    [super setUp];
    [UMKMockURLProtocol setVerificationEnabled:YES];
}


+ (void)tearDown
{
    [UMKMockURLProtocol setVerificationEnabled:NO];
    [super tearDown];
}


- (void)testMultiPartPostDataResponse
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.operationQueue = [[self class] networkOperationQueue];
    NSURL *URL = UMKRandomHTTPURL();

    // Generate a random dictionary of name-data pairs for our form data
    NSDictionary *partsByName = UMKGeneratedDictionaryWithElementCount(random() % 10 + 1, ^id{
        return UMKRandomIdentifierStringWithLength(10);
    }, ^id(id key) {
        return [UMKRandomUnicodeString() dataUsingEncoding:NSUTF8StringEncoding];
    });


    // Mock up the request/response
    id expectedResponseObject = UMKRandomJSONObject(5, 5);

    UMKMockHTTPRequest *mockRequest = [UMKMockHTTPRequest mockHTTPPostRequestWithURL:URL];
    mockRequest.checksBodyWhenMatching = NO;
    UMKMockHTTPResponder *mockResponder = [UMKMockHTTPResponder mockHTTPResponderWithStatusCode:200];
    [mockResponder setBodyWithJSONObject:expectedResponseObject];
    mockRequest.responder = mockResponder;
    [UMKMockURLProtocol expectMockRequest:mockRequest];

    __block BOOL successBlockCalled = NO;
    __block id responseObject = nil;
    __block BOOL failureBlockCalled = NO;
    __block NSError *responseError = nil;

    [manager POST:URL.absoluteString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [partsByName enumerateKeysAndObjectsUsingBlock:^(NSString *name, NSData *data, BOOL *stop) {
            [formData appendPartWithFormData:data name:name];
        }];
    } success:^(AFHTTPRequestOperation *operation, id o) {
        successBlockCalled = YES;
        responseObject = o;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlockCalled = YES;
        responseError = error;
    }];

    UMKAssertTrueBeforeTimeout(2.0, successBlockCalled || failureBlockCalled, @"request does not complete in time");
    XCTAssertTrue(successBlockCalled, @"success block is not called");
    XCTAssertEqualObjects(responseObject, expectedResponseObject, @"response object is incorrect");
    XCTAssertFalse(failureBlockCalled, @"failure block is called");
    XCTAssertNil(responseError, @"responseError is non-nil");

    NSError *error = nil;
    XCTAssertTrue([UMKMockURLProtocol verifyWithError:&error], @"verification fails with error: %@", error);
}

@end
