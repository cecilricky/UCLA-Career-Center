//
//  ContactTableCell.m
//  UCLA Career Center
//
//  Created by Ricky Yu on 2/9/14.
//  Copyright (c) 2014 Ricky Yu. All rights reserved.
//

#import "ContactTableCell.h"

@implementation ContactTableCell

@synthesize namelabel=_namelabel;
@synthesize numberlabel=_numberlabel;
@synthesize emaillabel=_emaillabel;
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
