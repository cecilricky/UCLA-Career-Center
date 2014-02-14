//
//  DetailViewController.h
//  Parsing
//
//  Created by liyizhi kou on 14-2-13.
//  Copyright (c) 2014年 UCLA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
