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

@property (nonatomic, strong) DOUAudioStreamer *streamer;

@end

@implementation WSFMusicPlayerViewController

SingletonImplementation(WSFMusicPlayerViewController);

- (void)setCurrentTrackIndex:(NSInteger)currentTrackIndex
{
    if (self.tracksArr[_currentTrackIndex] == self.tracksArr[currentTrackIndex]) {
        return;
    }
    
    _currentTrackIndex = currentTrackIndex;
    [self resetStreamer];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //    [self playBtnClick:self.playButton];
}

#pragma mark streamer
- (void)cancelStreamer
{
    if (self.streamer != nil) {
        [self.streamer pause];
        //        [self.streamer removeObserver:self forKeyPath:@"status"];
        //        [self.streamer removeObserver:self forKeyPath:@"duration"];
        //        [self.streamer removeObserver:self forKeyPath:@"bufferingRatio"];
        self.streamer = nil;
    }
}

- (void)resetStreamer
{
    [self cancelStreamer];

    WSFTrack *track = [self.tracksArr objectAtIndex:self.currentTrackIndex];
    self.streamer = [DOUAudioStreamer streamerWithAudioFile:track];
    [self.streamer play];
    NSLog(@"第 %zd 首", self.currentTrackIndex);

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

#pragma mark 按钮点击
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
    if (++self.currentTrackIndex >= [self.tracksArr count]) {
        self.currentTrackIndex = 0;
    }

    [self resetStreamer];
}

- (IBAction)previousBtnClick
{
    if (--self.currentTrackIndex <= 0) {
        self.currentTrackIndex = [self.tracksArr count] - 1;
    }

    [self resetStreamer];
}


@end
