//
//  UIHelper.m
//  xcode-bootstrap
//
//  Created by Korbinian Hackl on 12/20/11.
//  Copyright (c) 2011 appropo. All rights reserved.
//

#import "UIHelper.h"

@implementation UIHelper 

@synthesize posX;
@synthesize posY;
@synthesize widthIn;
@synthesize heightIn;
@synthesize fontSize;
@synthesize multiLine;


- (id) init {
    self = [super init];
    if (self) {
        posX = 0;
        posY = 0;
        widthIn = 320;
        heightIn = 16;
        fontSize = 14;
        multiLine = YES;
    }
    return self;
}

- (void) setX:(float) x andY:(float) y {
    posX = x;
    posY = y;
}

- (void) setX:(float)x andY:(float)y andWidth:(float) width andHeight:(float) height {
    [self setX:x andY:y];
    widthIn = width;
    heightIn = height;
    
}

- (void) setX:(float)x andY:(float)y andWidth:(float) width andHeight:(float) height andFontSize:(float) size {
    [self setX:x andY:y andWidth:width andHeight:height];
    fontSize = size;
}

- (void) adjustHeight {
    posY += (heightIn);
}

- (void) adjustHeight:(float) height {
    posY += height;
}


- (UIView *) createViewWithX:(float) x andY:(float) y andWidth:(float) width andHeight:(float) height andBgColor:(UIColor *) bgColor {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
	view.backgroundColor = bgColor;
    return view;
    
}
/* Label */

- (UILabel *) createLabelwithText:(NSString*) text andColor:(UIColor*) color andBold:(bool) bold {

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(posX, posY, widthIn, heightIn)];
    label.text = text;
    label.textAlignment = UITextAlignmentLeft;
    label.textColor = color;
    label.backgroundColor = [UIColor clearColor];
    if (bold)
        label.font = [UIFont boldSystemFontOfSize:fontSize];
    else
        label.font = [UIFont systemFontOfSize:fontSize];
    
    if (multiLine) {
        label.numberOfLines = 0;
        label.adjustsFontSizeToFitWidth = NO;
        label.lineBreakMode = UILineBreakModeWordWrap;
        [label sizeToFit];
    }

    
    [self adjustHeight:label.frame.size.height];
    return label;
    
}

- (UILabel *) createLabelCenterdwithText:(NSString*) text andColor:(UIColor*) color andBold:(bool) bold {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(posX, posY, widthIn, heightIn)];
    label.text = text;
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = color;
    label.backgroundColor = [UIColor clearColor];
    if (bold)
        label.font = [UIFont boldSystemFontOfSize:fontSize];
    else
        label.font = [UIFont systemFontOfSize:fontSize];
    
    if (multiLine) {
        label.numberOfLines = 0;
        label.adjustsFontSizeToFitWidth = NO;
        label.lineBreakMode = UILineBreakModeWordWrap;
        [label sizeToFit];
    }
    
    [self adjustHeight:label.frame.size.height];
    return label;
}

- (UILabel *) createLabelRightwithText:(NSString*) text andColor:(UIColor*) color andBold:(bool) bold {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(posX, posY, widthIn, heightIn)];
    label.text = text;
    label.textAlignment = UITextAlignmentRight;
    label.textColor = color;
    label.backgroundColor = [UIColor clearColor];
    if (bold)
        label.font = [UIFont boldSystemFontOfSize:fontSize];
    else
        label.font = [UIFont systemFontOfSize:fontSize];
    
    if (multiLine) {
        label.numberOfLines = 0;
        label.adjustsFontSizeToFitWidth = NO;
        label.lineBreakMode = UILineBreakModeWordWrap;
        [label sizeToFit];
    }
    
    [self adjustHeight:label.frame.size.height];
    return label;
}

/* ImageViews */

- (UIImageView *) createImageViewWithImgName:(NSString *) imageName {

    UIImage *img = [UIImage imageNamed:imageName];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    imgView.frame = CGRectMake(posX, posY, widthIn, heightIn);
    
    [self adjustHeight];
    return imgView;
    
}

- (UIImageView *) createImageViewWithImg:(UIImage *) img {
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    imgView.frame = CGRectMake(posX, posY, widthIn, heightIn);
    
    [self adjustHeight];
    return imgView;
}

- (UIImageView *) createImageViewWithColor:(UIColor *) color  {
    
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.frame = CGRectMake(posX, posY, widthIn, heightIn);
    imgView.backgroundColor = color;
    
    [self adjustHeight];
    return imgView;

}

/* Activity indicator */

- (UIActivityIndicatorView *) createActivityIndicatorBigWhiteWithX:(float) x andY:(float) y andWidth:(float) width andHeight:(float) height {
    
    UIActivityIndicatorView *actIndi = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    actIndi.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    [actIndi setHidden:NO];
    [actIndi setHidesWhenStopped:YES];
    [actIndi startAnimating];
    
    return actIndi;


    
}

- (UIActivityIndicatorView *) createActivityIndicatorWhiteWithX:(float) x andY:(float) y andWidth:(float) width andHeight:(float) height {
    
    UIActivityIndicatorView *actIndi = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    actIndi.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    [actIndi setHidden:NO];
    [actIndi setHidesWhenStopped:YES];
    [actIndi startAnimating];
    
    return actIndi;

}

/* Scroll View */
- (UIScrollView *) createScrollViewWithBgolor:(UIColor *) bgColor andX:(float) x andY:(float) y andWidth:(float) width andHeight:(float) height andScrollWidth:(float) scrollWidth andScrollHeight:(float) scrollHeight andPaging:(BOOL) paging {
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    scrollView.backgroundColor = bgColor;
    
    [scrollView setContentSize:CGSizeMake(scrollWidth, scrollHeight)];
    [scrollView setPagingEnabled:paging];
    
    return scrollView;
}


/* Text Field */

- (UITextField *) createTextFieldDefaultKeyboardWithPlaceholder:(NSString*) placeholder andColor:(UIColor*) color andDelegate:(id) delegate {
    
    UITextField * textFieldRounded = [[UITextField alloc] initWithFrame:CGRectMake(posX, posY, widthIn, heightIn + 7)];
    textFieldRounded.borderStyle = UITextBorderStyleRoundedRect;
    textFieldRounded.textColor = color;
    textFieldRounded.font = [UIFont systemFontOfSize:fontSize];
    textFieldRounded.placeholder = placeholder;
    textFieldRounded.backgroundColor = [UIColor whiteColor];
    textFieldRounded.autocorrectionType = UITextAutocorrectionTypeNo;
    
    textFieldRounded.keyboardType = UIKeyboardTypeDefault;
    textFieldRounded.returnKeyType = UIReturnKeyDone;
    
    textFieldRounded.clearButtonMode = UITextFieldViewModeWhileEditing;	
    textFieldRounded.delegate = delegate;
    
    [self adjustHeight:heightIn + 7];
    return textFieldRounded;

}

- (UITextField *) createTextFieldEmailKeyboardWithPlaceholder:(NSString*) placeholder andColor:(UIColor*) color andDelegate:(id) delegate {
    
    UITextField * textFieldRounded = [[UITextField alloc] initWithFrame:CGRectMake(posX, posY, widthIn, heightIn + 7)];
    textFieldRounded.borderStyle = UITextBorderStyleRoundedRect;
    textFieldRounded.textColor = color;
    textFieldRounded.font = [UIFont systemFontOfSize:fontSize];
    textFieldRounded.placeholder = placeholder;
    textFieldRounded.backgroundColor = [UIColor whiteColor];
    textFieldRounded.autocorrectionType = UITextAutocorrectionTypeNo;
    
    textFieldRounded.keyboardType = UIKeyboardTypeEmailAddress;
    textFieldRounded.returnKeyType = UIReturnKeyDone;
    
    textFieldRounded.clearButtonMode = UITextFieldViewModeWhileEditing;	
    textFieldRounded.delegate = delegate;
    
    [self adjustHeight:heightIn + 7];
    return textFieldRounded;
    
}

- (UITextField *) createTextFieldPasswordDefaultKeyboardWithPlaceholder:(NSString*) placeholder andColor:(UIColor*) color andDelegate:(id) delegate {
    
    UITextField * textFieldRounded = [[UITextField alloc] initWithFrame:CGRectMake(posX, posY, widthIn, heightIn + 7)];
    textFieldRounded.borderStyle = UITextBorderStyleRoundedRect;
    textFieldRounded.textColor = color;
    textFieldRounded.font = [UIFont systemFontOfSize:fontSize];
    textFieldRounded.placeholder = placeholder;
    textFieldRounded.backgroundColor = [UIColor whiteColor];
    textFieldRounded.autocorrectionType = UITextAutocorrectionTypeNo;
    
    textFieldRounded.keyboardType = UIKeyboardTypeDefault;
    textFieldRounded.secureTextEntry = YES;
    textFieldRounded.returnKeyType = UIReturnKeyDone;
    
    textFieldRounded.clearButtonMode = UITextFieldViewModeWhileEditing;	
    textFieldRounded.delegate = delegate;
    
    [self adjustHeight:heightIn + 7];
    return textFieldRounded;
    
}

/* segment control */
- (UISegmentedControl *) createSegmentControlWithElements:(NSArray *) itemArray andWidth:(float) width andHeight:(float) height {

    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
    segmentedControl.frame = CGRectMake(posX, posY, width, height);
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    segmentedControl.selectedSegmentIndex = 1;
    
    [self adjustHeight:height];

    return segmentedControl;
}


/* UIButtons */
- (UIButton *) createButtonCustomWithTitle:(NSString *) title andBackgroundColor:(UIColor *) color andWidth:(float) width andHeight:(float) height andTarget:(id)target andAction:(SEL)action {

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:target 
               action:action
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundColor:color];
    [button setFont:[UIFont boldSystemFontOfSize:fontSize]];
    button.frame = CGRectMake(posX, posY, width, height);
    
    [self adjustHeight:height];
    posY -= 25;
    return button;
}

- (UIButton *) createButtonWithTitle:(NSString *) title andImageName:(NSString *) imageName andWidth:(float) width andHeight:(float) height andTarget:(id)target andAction:(SEL)action {

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:target 
               action:action
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [button setFont:[UIFont systemFontOfSize:fontSize]];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]].image forState:UIControlStateNormal];
    button.frame = CGRectMake(posX, posY, width, height);
    
    [self adjustHeight:height];
    posY -= 25;
    return button;
    
}

- (UIButton *) createButtonWithImg:(UIImageView *) image andWidth:(float) width andHeight:(float) height andTarget:(id)target andAction:(SEL)action {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:target 
               action:action
     forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:image.image forState:UIControlStateNormal];
    //[button setBackgroundImage:image.image forState:UIControlStateHighlighted];
    //[button setBackgroundImage:image.image forState:UIControlStateSelected];
    [button setFont:[UIFont boldSystemFontOfSize:fontSize]];
    button.frame = CGRectMake(posX, posY, width, height);
    
    [self adjustHeight:height];
    posY -= 2;
    return button;

}

- (UIButton *) createButtonInfoTypeWithX:(float) x andY:(float) y andTarget:(id)target andAction:(SEL)action {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [button addTarget:target 
               action:action
     forControlEvents:UIControlEventTouchUpInside];
    [button setFont:[UIFont systemFontOfSize:fontSize]];
    button.frame = CGRectMake(x, y, 18, 18);
    posY -= 2;
    return button;
    
}

/* Date Picker */
- (UIDatePicker *) createDatePickerWithTarget:(id)target andAction:(SEL)action {
    
    UIDatePicker *myPicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,250,0,0)];
    [myPicker addTarget:target action:action forControlEvents:UIControlEventValueChanged];
    [myPicker setDatePickerMode:UIDatePickerModeDate];
    return myPicker;
}



@end
