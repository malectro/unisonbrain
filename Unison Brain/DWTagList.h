//
//  DWTagList.h
//
//  Created by Dominic Wroblewski on 07/07/2012.
//  Copyright (c) 2012 Terracoding LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DWTagList : UIView
{
    UIView *view;
    NSArray *textArray;
    CGSize sizeFit;
    UIColor *lblBackgroundColor;
    UIColor *textColor;
}

@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) NSArray *textArray;

- (void)setLabelBackgroundColor:(UIColor *)color;
- (void)setTextColor:(UIColor *)color;
- (void)setTags:(NSArray *)array;
- (void)display;
- (CGSize)fittedSize;

@end
