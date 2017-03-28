//
//  GroupButton.m
//  WavesAnimationDemo
//
//  Created by apple on 2017/3/28.
//  Copyright © 2017年 YangQiang. All rights reserved.
//

#import "GroupButton.h"

static NSMutableDictionary *groupDic = nil;

@interface GroupButton (){
    NSString *selectGroupId;
}

@end

@implementation GroupButton

- (instancetype)initWithDelegate:(id)delegate withGroupId:(NSString *)groupId{
    self = [super init];
    if (self) {
        _delegate = delegate;
        _groupId = groupId;
        [self addToGroupDicWithGroupId:groupId];
        [self addTarget:self action:@selector(BtnClicked) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return self;
}

- (void)addToGroupDicWithGroupId:(NSString *)groupId{
    if (!groupDic) {
        groupDic = [NSMutableDictionary new];
    }
    
    NSMutableArray *groupBtns = [groupDic objectForKey:groupId];
    if (!groupBtns) {
        groupBtns = [NSMutableArray array];
    }
    
    [groupBtns addObject:self];
    [groupDic setObject:groupBtns forKey:groupId];
    
    selectGroupId = [NSString stringWithFormat:@"%@_selected",groupId];
    NSMutableArray *selectArray = [groupDic objectForKey:selectGroupId];
    if (!selectArray) {
        selectArray = [NSMutableArray array];
    }
    [groupDic setObject:selectArray forKey:selectGroupId];
    
}
#pragma mark --- Events ----
- (void)BtnClicked{
    NSMutableArray *selectArray = [groupDic objectForKey:selectGroupId];
    if (!selectArray) {
        selectArray = [NSMutableArray array];
    }
    if ((selectArray.count >= self.maxCount) && (self.selected == false)) {
        
    }else{
        self.selected = !self.selected;
    }
    
    
    if (self.selected) {
        [self addToSelectGroup];
    }else{
        [self removeFromSelectGroup];
    }
    
    
}
#pragma mark - PrivateMethod
- (void)addToSelectGroup{
    
    NSMutableArray *selectArray = [groupDic objectForKey:selectGroupId];
    if (!selectArray) {
        selectArray = [NSMutableArray array];
    }
    
    NSMutableArray *array = [groupDic objectForKey:self.groupId];
    for (GroupButton *groupBtn in array) {
        if (groupBtn.selected && [groupBtn isEqual:self]) {
            if (selectArray.count < self.maxCount) {
                [selectArray addObject:groupBtn];
            }else{
                break;
            }
            
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(didSelectedRadioButton:withArray:groupId:)]) {
        [self.delegate didSelectedRadioButton:self withArray:selectArray groupId:self.groupId];
    }
    
}

- (void)removeFromSelectGroup{
    
    NSMutableArray *selectArray = [groupDic objectForKey:selectGroupId];
    
    if (selectArray.count > 0) {
        for (GroupButton *groupBtn in selectArray) {
            if ((!groupBtn.selected) && [groupBtn isEqual:self]) {
                [selectArray removeObject:groupBtn];
                break;
            }
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(didSelectedRadioButton:withArray:groupId:)]) {
        [self.delegate didSelectedRadioButton:self withArray:selectArray groupId:self.groupId];
    }
    
}
#pragma mark --- setter && getter ----
- (NSInteger)maxCount{
    if (_maxCount <= 0) {
        _maxCount = 3;
    }
    return _maxCount;
}
@end
