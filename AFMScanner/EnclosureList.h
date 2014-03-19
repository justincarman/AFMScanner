//
//  EnclosureList.h
//  AFMScanner
//
//  Created by Justin Carman on 3/18/14.
//  Copyright (c) 2014 Justin Carman. All rights reserved.
//

#import "JSONModel.h"
#import "Enclosure.h"
@interface EnclosureList : JSONModel

@property (nonatomic, strong) NSArray <Enclosure> *enclosures;

@end
