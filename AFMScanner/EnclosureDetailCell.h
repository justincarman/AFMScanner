//
//  EnclosureDetailCell.h
//  AFMScanner
//
//  Created by Justin Carman on 3/12/14.
//  Copyright (c) 2014 Justin Carman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeSelectableSegmentControl.h"
@class EnclosureDetailCell;
@protocol EnclosureCellDelegate
@required
- (void) qtyDidUpdate:(EnclosureDetailCell *)cell;
- (void) stepperDidUpdate:(EnclosureDetailCell *)cell;
- (void) segmentDidUpdate:(EnclosureDetailCell *)cell;
@end

@interface EnclosureDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *enclosureNumber;
@property (weak, nonatomic) IBOutlet UITextField *QTY;
@property (weak, nonatomic) IBOutlet UIStepper *stepper;
@property (weak, nonatomic) IBOutlet DeSelectableSegmentControl *enclosureStatus;

- (IBAction)valueChanged:(UIStepper *)sender;
- (IBAction)changedTextValue:(id)sender;
- (IBAction)segmentControlValueChanged:(DeSelectableSegmentControl *)sender;

@property (nonatomic, assign) NSInteger sectionIndex;
@property (nonatomic, assign) NSInteger rowIndex;
@property (nonatomic, weak) id<EnclosureCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *oldQTY;

@end