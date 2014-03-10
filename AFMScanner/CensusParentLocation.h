//
//  CensusParentLocation.h
//  AFMScanner
//
//  Created by Justin Carman on 3/8/14.
//  Copyright (c) 2014 Justin Carman. All rights reserved.
//

#import "CensusChildLocation.h"
#import "JSONModel.h"
@interface CensusParentLocation : JSONModel

@property (nonatomic, strong) NSString *CensusID;
@property (nonatomic, strong) NSString *ParentLocationID;
@property (nonatomic, strong) NSString *ParentLocationCode;
@property (nonatomic, strong) NSString *ParentLocationName;
@property (nonatomic, strong) NSArray<CensusChildLocation> *CensusChildLocations;

@end
