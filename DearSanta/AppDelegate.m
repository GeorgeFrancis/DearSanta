//
//  AppDelegate.m
//  DearSanta
//
//  Created by George Francis on 07/11/2014.
//  Copyright (c) 2014 GeorgeFrancis. All rights reserved.
//

#import "AppDelegate.h"
#import "BabyName.h"
#import <Parse/Parse.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self loadInBabyNames];
    [self setAppearance];
    
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]){
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
    [Parse setApplicationId:@"2HPuaiZ6PT7sD6kLzKRMF85DLIZvSjbhGEMJ1DvF" clientKey:@"M9S80BeVSv992uUHtPRSvJIBiFpSPoMSKwqvZErv"];
    
    return YES;
}

-(void)setAppearance
{
    [[UIApplication sharedApplication]setStatusBarHidden:YES];

    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSObject *object = [prefs objectForKey:@"ColorTheme"];
    if(object != nil){
        
        NSData *colourData = [[NSUserDefaults standardUserDefaults]objectForKey:@"ColorTheme"];
        UIColor *color = [NSKeyedUnarchiver unarchiveObjectWithData:colourData];
        
        [[UINavigationBar appearance]setBackgroundColor:color];
        [[UINavigationBar appearance] setBarTintColor:color];
        [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
        [[UINavigationBar appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
      //  [[UIBarButtonItem appearance] setTintColor:[]];
      //  [[UINavigationController appearance]toolbar.barTintColor:color];
    }
    else {
        
        UIColor *startUpColour = [UIColor colorWithRed:0.945 green:0.329 blue:0.043 alpha:1];
        
        NSData *startUpColourData = [NSKeyedArchiver archivedDataWithRootObject:startUpColour];
        [[NSUserDefaults standardUserDefaults]setObject:startUpColourData forKey:@"ColorTheme"];
        
        [[UINavigationBar appearance]setBackgroundColor:startUpColour];
        [[UINavigationBar appearance] setBarTintColor:startUpColour];
        [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
        [[UINavigationBar appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
         }
}

-(void)setAppearance:(UIColor*)themeColor{
    
    [[UINavigationBar appearance]setBackgroundColor:themeColor];
      [[UINavigationBar appearance] setBarTintColor:themeColor];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - App Setup

- (void)loadInBabyNames
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"BabyName"];
    
    NSInteger existingNamesCount = [self.managedObjectContext countForFetchRequest:fetchRequest error:nil];
    
    if (existingNamesCount == 0)
    {
        NSURL *boyPlistPath = [[NSBundle mainBundle]URLForResource:@"boysnames" withExtension:@"plist"];
        NSURL *girlPlistPath = [[NSBundle mainBundle]URLForResource:@"girlsnames" withExtension:@"plist"];
        
        [self addNameToCoreDataFromArray:[NSArray arrayWithContentsOfURL:boyPlistPath] isBoy:YES];
        [self addNameToCoreDataFromArray:[NSArray arrayWithContentsOfURL:girlPlistPath] isBoy:NO];
        
        [self.managedObjectContext save:nil];
        
        NSLog(@"Saved names");
    }
    else
    {
        NSLog(@"Already have %ld names", (long)existingNamesCount);
    }
}

- (void)addNameToCoreDataFromArray:(NSArray*)array isBoy:(BOOL)isBoy
{
    for (NSDictionary *nameDict in array)
    {
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"BabyName"
                                                             inManagedObjectContext:self.managedObjectContext];
        
        BabyName *nameObject = (BabyName*)[[NSManagedObject alloc]initWithEntity:entityDescription
                                                  insertIntoManagedObjectContext:self.managedObjectContext];
        
        nameObject.name = nameDict[@"Name"];
        nameObject.nameOrigin = nameDict[@"NameOrigin"];
        nameObject.isBoy = [NSNumber numberWithBool:isBoy];
    }
}

- (Baby*)baby
{
    if (_baby == nil)
    {
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Baby"];
        
        _baby = [[self.managedObjectContext executeFetchRequest:fetchRequest error:nil]lastObject];
        
        if (_baby == nil) {
            NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Baby"
                                                                 inManagedObjectContext:self.managedObjectContext];

            _baby = (Baby*)[[NSManagedObject alloc]initWithEntity:entityDescription
                                                      insertIntoManagedObjectContext:self.managedObjectContext];
        }
    }
    
    return _baby;
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "G.DearSanta" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"DearSanta" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"model.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


@end
