//
//  Student+CoreDataProperties.h
//  TestCoreData
//
//  Created by Xuedan on 2017/3/20.
//  Copyright © 2017年 Xuedan. All rights reserved.
//

#import "Student+CoreDataClass.h"
#import "Course+CoreDataClass.h"
#import "Clazz+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest;

@property (nonatomic) int16_t studentId;
@property (nonatomic) int16_t studentAge;
@property (nullable, nonatomic, copy) NSString *studentName;

@property (nullable, nonatomic, retain) Clazz *studentClass;
@property (nullable, nonatomic, retain) NSSet <Course *> *studentCourses;

@end

@interface Student (CoreDataGeneratedAccssors)

- (void)addStudentCoursesObject:(Course *)value;
- (void)removeStudentCoursesObject:(Course *)value;
- (void)addStudentCourses:(NSSet <Course *> *)values;
- (void)removeStudentCourses:(NSSet <Course *> *)values;

@end

NS_ASSUME_NONNULL_END
