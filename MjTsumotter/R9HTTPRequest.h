//
//  R9HTTPRequest.h
//
//  Created by 藤田 泰介 on 12/02/25.
//  Copyright (c) 2012 Revolution 9. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompletionHandler)(NSHTTPURLResponse *responseHeader, NSString *responseString);
typedef void(^UploadProgressHandler)(float newProgress);
typedef void(^FailedHandler)(NSError *error);

@interface R9HTTPRequest : NSOperation <NSURLConnectionDataDelegate>

@property (copy, nonatomic) CompletionHandler completionHandler;
@property (copy, nonatomic) FailedHandler failedHandler;
@property (copy, nonatomic) UploadProgressHandler uploadProgressHandler;
@property (strong, nonatomic) NSString *HTTPMethod;
@property (nonatomic) BOOL shouldRedirect;

- (id)initWithURL:(NSURL *)targetUrl;

- (void)addHeader:(NSString *)value forKey:(NSString *)key;

- (void)setBody:(NSData *)data;

- (void)setData:(NSData *)data withFileName:(NSString *)fileName andContentType:(NSString *)contentType forKey:(NSString *)key;

/* TimeoutInterval must be greater than 240 seconds. */
- (void)setTimeoutInterval:(NSTimeInterval)seconds;

- (void)startRequest;

@end
