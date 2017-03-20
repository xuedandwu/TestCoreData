//
//  ViewController.m
//  TestCoreData
//
//  Created by Xuedan on 2017/3/6.
//  Copyright © 2017年 Xuedan. All rights reserved.
//

#import "ViewController.h"
#import "Dog+CoreDataProperties.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "Dog+CoreDataClass.h"


@interface ViewController (){
    
    AppDelegate *app;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    app = [UIApplication sharedApplication].delegate;
    
    [self createButtons];
    
    
}

- (void)createButtons{
    NSArray *ary = @[@"增",@"删",@"改",@"查"];
    
    for (int i=0; i<4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(30+i*60, 100, 40, 40);
        [btn setTitle:ary[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = i;
        [self.view addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)btnClick:(UIButton *)btn{
    switch (btn.tag) {
        case 0:
            [self coreDataAdd];
            break;
        case 1:
            [self coreDataDelete];
            break;
        case 2:
            [self coreDataUpdate];
            break;
        case 3:
            [self coreDataSelect];
            break;
            
        default:
            break;
    }
}

- (void)coreDataAdd{
    Dog *dog = [NSEntityDescription insertNewObjectForEntityForName:@"Dog" inManagedObjectContext:app.persistentContainer.viewContext];
    dog.name = [NSString stringWithFormat:@"花花%d",arc4random()%10];
    dog.sex = @"公";
    dog.age = [NSString stringWithFormat:@"%d",arc4random()%15];
    
    NSLog(@"增加完成");
    [app.persistentContainer.viewContext save:nil];
    
}

- (void)coreDataDelete{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Dog" inManagedObjectContext:app.persistentContainer.viewContext];
    NSFetchRequest *request = [NSFetchRequest new];
    [request setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name=%@",@"花花8"];
    [request setPredicate:predicate];
    
    NSArray *ary = [app.persistentContainer.viewContext executeFetchRequest:request error:nil];
    if (ary.count) {
        for (Dog *newDog in ary) {
            [app.persistentContainer.viewContext deleteObject:newDog];
        }
        
        [app.persistentContainer.viewContext save:nil];
        NSLog(@"删除完成");
    }else{
        NSLog(@"没有检索到数据");
    }
}

- (void)coreDataUpdate{
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Dog" inManagedObjectContext:app.persistentContainer.viewContext];
    
    NSFetchRequest *request = [NSFetchRequest new];
    [request setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name!=%@",@"小白107"];
    [request setPredicate:predicate];
    
    NSArray *ary = [app.persistentContainer.viewContext executeFetchRequest:request error:nil];
    if (ary.count) {
        for (Dog *newDog in ary) {
            newDog.name = @"小白107";
        }
        
        [app.persistentContainer.viewContext save:nil];
        NSLog(@"修改完成");
    }else{
        NSLog(@"无检索见过");
    }
    
}

- (void)coreDataSelect{
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Dog" inManagedObjectContext:app.persistentContainer.viewContext];
    NSFetchRequest *request = [NSFetchRequest new];
    [request setEntity:entity];
    
    NSArray *ary = [app.persistentContainer.viewContext executeFetchRequest:request error:nil];
    if (ary.count) {
        for (Dog *dog in ary) {
            NSLog(@"%@",dog.name);
        }
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
