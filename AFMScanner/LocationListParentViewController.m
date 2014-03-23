//
//  LocationListParentViewController.m
//  AFMScanner
//
//  Created by Justin Carman on 3/9/14.
//  Copyright (c) 2014 Justin Carman. All rights reserved.
//

#import "LocationListParentViewController.h"
#import "LocationListChildViewController.h"
#import "CensusParentLocation.h"
#import "CensusChildLocation.h"
#import "ProgressHUD.h"

@interface LocationListParentViewController () {
    NSMutableArray *_objects;
}
@end

@implementation LocationListParentViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [ProgressHUD show:@"Loading..."];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://sb5current.dev18.development.infoedglobal.com/FMNET2/Mobile/Handlers/CensusHandler.ashx?method=GetCensusLocations&CensusID=%@", self.locationListParentDetailItem.CensusID]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            //Parse Data
            dispatch_async(dispatch_get_main_queue(), ^{
                if (data) {
                    NSError *jsonError;
                    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
                    _objects = [CensusParentLocation arrayOfModelsFromDictionaries:json];
                    [ProgressHUD dismiss];
                    [[self tableView] reloadData];
                }
                else {
                    [ProgressHUD showError:@"Unable to connect." Interacton:NO];
                    NSLog(@"Unable to connect to webservice");
                }
            });
        }];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    CensusParentLocation *loc = _objects[indexPath.row];
    cell.textLabel.text = loc.ParentLocationName;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"PushToChildLocations"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        CensusParentLocation *childLocation = (CensusParentLocation *)_objects[indexPath.row];
        [[segue destinationViewController] setChildLocationDetailItem:childLocation];
        //LocationListChildViewController *child = (LocationListChildViewController *) segue.destinationViewController;

        //child.childLocationDetailItem = object;
        //self.detailDescriptionLabel.text = scanner.barCodeScanned;
        //[[segue destinationViewController] childLocationDetailItem:object];
        //[[segue destinationViewController] childLocationDetailItem:object];
    }
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
