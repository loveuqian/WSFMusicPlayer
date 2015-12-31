//
//  WSFMusicPlayerViewController.m
//  WSFMusicPlayer
//
//  Created by WangShengFeng on 15/12/24.
//  Copyright © 2015年 WangShengFeng. All rights reserved.
//

#import "WSFMusicPlayerViewController.h"
#import "WSFTrack.h"
#import "DOUAudioStreamer.h"
#import "DOUAudioVisualizer.h"

@interface WSFMusicPlayerViewController ()

@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;
@property (weak, nonatomic) IBOutlet UIImageView *albumImageView;
@property (weak, nonatomic) IBOutlet DOUAudioVisualizer *audioVisualizerView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;

@property (nonatomic, strong) DOUAudioStreamer *streamer;

@property (nonatomic, strong) NSTimer *progressTimer;

@end

@implementation WSFMusicPlayerViewController
static void *kStatusKVOKey = &kStatusKVOKey;

SingletonImplementation(WSFMusicPlayerViewController);

- (void)setCurrentTrackIndex:(NSInteger)currentTrackIndex
{
    if (self.tracksArr[_currentTrackIndex] == self.tracksArr[currentTrackIndex] && self.streamer) {
        return;
    }

    _currentTrackIndex = currentTrackIndex;

    if ([self isViewLoaded]) {
        [self resetStreamer];
        [self.playButton setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self resetStreamer];
    [self.playButton setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    [self setupBlur];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    CGFloat x = 100;
    CGFloat y = 100;
    CGFloat w = [UIScreen mainScreen].bounds.size.width - 2 * x;
    CGFloat h = w;
    self.iconImageView.frame = CGRectMake(x, y, w, h);
}

#pragma mark 定时器
- (void)startProgressTimer
{
    [self updateProgress];
    self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                          target:self
                                                        selector:@selector(updateProgress)
                                                        userInfo:nil
                                                         repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.progressTimer forMode:NSRunLoopCommonModes];
}

- (void)stopProgressTimer
{
    [self.progressTimer invalidate];
    self.progressTimer = nil;
}

- (void)updateProgress
{
    // 改变滑块的位置
    self.progressSlider.value = self.streamer.currentTime / self.streamer.duration;

    // 设置时间的Label的文字
    self.currentTimeLabel.text = [NSString stringWithFormat:@"%@", [self stringWithTime:self.streamer.currentTime]];
    self.totalTimeLabel.text = [NSString stringWithFormat:@"%@", [self stringWithTime:self.streamer.duration]];
}

#pragma mark 播放器
- (void)cancelStreamer
{
    if (self.streamer != nil) {
        [self.streamer pause];
        [self.streamer removeObserver:self forKeyPath:@"status"];
        self.streamer = nil;
    }
}

- (void)resetStreamer
{
    [self cancelStreamer];

    WSFTrack *track = [self.tracksArr objectAtIndex:self.currentTrackIndex];
    self.streamer = [DOUAudioStreamer streamerWithAudioFile:track];
    [self.streamer addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:kStatusKVOKey];

    [self.streamer play];
//    [self startProgressTimer];

    [self setupImage:track];
    [self setupHintForStreamer];
}

- (void)setupHintForStreamer
{
    NSInteger nextIndex = _currentTrackIndex + 1;
    if (nextIndex >= [self.tracksArr count]) {
        nextIndex = 0;
    }

    [DOUAudioStreamer setHintWithAudioFile:[self.tracksArr objectAtIndex:nextIndex]];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if (context == kStatusKVOKey) {
        [self performSelector:@selector(_updateStatus) onThread:[NSThread mainThread] withObject:nil waitUntilDone:NO];
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)_updateStatus
{
    switch ([_streamer status]) {
    case DOUAudioStreamerPlaying:
        NSLog(@"playing");
//        [self startProgressTimer];
        break;
    case DOUAudioStreamerPaused:
        NSLog(@"paused");
        break;
    case DOUAudioStreamerIdle:
        NSLog(@"idle");
        break;
    case DOUAudioStreamerFinished:
        NSLog(@"finished");
        break;
    case DOUAudioStreamerBuffering:
        NSLog(@"buffering");
        break;
    case DOUAudioStreamerError:
        NSLog(@"error");
        break;
    }
}

#pragma mark 图片
- (void)setupBlur
{
    UIToolbar *toolBar = [[UIToolbar alloc] init];
    toolBar.barStyle = UIBarStyleBlack;
    toolBar.frame = [UIScreen mainScreen].bounds;

    [self.backgroundImageView addSubview:toolBar];
}

- (void)setupImage:(WSFTrack *)track
{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:track.imageUrlStr]
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                self.backgroundImageView.image = [UIImage imageWithData:data];
                                                self.iconImageView.image = [UIImage imageWithData:data];
                                            });
                                        }];
    [task resume];
}

#pragma mark 按钮点击
- (IBAction)closeBtnClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)playBtnClick:(UIButton *)sender
{
    if (self.streamer) {
        if ([self.streamer status] == DOUAudioStreamerPaused || [self.streamer status] == DOUAudioStreamerIdle) {
            [self.streamer play];
            [self.playButton setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        }
        else {
            [self.streamer pause];
            [self.playButton setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        }
    }

    if (!self.streamer) {
        [self resetStreamer];
        [self.playButton setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    }
}

- (IBAction)nextBtnClick
{
    [self stopProgressTimer];
    if (++self.currentTrackIndex >= [self.tracksArr count]) {
        self.currentTrackIndex = 0;
    }

    [self resetStreamer];
}

- (IBAction)previousBtnClick
{
    [self stopProgressTimer];
    if (--self.currentTrackIndex <= 0) {
        self.currentTrackIndex = [self.tracksArr count] - 1;
    }

    [self resetStreamer];
}

#pragma mark 其他
// 时间转 str
- (NSString *)stringWithTime:(NSTimeInterval)time
{
    NSInteger min = time / 60;
    NSInteger second = (NSInteger)time % 60;

    return [NSString stringWithFormat:@"%02ld:%02ld", min, second];
}

@end
