//
//  UIHelper.h
//  xcode-bootstrap
//
//  Created by Korbinian Hackl on 12/20/11.
//  Copyright (c) 2011 appropo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIHelper : NSObject {
    
    float posX;
    float posY;
    float widthIn;
    float heightIn;
    float fontSize;
    bool multiLine;
    
}

@property (nonatomic, readwrite) float posX;
@property (nonatomic, readwrite) float posY;
@property (nonatomic, readwrite) float widthIn;
@property (nonatomic, readwrite) float heightIn;
@property (nonatomic, readwrite) float fontSize;
@property (nonatomic, readwrite) bool multiLine;

- (void) setX:(float) x andY:(float) y;
- (void) setX:(float)x andY:(float)y andWidth:(float) width andHeight:(float) height;
- (void) setX:(float)x andY:(float)y andWidth:(float) width andHeight:(float) height andFontSize:(float) size;
- (void) adjustHeight;
- (void) adjustHeight:(float) height;

- (UIView *) createViewWithX:(float) x andY:(float) y andWidth:(float) width andHeight:(float) height andBgColor:(UIColor *) bgColor;

/* Label */

- (UILabel *) createLabelwithText:(NSString*) text andColor:(UIColor*) color andBold:(bool) bold;

- (UILabel *) createLabelCenterdwithText:(NSString*) text andColor:(UIColor*) color andBold:(bool) bold;

- (UILabel *) createLabelRightwithText:(NSString*) text andColor:(UIColor*) color andBold:(bool) bold;



/* ImageViews */

- (UIImageView *) createImageViewWithImgName:(NSString *) imageName;

- (UIImageView *) createImageViewWithImg:(UIImage *) img;

- (UIImageView *) createImageViewWithColor:(UIColor *) color;


/* Activity Indicator */

- (UIActivityIndicatorView *) createActivityIndicatorBigWhiteWithX:(float) x andY:(float) y andWidth:(float) width andHeight:(float) height;

- (UIActivityIndicatorView *) createActivityIndicatorWhiteWithX:(float) x andY:(float) y andWidth:(float) width andHeight:(float) height;


/* Scroll View */
- (UIScrollView *) createScrollViewWithBgolor:(UIColor *) bgColor andX:(float) x andY:(float) y andWidth:(float) width andHeight:(float) height andScrollWidth:(float) scrollWidth andScrollHeight:(float) scrollHeight andPaging:(BOOL) paging;


/* Text Field */
- (UITextField *) createTextFieldDefaultKeyboardWithPlaceholder:(NSString*) placeholder andColor:(UIColor*) color andDelegate:(id) delegate;

- (UITextField *) createTextFieldEmailKeyboardWithPlaceholder:(NSString*) placeholder andColor:(UIColor*) color andDelegate:(id) delegate;

- (UITextField *) createTextFieldPasswordDefaultKeyboardWithPlaceholder:(NSString*) placeholder andColor:(UIColor*) color andDelegate:(id) delegate;


/* segment control */
- (UISegmentedControl *) createSegmentControlWithElements:(NSArray *) itemArray andWidth:(float) width andHeight:(float) height;

/* buttons */
- (UIButton *) createButtonCustomWithTitle:(NSString *) title andBackgroundColor:(UIColor *) color andWidth:(float) width andHeight:(float) height andTarget:(id)target andAction:(SEL)action;

- (UIButton *) createButtonWithTitle:(NSString *) title andImageName:(NSString *) imageName andWidth:(float) width andHeight:(float) height andTarget:(id)target andAction:(SEL)action;

- (UIButton *) createButtonWithImg:(UIImageView *) image andWidth:(float) width andHeight:(float) height andTarget:(id)target andAction:(SEL)action;

- (UIButton *) createButtonInfoTypeWithX:(float) x andY:(float) y andTarget:(id)target andAction:(SEL)action;

/* Date Picker */
- (UIDatePicker *) createDatePickerWithTarget:(id)target andAction:(SEL)action;

@end
