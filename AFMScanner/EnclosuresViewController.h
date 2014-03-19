//
//  EnclosuresViewController.h
//  AFMScanner
//
//  Created by Justin Carman on 3/9/14.
//  Copyright (c) 2014 Justin Carman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CensusChildLocation.h"
#import "EnclosureDetailCell.h"
@interface EnclosuresViewController : UITableViewController <EnclosureCellDelegate>

@property (strong, nonatomic) CensusChildLocation *enclosureDetailItem;

@property (strong, nonatomic) NSString *censusID;
@property (strong, nonatomic) NSString *scannedEnclosureNumber;

- (IBAction)saveClasses:(id)sender;

@end
