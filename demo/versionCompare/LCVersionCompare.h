//
//  LCVersionCompare.h
//  PartnerApp
//
//  Created by lc on 3/31/15.
//  Copyright (c) 2015 xulicheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCVersionCompare : NSObject

@property (nonatomic, assign) NSInteger isUpdate;

- (void)versionDataParse:(NSDictionary *)dataDic;
- (void)versionAlert;

@end
