//
//  EnclosuresViewController.m
//  AFMScanner
//
//  Created by Justin Carman on 3/9/14.
//  Copyright (c) 2014 Justin Carman. All rights reserved.
//

#import "EnclosuresViewController.h"
#import "ProtocolEnclosure.h"
#import "ProgressHUD.h"
#import "Enclosure.h"
#import "EnclosureList.h"
#import "JSONModel+networking.h"
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
    [self loadJSON];
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    gestureRecognizer.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:gestureRecognizer];
}

- (void)loadJSON
{
    [ProgressHUD show:@"Loading..."];
    NSURL *url;
    if (self.enclosureDetailItem != nil)
        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://sb5current.dev18.development.infoedglobal.com/FMNET2/Mobile/Handlers/CensusHandler.ashx?method=GetEnclosures&CensusID=%@&LocationID=%@", self.enclosureDetailItem.CensusID, self.enclosureDetailItem.ChildLocationID]];
    else
        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://sb5current.dev18.development.infoedglobal.com/FMNET2/Mobile/Handlers/CensusHandler.ashx?method=GetEnclosure&CensusID=%@&EnclosureNumber=%@", self.censusID, self.scannedEnclosureNumber]];
    
    
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
    cell.oldQTY.text = enc.OldCount;
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
    
    cell.sectionIndex = indexPath.section;
    cell.rowIndex = indexPath.row;
    cell.delegate = self;
    
    return cell;
}

- (void) qtyDidUpdate:(EnclosureDetailCell *)cell{
    [self updateClasses:cell];
}

- (void) stepperDidUpdate:(EnclosureDetailCell *)cell{
    [self updateClasses:cell];
}

- (void) segmentDidUpdate:(EnclosureDetailCell *)cell{
    [self updateClasses:cell];
}

- (void)updateClasses:(EnclosureDetailCell *)enclosureCell{
    Enclosure *enc = (Enclosure*)((ProtocolEnclosure *)_objects[enclosureCell.sectionIndex]).Enclosures[enclosureCell.rowIndex];
    enc.CensusQTY = enclosureCell.QTY.text.intValue;
    
    if (enclosureCell.enclosureStatus.selectedSegmentIndex == Verified){
        enc.Verified = YES;
        enc.MissingEnclosure = NO;
        enc.RetireEnclosure = NO;
    }
    else if (enclosureCell.enclosureStatus.selectedSegmentIndex == MissingEnclosure){
        enc.Verified = NO;
        enc.MissingEnclosure = YES;
        enc.RetireEnclosure = NO;
    }
    else if (enclosureCell.enclosureStatus.selectedSegmentIndex == RetireEnclosure){
        enc.Verified = NO;
        enc.MissingEnclosure = NO;
        enc.RetireEnclosure = YES;
    }
    else{
        enc.Verified = NO;
        enc.MissingEnclosure = NO;
        enc.RetireEnclosure = NO;
    }
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

- (IBAction)saveClasses:(id)sender{
    NSMutableArray *enclosures = [[NSMutableArray alloc] init];
    //NSArray<Enclosure> *enclos;
    EnclosureList *listOfEnclosures = [[EnclosureList alloc] init];
    for (ProtocolEnclosure *protEnc in _objects){
        for (Enclosure *enc in protEnc.Enclosures){
            [enclosures addObject:enc];
            //[listOfEnclosures.arrOfEnclosures addObject:enc];
        }
    }
    
    listOfEnclosures.enclosures = (NSArray<Enclosure> *)[NSArray arrayWithArray:enclosures];
    NSString *string = [listOfEnclosures toJSONString];
    
    [ProgressHUD show:@"Saving..."];
    [JSONHTTPClient postJSONFromURLWithString:@"http://sb5current.dev18.development.infoedglobal.com/FMNET2/Mobile/Handlers/CensusHandler.ashx?method=SaveCensusEnclosures"
                                     bodyString:string
                                   completion:^(id json, JSONModelError *err) {
                                       //check err, process json ...
                                       if (err == nil)
                                       {
                                           [ProgressHUD showSuccess:@"Your data was saved." Interacton:NO];
                                       }
                                       else
                                           [ProgressHUD showError:@"An error occurred." Interacton:NO];
                                   }];
    //[self loadJSON];
}

@end
