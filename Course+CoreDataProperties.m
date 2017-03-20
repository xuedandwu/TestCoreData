//
//  Course+CoreDataProperties.m
//  TestCoreData
//
//  Created by Xuedan on 2017/3/20.
//  Copyright © 2017年 Xuedan. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Course+CoreDataProperties.h"

@implementation Course (CoreDataProperties)

+ (NSFetchRequest<Course *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Course"];
}

@dynamic chapterCount;
@dynamic courseId;
@dynamic courseName;
@dynamic courseStudents;

@end
