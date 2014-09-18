//
//  TTDataSourceManager.m
//  TwentyThousandThomatoes
//
//  Created by lihux on 14-9-9.
//  Copyright (c) 2014年 lihux. All rights reserved.
//

#import "TTDataSourceManager.h"

@interface TTDataSourceManager ()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;

@end

@implementation TTDataSourceManager

+ (instancetype)sharedInstance
{
    static TTDataSourceManager *sharedObject;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObject = [[self alloc] init];
        if (sharedObject) {
            [sharedObject prepareMOC];
        }
    });
    return sharedObject;
}

- (void)prepareMOC
{
    self.managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"TTTomatoes" withExtension:@"momd"]];
    self.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    NSURL *documentURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storeURL = [documentURL URLByAppendingPathComponent:@"ttdatasource.sqlite"];
    NSError *error = nil;
    if (![self.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"fail to create core data persistent store, reason: %@", error);
        NSAssert(NO, @"fail to create core data persistent store, reason: %@", error);
    }

    self.managedObjectContext = [[NSManagedObjectContext alloc] init];
    [self.managedObjectContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];
}

- (BOOL)saveManagedObjectContext
{
    NSError *error = nil;
    [self.managedObjectContext save:&error];
    if (error) {
        NSLog(@"fail to save moc, reason: %@", error);
        return NO;
    }
    return YES;
}

- (NSManagedObject *)createManagedObjectWithEntityName:(NSString *)entityName
{
    id object = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:self.managedObjectContext];
    NSAssert(object, @"fail to create managedObject of entity name: %@", entityName);
    return object;
}

- (BOOL)deleteManagedObject:(NSManagedObject *)manangedObject
{
    [self.managedObjectContext deleteObject:manangedObject];
    return [self saveManagedObjectContext];
}

- (NSArray *)searchManagedObjectWithEntityName:(NSString *)entityName
{
    NSError *error = nil;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:entityName];
    return [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
}

@end
