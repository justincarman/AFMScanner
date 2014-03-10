//
//  CensusChildLocation.h
//  AFMScanner
//
//  Created by Justin Carman on 3/8/14.
//  Copyright (c) 2014 Justin Carman. All rights reserved.
//

#import "JSONModel.h"
@protocol CensusChildLocation @end
@interface CensusChildLocation : JSONModel

@property (nonatomic, strong) NSString *CensusID;
@property (nonatomic, strong) NSString *ChildLocationID;
@property (nonatomic, strong) NSString *ChildLocationCode;
@property (nonatomic, strong) NSString *ChildLocationName;
@property (nonatomic, strong) NSString *ChildLocationLongName;

@end
