//
//  Yaku.h
//  MjTsumotter
//
//  Created by 寺師 佳彦 on 12/03/16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Yaku : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDecimalNumber * han_num;
@property (nonatomic, retain) NSDecimalNumber * naki_han_num;
@property (nonatomic, retain) NSString * kanji;

@end
