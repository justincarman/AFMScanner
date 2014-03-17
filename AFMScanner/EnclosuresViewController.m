//
//  EnclosuresViewController.m
//  AFMScanner
//
//  Created by Justin Carman on 3/9/14.
//  Copyright (c) 2014 Justin Carman. All rights reserved.
//

#import "EnclosuresViewController.h"
#import "ProtocolEnclosure.h"
#import "EnclosureDetailCell.h"
#import "ProgressHUD.h"
@interface EnclosuresViewController (){
    NSMutableArray *_objects;
}

@end

@implementation EnclosuresViewController

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
    NSURL *url;
    if (self.enclosureDetailItem != nil)
        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://betaora13.dev18.development.infoedglobal.com/FMNET2/Mobile/Handlers/CensusHandler.ashx?method=GetEnclosures&CensusID=%@&LocationID=%@", self.enclosureDetailItem.CensusID, self.enclosureDetailItem.ChildLocationID]];
    else
        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://betaora13.dev18.development.infoedglobal.com/FMNET2/Mobile/Handlers/CensusHandler.ashx?method=GetEnclosure&CensusID=%@&EnclosureNumber=%@", self.censusID, self.scannedEnclosureNumber]];
        
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            //Parse Data
            dispatch_async(dispatch_get_main_queue(), ^{
                if (data) {
                    NSError *jsonError;
                    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
                    _objects = [ProtocolEnclosure arrayOfModelsFromDictionaries:json];
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
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    gestureRecognizer.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:gestureRecognizer];
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
    return _objects.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    ProtocolEnclosure *enc = (ProtocolEnclosure *) _objects[section];
    return enc.ProtocolNumber;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ProtocolEnclosure *enc = (ProtocolEnclosure *) _objects[section];
    return enc.Enclosures.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    EnclosureDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    ProtocolEnclosure *loc = (ProtocolEnclosure *)_objects[indexPath.section];
    Enclosure *enc = (Enclosure *) loc.Enclosures[indexPath.row];
    cell.enclosureNumber.text = enc.EnclosureNumber;
    cell.QTY.text =[NSString stringWithFormat:@"%i", enc.CensusQTY];
    cell.stepper.value = enc.CensusQTY;
    if (enc.Verified)
    {
        cell.QTY.enabled = false;
        cell.stepper.enabled = false;
        cell.enclosureStatus.selectedSegmentIndex = Verified;
    }
    else if (enc.MissingEnclosure)
        cell.enclosureStatus.selectedSegmentIndex = MissingEnclosure;
    else if (enc.RetireEnclosure)
        cell.enclosureStatus.selectedSegmentIndex = RetireEnclosure;
    else
        cell.enclosureStatus.selectedSegmentIndex = None;
    
    return cell;
}

- (void)dismissKeyboard {
    [self.view endEditing:YES];
}

enum{
    Verified = 0,
    MissingEnclosure = 1,
    RetireEnclosure = 2,
    None = -1
};
typedef NSInteger EnclosureStatus;

- (void) tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = [[UIColor alloc] initWithRed:20.0 / 255 green:59.0 / 255 blue:102.0 / 255 alpha:.75];
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
