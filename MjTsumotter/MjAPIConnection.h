//
//  MjAPIConnection.h
//  MjTsumotter
//
//  Created by 健 荻野 on 12/03/16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MjAgari.h"

@interface MjAPIConnection : NSObject
{
    id delegate;
    NSMutableData *receivedData;
}

- (void)authenticate;
- (BOOL)isAuthenticated;
- (void)sendAgari:(MjAgari *)agari delegate:(id)delegate;

@end
