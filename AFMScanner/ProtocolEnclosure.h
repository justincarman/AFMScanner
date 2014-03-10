//
//  ProtocolEnclosure.h
//  AFMScanner
//
//  Created by Justin Carman on 3/9/14.
//  Copyright (c) 2014 Justin Carman. All rights reserved.
//

#import "JSONModel.h"
#import "Enclosure.h"
@interface ProtocolEnclosure : JSONModel

@property (nonatomic, strong) NSString *CensusID;
@property (nonatomic, strong) NSString *ProtocolNumber;
@property (nonatomic, strong) NSString *ProtocolProjID;
@property (nonatomic, strong) NSArray <Enclosure> *Enclosures;

@end
