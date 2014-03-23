//
//  MasterViewController.h
//  AFMScanner
//
//  Created by Justin Carman on 3/5/14.
//  Copyright (c) 2014 Justin Carman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"
@interface MasterViewController : UITableViewController <ECSlidingViewControllerDelegate>
- (IBAction)menuButtonTapped:(id)sender;
@end
