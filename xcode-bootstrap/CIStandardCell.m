//
//  CIStandardCell.m
//  xcode-bootstrap
//
//  Created by khackl on 2/14/13.
//  Copyright (c) 2013 khackl. All rights reserved.
//

#import "CIStandardCell.h"

@implementation CIStandardCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
