//
//  Dog+CoreDataProperties.m
//  TestCoreData
//
//  Created by Xuedan on 2017/3/6.
//  Copyright © 2017年 Xuedan. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Dog+CoreDataProperties.h"

@implementation Dog (CoreDataProperties)

+ (NSFetchRequest<Dog *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Dog"];
}

@dynamic age;
@dynamic sex;
@dynamic name;

@end
