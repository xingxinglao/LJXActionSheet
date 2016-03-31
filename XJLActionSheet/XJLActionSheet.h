//
//  XJLActionSheet.h
//  mayc
//
//  Created by 劳景醒 on 16/3/18.
//  Copyright © 2016年 laojingxing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XJLActionSheet;
@protocol MyActionSheetDelegate <NSObject>

@optional
- (void)myActionSheet:(XJLActionSheet *)actionSheet parentView:(UIView *)parentView subLabel:(UILabel *)subLabel index:(NSInteger)index;
@end


@interface XJLActionSheet : UIView <MyActionSheetDelegate>

@property (nonatomic,strong) UIWindow *mywindow;
@property (retain, nonatomic) UIView *parentView;
@property (nonatomic, assign) id<MyActionSheetDelegate> delgate;
@property (nonatomic, assign) CGRect paretViewFrame;
@property (nonatomic, copy) NSString *titleName;

@property (nonatomic, strong) NSMutableArray *titleNameArr;

- (void)show;

- (instancetype)initWithDelegate:(id)delegate title:(NSString *)title cancelButton:(NSString *)cancelButton otherTitle:(NSString *)otherTitle, ... NS_REQUIRES_NIL_TERMINATION;



@end
