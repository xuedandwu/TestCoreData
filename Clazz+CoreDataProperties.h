//
//  Clazz+CoreDataProperties.h
//  TestCoreData
//
//  Created by Xuedan on 2017/3/20.
//  Copyright © 2017年 Xuedan. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Clazz+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Clazz (CoreDataProperties)

+ (NSFetchRequest<Clazz *> *)fetchRequest;

@property (nonatomic) int16_t classId;
@property (nullable, nonatomic, copy) NSString *clazzName;
@property (nullable, nonatomic, retain) Student *classStudents;

@end

NS_ASSUME_NONNULL_END
