//
//  GroupButton.h
//  WavesAnimationDemo
//
//  Created by apple on 2017/3/28.
//  Copyright © 2017年 YangQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  GroupButtonDelegate;

@interface GroupButton : UIButton

@property (nonatomic , copy)id<GroupButtonDelegate> delegate;
@property (nonatomic , copy)NSString *groupId;
@property (nonatomic , assign)NSInteger maxCount;

- (instancetype)initWithDelegate:(id)delegate withGroupId:(NSString *)groupId;

@end

@protocol GroupButtonDelegate <NSObject>

- (void)didSelectedRadioButton:(GroupButton *)groupBtn withArray:(NSMutableArray *)selectBtns groupId:(NSString *)groupId;

@end
