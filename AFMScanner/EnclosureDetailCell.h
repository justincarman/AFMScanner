//
//  EnclosureDetailCell.h
//  AFMScanner
//
//  Created by Justin Carman on 3/12/14.
//  Copyright (c) 2014 Justin Carman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeSelectableSegmentControl.h"

@interface EnclosureDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *enclosureNumber;
@property (weak, nonatomic) IBOutlet UITextField *QTY;
@property (weak, nonatomic) IBOutlet UIStepper *stepper;
@property (weak, nonatomic) IBOutlet DeSelectableSegmentControl *enclosureStatus;

- (IBAction)valueChanged:(UIStepper *)sender;
- (IBAction)changedTextValue:(id)sender;

@end
