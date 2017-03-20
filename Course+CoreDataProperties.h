//
//  Course+CoreDataProperties.h
//  TestCoreData
//
//  Created by Xuedan on 2017/3/20.
//  Copyright © 2017年 Xuedan. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Course+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Course (CoreDataProperties)

+ (NSFetchRequest<Course *> *)fetchRequest;

@property (nonatomic) int16_t chapterCount;
@property (nonatomic) int16_t courseId;
@property (nullable, nonatomic, copy) NSString *courseName;
@property (nullable, nonatomic, retain) Student *courseStudents;

@end

NS_ASSUME_NONNULL_END
