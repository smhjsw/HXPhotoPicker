//
//  HXPhotoEditGridMaskLayer.h
//  photoEditDemo
//
//  Created by 洪欣 on 2020/6/29.
//  Copyright © 2020 洪欣. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HXPhotoEditGridMaskLayer : CAShapeLayer

/** 遮罩颜色 */
@property (nonatomic, assign) CGColorRef maskColor;
/** 遮罩范围 */
@property (nonatomic, assign, setter=setMaskRect:) CGRect maskRect;
- (void)setMaskRect:(CGRect)maskRect animated:(BOOL)animated;
/** 取消遮罩 */
- (void)clearMask;
- (void)clearMaskWithAnimated:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END
