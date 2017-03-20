//
//  Clazz+CoreDataProperties.m
//  TestCoreData
//
//  Created by Xuedan on 2017/3/20.
//  Copyright © 2017年 Xuedan. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Clazz+CoreDataProperties.h"

@implementation Clazz (CoreDataProperties)

+ (NSFetchRequest<Clazz *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Clazz"];
}

@dynamic classId;
@dynamic clazzName;
@dynamic classStudents;

@end
