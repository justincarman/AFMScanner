//
//  DetailViewController.h
//  AFMScanner
//
//  Created by Justin Carman on 3/5/14.
//  Copyright (c) 2014 Justin Carman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSObject *detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

-(IBAction)scanButtonClick:(id)sender;

@end
