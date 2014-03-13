//
//  EnclosureDetailCell.m
//  AFMScanner
//
//  Created by Justin Carman on 3/12/14.
//  Copyright (c) 2014 Justin Carman. All rights reserved.
//

#import "EnclosureDetailCell.h"

@implementation EnclosureDetailCell

- (IBAction)changedTextValue:(id)sender
{
    self.stepper.value = self.QTY.text.intValue;
}

- (IBAction)valueChanged:(UIStepper *)sender
{
    int stepperValue = sender.value;
    self.QTY.text = [NSString stringWithFormat:@"%i", stepperValue];
}

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
