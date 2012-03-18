//
//  MjAPIConnection.m
//  MjTsumotter
//
//  Created by 健 荻野 on 12/03/16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MjAPIConnection.h"
#import "R9HTTPRequest.h"

static NSString *MjAPI_URI = @"http://mjt.mjlife.jp/agaris.json";

@implementation MjAPIConnection
{
    RequestDidCompleteHandler m_handler;
}

- (void)dealloc
{
    if(m_handler) {
        Block_release(m_handler);
    }
    
    [super dealloc];
}


- (void)sendAgari:(MjAgari *)agari withHandler:(RequestDidCompleteHandler)handler
{
    m_handler = Block_copy(handler);
    R9HTTPRequest *req = [self createRequestAgari:agari];
    [req startRequest];
}

- (R9HTTPRequest *)createRequestAgari:(MjAgari *)agari
{
    R9HTTPRequest *req = [[R9HTTPRequest alloc] initWithURL:[NSURL URLWithString:MjAPI_URI]];
    [req setHTTPMethod:@"POST"];
    [req addHeader:@"application/json" forKey:@"Content-Type"];    
    [req setBody:[[agari toJSON] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [req setCompletionHandler:^(NSHTTPURLResponse *responseHeader, NSString *responseString) {
        NSLog(@"response = %@", responseString);
        m_handler(responseHeader, responseString, nil);
    }];
    
    [req setFailedHandler:^(NSError *error){
        NSLog(@"error = %@", error.description);
        m_handler(nil, nil, error);
    }];
    
    return req;
}

@end
