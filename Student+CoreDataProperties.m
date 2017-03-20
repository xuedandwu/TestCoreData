//
//  Student+CoreDataProperties.m
//  TestCoreData
//
//  Created by Xuedan on 2017/3/20.
//  Copyright © 2017年 Xuedan. All rights reserved.
//

#import "Student+CoreDataProperties.h"

@implementation Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Student"];
}

@dynamic studentId;
@dynamic studentAge;
@dynamic studentName;

@end
