//
//  BCFileLogger.m
//  Pod
//
//  Created by Basic on 2017/3/13.
//  Copyright © 2017年 naruto. All rights reserved.
//  基础组件 - 日志文件组件
//  日志文件实现

#import "BCFileLogger.h"

#define     kBCLogLevel                         3//该等级以下的日志不输出
#define     kBCFileLogger_Dir                   @"bclog"        //log目录
#define     kBCFileLogger_DirMaxSize            60*1024*1024    //日志文件夹最大size
#define     kBCFileLogger_FileMaxNum            5    //日志文件最大保存数量
#define     kBCFileLogger_LogLoopInterval       20//写日志的间隔时间

@interface BCFileLogger()

/**
 日志文件夹的路径
 */
@property (nonatomic, strong) NSString                      * bcLogDirPath;
///**
// 当天日志文件夹的路径
// */
//@property (nonatomic, strong) NSString                      * bcDayLogDirPath;
/**
 日志文件的路径
 */
@property (nonatomic, strong) NSString                      * bcLogFilePath;

/**
 写文件的队列
 */
@property (nonatomic, strong) dispatch_queue_t              bcLogSerialOperation;

/**
 日志 格式化formater
 */
@property (nonatomic, strong) NSDateFormatter               *logFormater;
@property (strong, nonatomic) NSMutableArray                *logQueue;
@property (strong, nonatomic) NSTimer                       *logTimer;
@end

@implementation BCFileLogger
//MARK: - life cycle
+ (instancetype) shareInstance {
    static dispatch_once_t kBCFileLoggerOnceToken;
    static BCFileLogger *kFileLoggerInstance = nil;
    dispatch_once(&kBCFileLoggerOnceToken, ^{
        kFileLoggerInstance = [BCFileLogger new];
    });
    return kFileLoggerInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _bcLogSerialOperation = dispatch_queue_create("com.dispatch.serial.bcfilelogger", DISPATCH_QUEUE_SERIAL);
        _logFormater = [[NSDateFormatter alloc ] init];
        [_logFormater setDateFormat:@"YYYY-MM-dd hh:mm:ss:SSS"];
        _logQueue = [[NSMutableArray alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillTerminate:) name:UIApplicationWillTerminateNotification object:nil];

        [self createLogFile];
    }
    return self;
}
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - public
- (NSString *)bc_getLogFilePath:(NSString *)logDate {
    if(self.bcLogDirPath.length<=0){
        return nil;
    }
    NSString *strLogPath = nil;
    if(logDate.length<=0){
        //上传最近的
        strLogPath = self.bcLogFilePath;
    }
    else{
        //根据条件筛查 日志文件
        NSDirectoryEnumerator *dirEnumerater = [[NSFileManager defaultManager] enumeratorAtPath:self.bcLogDirPath];
        NSString *strLogPathTmp = nil;
        while ((strLogPathTmp = [dirEnumerater nextObject]) != nil) {
            NSString *strLogName = strLogPathTmp.stringByDeletingPathExtension;
            if([strLogName isEqualToString:logDate]){
                strLogPath = strLogPathTmp;
                break;
            }
        }
        if(strLogPath.length>0){
            strLogPath = [NSString stringWithFormat:@"%@/%@",self.bcLogDirPath,strLogPath];
        }
    }
    return strLogPath;
}


#pragma mark - private

/**
 创建日志文件目录
 */
-(void)createLogFile {
    NSDate *currentDate = [NSDate date];
    NSString *strDocument = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    //日志文件夹：日期作为文件名称
    NSDateFormatter *dfDate = [[NSDateFormatter alloc] init];
    [dfDate setDateFormat:@"yyyy-MM-dd"];
    NSString *strLogDir = [dfDate stringFromDate:currentDate];
    //日志文件：时间作为名称能
//    NSDateFormatter *dfFileDate = [[NSDateFormatter alloc] init];
//    [dfFileDate setDateFormat:@"HH"];
//    NSString *strLogFile = [dfFileDate stringFromDate:currentDate];
    self.bcLogDirPath = [NSString stringWithFormat:@"%@/%@",strDocument,kBCFileLogger_Dir];
//    self.bcDayLogDirPath = [NSString stringWithFormat:@"%@/%@.lh",self.bcLogDirPath,strLogDir];
    self.bcLogFilePath = [NSString stringWithFormat:@"%@/%@.log",self.bcLogDirPath,strLogDir];
    
    [self checkLogDir];
//    //判断日志目录大小是否超出限制
//    CGFloat currentLogSize = [self getLogDirSize];
//    if(currentLogSize >= kBCFileLogger_DirMaxSize){
//        //超出最大限制，先删除日志根目录
//#ifdef DEBUG
//        NSLog(@"BCFileLogger log is too large: %lfKB",currentLogSize);
//#endif
//        [[NSFileManager defaultManager] removeItemAtPath:self.bcLogDirPath error:nil];
//    }
//
    
    //判断 日志文件夹 是否存在
    BOOL isDirExist = [[NSFileManager defaultManager] fileExistsAtPath:self.bcLogDirPath];
    if(!isDirExist){
        bool createLogDir =[[NSFileManager defaultManager] createDirectoryAtPath:self.bcLogDirPath withIntermediateDirectories:YES attributes:nil error:nil];
            if(!createLogDir){
    #ifdef DEBUG
            NSLog(@"[log] create dir error:%@",self.bcLogDirPath);
            self.bcLogFilePath = nil;
    #endif
            return;
        }
    }
    //判断 日志文件 是否存在
    BOOL isFileExist = [[NSFileManager defaultManager] fileExistsAtPath:self.bcLogFilePath];
    if(!isFileExist){
        bool createLogFile = [[NSFileManager defaultManager] createFileAtPath:self.bcLogFilePath contents:nil attributes:nil] ;
        if(!createLogFile){
            #ifdef DEBUG
            NSLog(@"[log] create file error:%@",self.bcLogFilePath);
            self.bcLogFilePath = nil;
            #endif
            return;
        }
    }
#ifdef DEBUG
    NSLog(@"[log] init success");
#endif
}

#pragma mark - 读写日志
- (void)addLog:(NSString *)strLog withTime:(BOOL)addTime {
    //判断日志文件是否ok
    if(self.bcLogFilePath.length<=0){
        return;
    }
    if(!self.bcLogSerialOperation){
        return;
    }
    __weak typeof(self) weakSelf = self;
    dispatch_async(self.bcLogSerialOperation, ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSString *strNewLog = nil;
        if (addTime) {
            //添加时间
            strNewLog = [NSString stringWithFormat:@"[%@] %@\r\n",[strongSelf.logFormater stringFromDate:[NSDate date]],strLog];
        }
        else {
            strNewLog = [NSString stringWithFormat:@"%@\r\n",strLog];
        }
        [strongSelf.logQueue addObject:strNewLog];
        [strongSelf startLogTimer];
    });
}


/**
 计算日志文件夹大小

 @return 返回KB
 */
- (CGFloat)getLogDirSize
{
    NSFileManager *manager = [NSFileManager defaultManager];
    return  [[manager attributesOfItemAtPath:self.bcLogDirPath error:nil] fileSize]/(1024.0);//这里返回的单位是KB
}

/**
 检测日志文件夹，移除多余的日志文件，保留7天内日志
 */
- (void)checkLogDir
{
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:self.bcLogDirPath]) {
        return;
    }
    NSArray<NSString *> *fileList = [manager subpathsAtPath:self.bcLogDirPath];
    if (fileList.count<=kBCFileLogger_FileMaxNum) {
        return;
    }
    //移除多余的文件，从时间最早开始
    NSInteger surplusNum = fileList.count-kBCFileLogger_FileMaxNum;
    for (NSInteger i=0; i<surplusNum; i++) {
        NSString *logName = fileList[i];
        NSString *logPath = [self.bcLogDirPath stringByAppendingPathComponent:logName];
        [manager removeItemAtPath:logPath error:nil];
    }
}



#pragma mark - 轮训输出日志
- (void)startLogTimer
{
//    __weak typeof(self) weakSelf = self;
//    dispatch_async(self.bcLogSerialOperation, ^{
//        __strong typeof(weakSelf) strongSelf = weakSelf;
        //如果已经在运行了，跳过
        if(_logTimer){
            return ;
        }
        self.logTimer = [NSTimer timerWithTimeInterval:kBCFileLogger_LogLoopInterval target:self selector:@selector(onLogTimerHandle:) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.logTimer forMode:NSDefaultRunLoopMode];
        [self.logTimer fire];
//    });
    
}

- (void)onLogTimerHandle:(NSTimer *)timer
{
    //先判断日志列表是否空
    if(self.logQueue.count<=0){
        [self stopLogTimer];
        return;
    }
    //创建handle
    NSFileHandle *logFileHandle = [NSFileHandle fileHandleForUpdatingAtPath:self.bcLogFilePath];
    if(!logFileHandle){
#ifdef DEBUG
        NSLog(@"[log] handle file error:%@",self.bcLogFilePath);
#endif
        return;
    }
    NSArray *logQueueCopy =  [self.logQueue copy];
    [self.logQueue removeAllObjects];
    [logFileHandle seekToEndOfFile];
    for (NSString *logItem in logQueueCopy) {
        NSData *strData = [logItem dataUsingEncoding:NSUTF8StringEncoding];
        [logFileHandle writeData:strData];
    }
    [logFileHandle closeFile];
}

- (void)stopLogTimer
{
    if(_logTimer){
        [_logTimer invalidate];
        _logTimer = nil;
    }
}

#pragma mark - notifcation
- (void)applicationWillTerminate:(NSNotification*)notification {
    __weak typeof(self) weakSelf = self;
    dispatch_async(self.bcLogSerialOperation, ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf stopLogTimer];
        [strongSelf onLogTimerHandle:nil];
    });
    
}


void BCFileLoggerWrite(int level, NSString *label, NSString *format, ...) {
    NSString *strMsg = @"";
    if(format.length>0){
        va_list args;
        va_start(args, format);
        strMsg = [[NSString alloc] initWithFormat:format arguments:args];
        va_end(args);
    }
#ifdef DEBUG
    if(level >= kBCLogLevel){
        NSLog(@"%@", strMsg);
    }
#endif
    [[BCFileLogger shareInstance] addLog:strMsg withTime:true];
}
@end

