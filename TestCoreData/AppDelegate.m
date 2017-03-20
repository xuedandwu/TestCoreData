//
//  AppDelegate.m
//  TestCoreData
//
//  Created by Xuedan on 2017/3/6.
//  Copyright © 2017年 Xuedan. All rights reserved.
//

#import "AppDelegate.h"
#import "Student+CoreDataClass.h"
#import "Student+CoreDataProperties.h"

@interface AppDelegate ()

@property (nonatomic,readwrite,strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic,readwrite,strong) NSPersistentStoreCoordinator *persistentStorCoordinator;
@property (nonatomic, readwrite, strong) NSManagedObjectContext *context;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    Student *student = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.context];
    student.studentName = @"小明";
    student.studentId = 1;
    student.studentAge = 20;
    
    NSError *error;
    
    [self.context save:&error];
    
    
    NSFetchRequest *fetchRequest = [Student fetchRequest];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"studentAge > %@",@(20)];
    
    NSArray <NSSortDescriptor *> *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"studentName" ascending:YES]];
    fetchRequest.sortDescriptors = sortDescriptors;
    
    NSArray <Student *> *students = [self.context executeFetchRequest:fetchRequest error:nil];
    
    NSLog(@"ary:%@",students);
    
    
    for (Student *student in students) {
        [self.context deleteObject:student];
    }
    
    [self.context save:nil];
    
    for (Student *student in students) {
        student.studentName = @"newName";
    }
    
    [self.context save:nil];
    
    
    
    NSLog(@"ary:%@",students);
    
    for (NSUInteger i=0; i<1000; i++) {
        Student *newStudent = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.context];
        
        int16_t stuId  = arc4random_uniform(9999);
        
        newStudent.studentName = [NSString stringWithFormat:@"student-%d",stuId];
        newStudent.studentId = stuId;
        newStudent.studentAge = arc4random_uniform(10)+10;
        
    }
    
    [self.context save:nil];
    
    [students setValue:@"anotherName" forKeyPath:@"studentName"];
    
    [self batchUpdate];
    
    [self batchDelete];
    
    [self insertNew];
    
    
    return YES;
}

- (void)insertNew{
    Student *student = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.context];
    
    Clazz *clazz = [[Clazz alloc] initWithContext:self.context];
    
    student.studentClass = clazz;
    
    Course *english = [[Course alloc] initWithContext:self.context];
    Course *math = [[Course alloc] initWithContext:self.context];
    
    [student addStudentCoursesObject:english];
    [student addStudentCourses:[NSSet setWithObjects:english, math, nil]];
    
    [self.context save:nil];
    

}

- (void)batchUpdate{
    
    NSError *error;
    
    NSBatchUpdateRequest *updateRequest = [[NSBatchUpdateRequest alloc] initWithEntity:[Student entity]];
    
//    NSBatchUpdateRequest *updateRequest = [[NSBatchUpdateRequest alloc] initWithEntityName:@"Student"];
    
    updateRequest.predicate = [NSPredicate predicateWithFormat:@"studentAge == %@",@(20)];
    
    updateRequest.propertiesToUpdate = @{@"studentName":@"anotherName"};
    
    updateRequest.resultType = NSUpdatedObjectIDsResultType;
    
    NSBatchUpdateResult *updateResult = [self.context executeRequest:updateRequest error:&error];
    
    NSArray <NSManagedObjectID *> *updateObjectIDs = updateResult.result;
    
//    NSLog(@"updateObjectIDs:%@",updateObjectIDs);
    
    NSDictionary *updateDict = @{NSUpdatedObjectsKey : updateObjectIDs};
    [NSManagedObjectContext mergeChangesFromRemoteContextSave:updateDict intoContexts:@[self.context]];
    NSLog(@"updateDict:%@",updateDict);
    
    
}

- (void)batchDelete{
    NSFetchRequest *deleteFetch = [Student fetchRequest];
    
    deleteFetch.predicate = [NSPredicate predicateWithFormat:@"studentAge ==%@",@(20)];
    
    NSBatchDeleteRequest *deleteRequest = [[NSBatchDeleteRequest alloc] initWithFetchRequest:deleteFetch];
    deleteRequest.resultType = NSBatchDeleteResultTypeObjectIDs;
    
    NSBatchUpdateResult *deleteResult = [self.context executeRequest:deleteRequest error:nil];
    NSArray <NSManagedObjectID *> *deleteObjectIDs = deleteResult.result;
    
    NSDictionary *deleteDict = @{NSDeletedObjectsKey : deleteObjectIDs};
    [NSManagedObjectContext mergeChangesFromRemoteContextSave:deleteDict intoContexts:@[self.context]];
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"TestCoreData"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


#pragma mark - CoreData
- (NSManagedObjectModel *)managedObjectModel{
    if (!_managedObjectModel) {
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"TestCoreData" withExtension:@"momd"];
        
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
        
    }
    
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStorCoordinator{
    if (!_persistentStorCoordinator) {
        _persistentStorCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
        NSURL *sqliteURL = [[self documentDirectoryURL] URLByAppendingPathComponent:@"TestCoreData.sqlite"];
        NSError *error;
        [_persistentStorCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                 configuration:nil
                                                           URL:sqliteURL
                                                       options:nil
                                                         error:&error];
        
        if (error) {
            NSLog(@"falied to create persistentStoreCoordinator %@", error.localizedDescription);
        }
    }
    
    return _persistentStorCoordinator;
}

- (NSManagedObjectContext *)context{
    // 指定 context 的并发类型： NSMainQueueConcurrencyType 或 NSPrivateQueueConcurrencyType
    if (!_context) {
        _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _context.persistentStoreCoordinator = self.persistentStorCoordinator;
    }
    
    return _context;
}

// 用来获取 document 目录
- (nullable NSURL *)documentDirectoryURL {
    return [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
}

@end
