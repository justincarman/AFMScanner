//
//  DetailViewController.m
//  AFMScanner
//
//  Created by Justin Carman on 3/5/14.
//  Copyright (c) 2014 Justin Carman. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "DetailViewController.h"
#import "ScannerViewController.h"
#import "LocationListParentViewController.h"
#import "EnclosuresViewController.h"
@interface DetailViewController () <AVCaptureMetadataOutputObjectsDelegate>
{
    NSString *barCodeScanned;
    BOOL goToEnclosure;
}
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (IBAction)unwindFromScanner:(UIStoryboardSegue *)fromScannerSegue
{
    ScannerViewController *scanner = (ScannerViewController *)fromScannerSegue.sourceViewController;
    barCodeScanned = scanner.barCodeScanned;
    goToEnclosure = YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"PushToParentLocations"]) {
        Census *object = self.detailItem;
        [[segue destinationViewController] setLocationListParentDetailItem:object];
    }
    else if ([[segue identifier] isEqualToString:@"PushToEnclosure"]) {
        [[segue destinationViewController] setScannedEnclosureNumber:barCodeScanned];
        [[segue destinationViewController] setCensusID:_detailItem.CensusID];
    }
}

-(IBAction)scanButtonClick:(id)sender
{
    NSLog(@"Scan button clicked");
}

- (IBAction)viewCensusLocationsClick:(id)sender
{
    NSLog(@"View locations button clicked");
}

- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.detailItem) {
        //self.detailDescriptionLabel.text = self.detailItem.CensusNumber;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    if (goToEnclosure)
    {
        goToEnclosure = NO;
        [self performSegueWithIdentifier:@"PushToEnclosure" sender:self];
    }
}
@end
