//
//  TableViewSetting.h
//  MjTsumotter
//
//  Created by 健 荻野 on 12/03/25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Section;  //前方宣言
@class Cell; //前方宣言
typedef void(^SectionImplementHandler)(Section *section);
typedef void(^CellImplementHandler)(Cell *cell);

@interface TableViewSetting : NSObject

- (void)section:(SectionImplementHandler)handler;
- (NSString *)getTitleOfSection:(int)sectionIndex;
- (int)sectionCount;
- (int)cellCountOfSection:(int)sectionIndex;
- (int)getHeightOfSection:(int)sectionIndex cell:(int)cellIndex;
- (UITableViewCell *)getCellViewOfSection:(int)sectionIndex cell:(int)cellIndex;

@end

@interface Section : NSObject

@property (nonatomic, retain) NSString *title;

- (void)cell:(CellImplementHandler)handler;
- (int)cellCount;
- (int)getHeightOfCell:(int)cellIndex;
- (UITableViewCell *)getCellViewOfCell:(int)cellIndex;

@end

@interface Cell : NSObject

@property id* cellView;
@property (readonly) int height;

- (UITableViewCell *)getCellView;

@end