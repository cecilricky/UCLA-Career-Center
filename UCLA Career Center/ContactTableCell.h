//
//  ContactTableCell.h
//  UCLA Career Center
//
//  Created by Ricky Yu on 2/9/14.
//  Copyright (c) 2014 Ricky Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactTableCell : UITableViewCell

@property (nonatomic, weak)IBOutlet UILabel *namelabel;
@property (nonatomic, weak)IBOutlet UILabel *numberlabel;
@property (nonatomic, weak)IBOutlet UILabel *emaillabel;
@end
