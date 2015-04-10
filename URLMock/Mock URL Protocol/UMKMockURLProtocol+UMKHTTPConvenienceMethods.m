//
//  UMKMockURLProtocol+UMKHTTPConvenienceMethods.m
//  URLMock
//
//  Created by Prachi Gauriar on 2/1/2014.
//  Copyright (c) 2014 Two Toasters, LLC.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import <URLMock/UMKMockURLProtocol+UMKHTTPConvenienceMethods.h>

#import <URLMock/UMKMockHTTPRequest.h>
#import <URLMock/UMKMockHTTPResponder.h>


@implementation UMKMockURLProtocol (UMKHTTPConvenienceMethods)

+ (UMKMockHTTPRequest *)expectMockHTTPGetRequestWithURL:(NSURL *)URL responseError:(NSError *)error
{
    return [self expectMockHTTPRequestWithMethod:kUMKMockHTTPRequestGetMethod URL:URL requestJSON:nil responseError:error];
}

+ (UMKMockHTTPRequest *)expectMockHTTPRequestWithMethod:(NSString *)method URL:(NSURL *)URL requestXML:(NSString *)requestXML responseError:(NSError *)error
{
    NSParameterAssert(method);
    NSParameterAssert(URL);
    NSParameterAssert(error);

    UMKMockHTTPRequest *mockRequest = [[UMKMockHTTPRequest alloc] initWithHTTPMethod:method URL:URL];
    if (requestXML) {
        [mockRequest setBodyWithXMLString:requestXML];
    }

    mockRequest.responder = [UMKMockHTTPResponder mockHTTPResponderWithError:error];
    [self expectMockRequest:mockRequest];
    return mockRequest;
}


+ (UMKMockHTTPRequest *)expectMockHTTPPatchRequestWithURL:(NSURL *)URL requestXML:(NSString *)requestXML responseError:(NSError *)error
{
    return [self expectMockHTTPRequestWithMethod:kUMKMockHTTPRequestPatchMethod URL:URL requestXML:requestXML responseError:error];
}


+ (UMKMockHTTPRequest *)expectMockHTTPPostRequestWithURL:(NSURL *)URL requestXML:(NSString *)requestXML responseError:(NSError *)error
{
    return [self expectMockHTTPRequestWithMethod:kUMKMockHTTPRequestPostMethod URL:URL requestXML:requestXML responseError:error];
}


+ (UMKMockHTTPRequest *)expectMockHTTPPutRequestWithURL:(NSURL *)URL requestXML:(NSString *)requestXML responseError:(NSError *)error
{
    return [self expectMockHTTPRequestWithMethod:kUMKMockHTTPRequestPutMethod URL:URL requestXML:requestXML responseError:error];
}


+ (UMKMockHTTPRequest *)expectMockHTTPRequestWithMethod:(NSString *)method URL:(NSURL *)URL requestXML:(NSString *)requestXML
                                     responseStatusCode:(NSInteger)statusCode responseXML:(NSString *)responseXML
{
    NSParameterAssert(method);
    NSParameterAssert(URL);

    UMKMockHTTPRequest *mockRequest = [[UMKMockHTTPRequest alloc] initWithHTTPMethod:method URL:URL];
    if (requestXML) {
        [mockRequest setBodyWithXMLString:requestXML];
    }

    UMKMockHTTPResponder *mockResponder = [UMKMockHTTPResponder mockHTTPResponderWithStatusCode:statusCode];
    if (responseXML) {
        [mockResponder setBodyWithXMLString:responseXML];
    }

    mockRequest.responder = mockResponder;
    [self expectMockRequest:mockRequest];
    return mockRequest;
}


+ (UMKMockHTTPRequest *)expectMockHTTPGetRequestWithURL:(NSURL *)URL responseStatusCode:(NSInteger)statusCode responseXML:(NSString *)responseXML
{
    return [self expectMockHTTPRequestWithMethod:kUMKMockHTTPRequestGetMethod URL:URL requestXML:nil
                              responseStatusCode:statusCode responseXML:responseXML];
}


+ (UMKMockHTTPRequest *)expectMockHTTPPatchRequestWithURL:(NSURL *)URL requestXML:(NSString *)requestXML
                                       responseStatusCode:(NSInteger)statusCode responseXML:(NSString *)responseXML
{
    return [self expectMockHTTPRequestWithMethod:kUMKMockHTTPRequestPatchMethod URL:URL requestXML:requestXML
                              responseStatusCode:statusCode responseXML:responseXML];
}


+ (UMKMockHTTPRequest *)expectMockHTTPPostRequestWithURL:(NSURL *)URL requestXML:(NSString *)requestXML
                                      responseStatusCode:(NSInteger)statusCode responseXML:(NSString *)responseXML
{
    return [self expectMockHTTPRequestWithMethod:kUMKMockHTTPRequestPostMethod URL:URL requestXML:requestXML
                              responseStatusCode:statusCode responseXML:responseXML];
}


+ (UMKMockHTTPRequest *)expectMockHTTPPutRequestWithURL:(NSURL *)URL requestXML:(NSString *)requestXML
                                     responseStatusCode:(NSInteger)statusCode responseXML:(NSString *)responseXML
{
    return [self expectMockHTTPRequestWithMethod:kUMKMockHTTPRequestPutMethod URL:URL requestXML:requestXML
                              responseStatusCode:statusCode responseXML:responseXML];
}


+ (UMKMockHTTPRequest *)expectMockHTTPRequestWithMethod:(NSString *)method URL:(NSURL *)URL requestJSON:(id)requestJSON responseError:(NSError *)error
{
    NSParameterAssert(method);
    NSParameterAssert(URL);
    NSParameterAssert(error);
    
    UMKMockHTTPRequest *mockRequest = [[UMKMockHTTPRequest alloc] initWithHTTPMethod:method URL:URL];
    if (requestJSON) {
        [mockRequest setBodyWithJSONObject:requestJSON];
    }
    
    mockRequest.responder = [UMKMockHTTPResponder mockHTTPResponderWithError:error];
    [self expectMockRequest:mockRequest];
    return mockRequest;
}


+ (UMKMockHTTPRequest *)expectMockHTTPPatchRequestWithURL:(NSURL *)URL requestJSON:(id)requestJSON responseError:(NSError *)error
{
    return [self expectMockHTTPRequestWithMethod:kUMKMockHTTPRequestPatchMethod URL:URL requestJSON:requestJSON responseError:error];
}


+ (UMKMockHTTPRequest *)expectMockHTTPPostRequestWithURL:(NSURL *)URL requestJSON:(id)requestJSON responseError:(NSError *)error
{
    return [self expectMockHTTPRequestWithMethod:kUMKMockHTTPRequestPostMethod URL:URL requestJSON:requestJSON responseError:error];
}


+ (UMKMockHTTPRequest *)expectMockHTTPPutRequestWithURL:(NSURL *)URL requestJSON:(id)requestJSON responseError:(NSError *)error
{
    return [self expectMockHTTPRequestWithMethod:kUMKMockHTTPRequestPutMethod URL:URL requestJSON:requestJSON responseError:error];
}


+ (UMKMockHTTPRequest *)expectMockHTTPRequestWithMethod:(NSString *)method URL:(NSURL *)URL requestJSON:(id)requestJSON
                                     responseStatusCode:(NSInteger)statusCode responseJSON:(id)responseJSON
{
    NSParameterAssert(method);
    NSParameterAssert(URL);
    
    UMKMockHTTPRequest *mockRequest = [[UMKMockHTTPRequest alloc] initWithHTTPMethod:method URL:URL];
    if (requestJSON) {
        [mockRequest setBodyWithJSONObject:requestJSON];
    }
    
    UMKMockHTTPResponder *mockResponder = [UMKMockHTTPResponder mockHTTPResponderWithStatusCode:statusCode];
    if (responseJSON) {
        [mockResponder setBodyWithJSONObject:responseJSON];
    }
    
    mockRequest.responder = mockResponder;
    [self expectMockRequest:mockRequest];
    return mockRequest;
}


+ (UMKMockHTTPRequest *)expectMockHTTPGetRequestWithURL:(NSURL *)URL responseStatusCode:(NSInteger)statusCode responseJSON:(id)responseJSON
{
    return [self expectMockHTTPRequestWithMethod:kUMKMockHTTPRequestGetMethod URL:URL requestJSON:nil
                              responseStatusCode:statusCode responseJSON:responseJSON];
}


+ (UMKMockHTTPRequest *)expectMockHTTPPatchRequestWithURL:(NSURL *)URL requestJSON:(id)requestJSON
                                       responseStatusCode:(NSInteger)statusCode responseJSON:(id)responseJSON
{
    return [self expectMockHTTPRequestWithMethod:kUMKMockHTTPRequestPatchMethod URL:URL requestJSON:requestJSON
                              responseStatusCode:statusCode responseJSON:responseJSON];
}


+ (UMKMockHTTPRequest *)expectMockHTTPPostRequestWithURL:(NSURL *)URL requestJSON:(id)requestJSON
                                      responseStatusCode:(NSInteger)statusCode responseJSON:(id)responseJSON
{
    return [self expectMockHTTPRequestWithMethod:kUMKMockHTTPRequestPostMethod URL:URL requestJSON:requestJSON
                              responseStatusCode:statusCode responseJSON:responseJSON];
}


+ (UMKMockHTTPRequest *)expectMockHTTPPutRequestWithURL:(NSURL *)URL requestJSON:(id)requestJSON
                                     responseStatusCode:(NSInteger)statusCode responseJSON:(id)responseJSON
{
    return [self expectMockHTTPRequestWithMethod:kUMKMockHTTPRequestPutMethod URL:URL requestJSON:requestJSON
                              responseStatusCode:statusCode responseJSON:responseJSON];
}

@end
