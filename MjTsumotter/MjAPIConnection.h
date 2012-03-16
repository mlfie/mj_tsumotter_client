//
//  MjAPIConnection.h
//  MjTsumotter
//
//  Created by 健 荻野 on 12/03/16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Agari.h"

@interface MjAPIConnection : NSObject

- (void)authenticate;
- (BOOL)isAuthenticated;
- (void)sendAgari:(Agari *)agari;

@end
