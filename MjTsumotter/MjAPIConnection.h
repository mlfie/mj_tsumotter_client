//
//  MjAPIConnection.h
//  MjTsumotter
//
//  Created by 健 荻野 on 12/03/16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MjAgari.h"

typedef void(^RequestDidCompleteHandler)(NSHTTPURLResponse *responseHeader, NSString *responseString, NSError *error);

@interface MjAPIConnection : NSObject

- (void)authenticate;
- (BOOL)isAuthenticated;
- (void)sendAgari:(MjAgari *)agari withHandler:(RequestDidCompleteHandler)handler;

@end
