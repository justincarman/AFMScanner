//
//  DetailViewController.h
//  AFMScanner
//
//  Created by Justin Carman on 3/5/14.
//  Copyright (c) 2014 Justin Carman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Census.h"
@interface DetailViewController : UIViewController

@property (strong, nonatomic) Census *detailItem;

- (IBAction)scanButtonClick:(id)sender;
- (IBAction)viewCensusLocationsClick:(id)sender;
@end
