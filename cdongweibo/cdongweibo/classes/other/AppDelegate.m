//
//  AppDelegate.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/10.
//  Copyright © 2016年 man. All rights reserved.
//

#import "AppDelegate.h"
#import "CDAutherViewController.h"
#import "CDRootService.h"
#import "CDUserService.h"
#import "UIImageView+WebCache.h"
#import <AVFoundation/AVFoundation.h>
/**
 *  launchScreen 代替之前的启动图片
 好处：
 1.可以显示更多东西
 2.只需要一张启动图片即可
 
 启动图片的优先级
 启动图片 < LaunchScreen.xib
 
 程序中碰见模拟器尺寸不对，马上去找启动图片，默认模拟器的尺寸由启动图片决定。
 */

@interface AppDelegate ()

@property (nonatomic,strong) AVAudioPlayer *player;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self initWindow];
    
    //注册通知
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [application registerUserNotificationSettings:settings];
    
    
    // 设置音频会话
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    // 后台播放
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    // 单独播放一个后台程序
    [session setCategory:AVAudioSessionCategorySoloAmbient error:nil];
    
    [session setActive:YES error:nil];
    
    
    return YES;
}


- (void) initWindow
{
    //创建自定义窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor yellowColor];
    
    //创建tabbarview为   root view
//    CDTabBarController *tabBarVc = [[CDTabBarController alloc] init];
//    
//    self.window.rootViewController = tabBarVc;
    //UICollectionView must be initialized with a non-nil layout parameter'
    


    if ([CDUserService user]==nil) {
        //新浪应用授权
        CDAutherViewController *autherVc = [[CDAutherViewController alloc] init];
        self.window.rootViewController = autherVc;
    }else{
        [CDRootService chooseRootView:self.window];
    }
    

    [self.window makeKeyAndVisible];
    
}

//接受到内存警告时候调用
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    //停止所有图片下载
    [[SDWebImageManager sharedManager] cancelAll];
    //删除图片缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}

//应用程序失去焦点的时候
- (void)applicationWillResignActive:(UIApplication *)application {
    // 微博：在程序即将失去焦点的时候播放静音音乐.
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"silence.mp3" withExtension:nil];
    
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    
    [player prepareToPlay];
    //无线播放
    player.numberOfLoops = -1;
    
    [player play];
    _player = player;
}



//程序进入后台时候调用
- (void)applicationDidEnterBackground:(UIApplication *)application {

    //开启一个后台任务，时间不确定，优先级比较低，假如系统要管斌进程，首先就会考虑关闭这个
    UIBackgroundTaskIdentifier backId =  [application beginBackgroundTaskWithExpirationHandler:^{
        NSLog(@"%@",[NSThread currentThread]);
        //当后台任务结束时候调用
        [application endBackgroundTask:backId];
    }];
    
    // 如何提高后台任务的优先级，欺骗苹果，我们是后台播放程序
    
    // 但是苹果会检测你的程序当时有没有播放音乐，如果没有，有可能就干掉你
    
    // 微博：在程序即将失去焦点的时候播放静音音乐.
    
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

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.cdmq.cdongweibo" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"cdongweibo" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"cdongweibo.sqlite"];
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
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
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
