//
//  Census.h
//  AFMScanner
//
//  Created by Justin Carman on 3/5/14.
//  Copyright (c) 2014 Justin Carman. All rights reserved.
//

#import "JSONModel.h"

@interface Census : JSONModel

@property (nonatomic, strong) NSString *CensusNumber;
@property (nonatomic, strong) NSString *CensusID;
@property (nonatomic, strong) NSString *CompletedDate;
@property (nonatomic, strong) NSString *CensusStartDate;
@property (nonatomic, strong) NSString *CensusEndDate;
@property (nonatomic, readonly) BOOL isCensusCompleted;

@end
