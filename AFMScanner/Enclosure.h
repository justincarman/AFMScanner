//
//  Enclosure.h
//  AFMScanner
//
//  Created by Justin Carman on 3/9/14.
//  Copyright (c) 2014 Justin Carman. All rights reserved.
//

#import "JSONModel.h"
@protocol Enclosure @end
@interface Enclosure : JSONModel

@property (nonatomic, strong) NSString *EnclosureNumber;
@property (nonatomic, strong) NSString *InventoryID;
@property (nonatomic, strong) NSString *UseInventoryID;
@property (nonatomic) int CensusQTY;
@property (nonatomic) BOOL MissingEnclosure;
@property (nonatomic) BOOL RetireEnclosure;
@end
