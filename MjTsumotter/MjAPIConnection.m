//
//  MjAPIConnection.m
//  MjTsumotter
//
//  Created by 健 荻野 on 12/03/16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MjAPIConnection.h"

static NSString *MjAPI_URI = @"http://mjt.mjlife.jp/agaris.json";

@implementation MjAPIConnection

- (id)init
{
    self = [super init];
    if (self) {
        receivedData = [[NSMutableData alloc] init];
    }
    
    return self;
}

- (void)dealloc
{
    [receivedData release];
    [super dealloc];
}


- (void)sendAgari:(MjAgari *)agari delegate:(id)delegate
{
    NSURLRequest *req = [self createRequestAgari:agari];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:req delegate:self];
    if (connection) {
        receivedData = [[NSMutableData data] retain];
    } else {
//        [delegate didFailWithError];
    }
}

- (NSURLRequest *)createRequestAgari:(MjAgari *)agari
{
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:MjAPI_URI] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[[agari toJSON] dataUsingEncoding:NSUTF8StringEncoding]];
    return req;
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //reset previously received data
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"MjAPIConnection#connection:didFailWithError %@", error.description);
    
    [connection release];
    [receivedData release];
    
    //[delegate didFailWithError:error];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"receivedData = %@", receivedData);
    
    [connection release];
    [receivedData release];
}

@end
