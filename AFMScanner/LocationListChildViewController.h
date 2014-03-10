//
//  LocationListChildViewController.h
//  AFMScanner
//
//  Created by Justin Carman on 3/9/14.
//  Copyright (c) 2014 Justin Carman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CensusParentLocation.h"
@interface LocationListChildViewController : UITableViewController

@property (strong, nonatomic) CensusParentLocation *childLocationDetailItem;

@end
