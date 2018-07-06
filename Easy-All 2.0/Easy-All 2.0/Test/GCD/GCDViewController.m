//
//  GCDViewController.m
//  Easy-All 2.0
//
//  Created by chensa on 2018/5/29.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import "GCDViewController.h"

@implementation GCDViewController

#pragma mark - LifeCycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self asyncConcurrent];
//    [self asyncSerial];
//    [self syncConcurrent];
    [self syncConcurrent];
    
}

#pragma mark - Delegate Methods

#pragma mark - Public Methods

#pragma mark - Private Methods
//异步执行 + 并行队列
- (void)asyncConcurrent
{
    //创建一个并行队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_queue_create("asyncConcurrent", DISPATCH_QUEUE_CONCURRENT);
    
    DDLogInfo(@"---asyncConcurrent start---");
    
    //使用异步函数封装三个任务
    dispatch_async(queue, ^{
        DDLogInfo(@"asyncConcurrent 任务1---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        DDLogInfo(@"asyncConcurrent 任务2---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        DDLogInfo(@"asyncConcurrent 任务3---%@", [NSThread currentThread]);
    });
    
    DDLogInfo(@"---asyncConcurrent end---");
    
//    [I] [22:27:07:831] : ---asyncConcurrent start---
//    [I] [22:27:07:832] : ---asyncConcurrent end---
//    [I] [22:26:09:164] : asyncConcurrent 任务3---<NSThread: 0x60c000270880>{number = 5, name = (null)}
//    [I] [22:26:09:164] : asyncConcurrent 任务2---<NSThread: 0x60400027dbc0>{number = 4, name = (null)}
//    [I] [22:26:09:164] : asyncConcurrent 任务1---<NSThread: 0x60c00026fdc0>{number = 3, name = (null)}
    
//    异步执行意味着可以开启新的线程,任务可以先绕过不执行，回头再来执行
//    并行队列意味着任务之间不需要排队，且具有同时被执行的“权利”
//    两者组合后的结果开了三个新线程,函数在执行时，先打印了start和end，再回头执行这三个任务
//    这三个任务是同时执行的，没有先后，所以打印结果是“任务3-->任务2-->任务1”,这个顺序是随机的，每次都可能变化
}

//异步执行 + 串行队列
- (void)asyncSerial{
    //创建一个串行队列
    dispatch_queue_t queue = dispatch_queue_create("asyncSerial", DISPATCH_QUEUE_SERIAL);
    
    DDLogInfo(@"---asyncSerial start---%@", [NSThread currentThread]);
    //使用异步函数封装三个任务
    dispatch_async(queue, ^{
        DDLogInfo(@"asyncSerial 任务1---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        DDLogInfo(@"asyncSerial 任务2---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        DDLogInfo(@"asyncSerial 任务3---%@", [NSThread currentThread]);
    });
    DDLogInfo(@"---asyncSerial end---%@", [NSThread currentThread]);
    
//    [I] [22:26:09:164] : ---asyncSerial start---
//    [I] [22:26:09:165] : ---asyncSerial end---
//    [I] [22:26:09:165] : asyncSerial 任务1---<NSThread: 0x60400027dbc0>{number = 4, name = (null)}
//    [I] [22:26:09:165] : asyncSerial 任务2---<NSThread: 0x60400027dbc0>{number = 4, name = (null)}
//    [I] [22:26:09:165] : asyncSerial 任务3---<NSThread: 0x60400027dbc0>{number = 4, name = (null)}
    
//    异步执行意味着可以开启新的线程，任务可以先绕过不执行，回头再来执行
//    串行队列意味着任务必须按添加进队列的顺序挨个执行
//    两者组合后的结果开了一个新的子线程函数在执行时，先打印了start和end，再回头执行这三个任务
//    这三个任务是按顺序执行的，所以打印结果是“任务1-->任务2-->任务3”

}

//同步执行 + 并行队列
- (void)syncConcurrent{
    //创建一个并行队列
    dispatch_queue_t queue = dispatch_queue_create("syncConcurrent", DISPATCH_QUEUE_CONCURRENT);
    
    DDLogInfo(@"---syncConcurrent start---%@", [NSThread currentThread]);
    //使用同步函数封装三个任务
    dispatch_sync(queue, ^{
        DDLogInfo(@"syncConcurrent 任务1---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        DDLogInfo(@"syncConcurrent 任务2---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        DDLogInfo(@"syncConcurrent 任务3---%@", [NSThread currentThread]);
    });
    DDLogInfo(@"---syncConcurrent end---%@", [NSThread currentThread]);
    
//    [I] [22:32:33:987] : ---syncConcurrent start---
//    [I] [22:32:33:988] : syncConcurrent 任务1---<NSThread: 0x604000070880>{number = 1, name = main}
//    [I] [22:32:33:988] : syncConcurrent 任务2---<NSThread: 0x604000070880>{number = 1, name = main}
//    [I] [22:32:33:988] : syncConcurrent 任务3---<NSThread: 0x604000070880>{number = 1, name = main}
//    [I] [22:32:33:988] : ---syncConcurrent end---
    
//    同步执行执行意味着不能开启新的线程,任务创建后必须执行完才能往下走
//    并行队列意味着,任务必须按添加进队列的顺序挨个执行
//    两者组合后的结果所有任务都只能在主线程中执行,函数在执行时，必须按照代码的书写顺序一行一行地执行完才能继续
//    在这里即便是并行队列，任务可以同时执行，但是由于只存在一个主线程，所以没法把任务分发到不同的线程去同步处理，其结果就是只能在主线程里按顺序挨个挨个执行了
}

//同步执行+ 串行队列
- (void)syncSerial{
    //创建一个串行队列
    
    dispatch_queue_t queue = dispatch_queue_create("syncSerial", DISPATCH_QUEUE_SERIAL);
    
    DDLogInfo(@"---syncSerial start---%@",[NSThread currentThread]);
    
    //使用异步函数封装三个任务
    dispatch_sync(queue, ^{
        DDLogInfo(@"syncSerial 任务1---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        DDLogInfo(@"syncSerial 任务2---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        DDLogInfo(@"syncSerial 任务2---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        DDLogInfo(@"syncSerial 任务2---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        DDLogInfo(@"syncSerial 任务2---%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        DDLogInfo(@"syncSerial 任务3---%@", [NSThread currentThread]);
    });
    DDLogInfo(@"---syncSerial end---%@",[NSThread currentThread]);
}

- (void)asyncMain
{
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    DDLogInfo(@"---asycnMain start---%@",[NSThread currentThread]);
    
    //使用异步函数封装三个任务
    dispatch_async(queue, ^{
        DDLogInfo(@"asyncMain 任务1---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        DDLogInfo(@"asyncMain 任务2---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        DDLogInfo(@"asyncMain 任务3---%@", [NSThread currentThread]);
    });
    DDLogInfo(@"---asyncMain end---%@",[NSThread currentThread]);

}

#pragma mark - Layout Methods

#pragma mark - GET/SET Methods
@end
