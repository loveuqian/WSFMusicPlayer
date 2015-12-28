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

@interface WSFMusicPlayerViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;
@property (weak, nonatomic) IBOutlet UIImageView *albumImageView;
@property (weak, nonatomic) IBOutlet UITableView *musicListTableView;
@property (weak, nonatomic) IBOutlet DOUAudioVisualizer *audioVisualizerView;

@property (nonatomic, strong) DOUAudioStreamer *streamer;
@property (nonatomic, assign) NSInteger currentTrackIndex;

@property (nonatomic, strong) NSArray *tracksArr;

@end

@implementation WSFMusicPlayerViewController

- (NSArray *)tracksArr
{
    if (!_tracksArr) {
        AVQuery *query = [AVQuery queryWithClassName:@"WSFTrack"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            _tracksArr = [WSFTrack tracksArrWithAVObjectsArr:objects];
            [self.musicListTableView reloadData];
        }];
    }
    return _tracksArr;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.musicListTableView.delegate = self;
    self.musicListTableView.dataSource = self;
    self.musicListTableView.tableFooterView = [[UIView alloc] init];
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

#pragma mark 音乐列表
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tracksArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];

    WSFTrack *track = self.tracksArr[indexPath.row];
    cell.textLabel.text = track.title;
    cell.detailTextLabel.text = track.artist;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    self.currentTrackIndex = indexPath.row;
    [self resetStreamer];
}

@end
