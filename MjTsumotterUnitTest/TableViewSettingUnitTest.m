//
//  TableViewSettingUnitTest.m
//  MjTsumotter
//
//  Created by 健 荻野 on 12/03/25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TableViewSettingUnitTest.h"

@implementation TableViewSettingUnitTest
{
    TableViewSetting *setting;
    UITableViewCell *cellView1;
}

- (void)setUp
{
    setting = [[TableViewSetting alloc] init];
    cellView1 = [[UITableViewCell alloc] init];
    cellView1.bounds = CGRectMake(0, 0, 20, 20);
}

- (void)tearDown
{
    [setting release];
}

- (void)testSection
{
    [setting section:^(Section *section) {
        section.title = @"1番目";
        [section cell:^(Cell *cell) {
            cell.cellView = &cellView1;
        }];
    }];
    
    [setting section:^(Section *section) {
        section.title = @"2番目";
    }];
    
    STAssertEqualObjects([setting getTitleOfSection:0], @"1番目", @"TableViewSetting.getTitle should get title of Section");
    STAssertEqualObjects([setting getTitleOfSection:1], @"2番目", @"TableViewSetting.getTitle should get title of Section");
    
    STAssertEquals([setting sectionCount], 2, @"TableViewSetting.sectionCount should return number of Sections");
    
    STAssertEquals([setting cellCountOfSection:0], 1, @"TableViewSetting.cellCount should return number of Cells which specified Section hold");
    
    STAssertEquals([setting getHeightOfSection:0 cell:0], 20, @"TableViewSetting.getHeightOfSection:cell should return height of specified cell");
    
    STAssertEquals([setting getCellViewOfSection:0 cell:0], cellView1, @"TableViewSetting.getCellViewOfSection:cell should return cell view of specified cell");
}

@end
