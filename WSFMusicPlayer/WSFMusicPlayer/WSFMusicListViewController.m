//
//  WSFMusicListViewController.m
//  WSFMusicPlayer
//
//  Created by WangShengFeng on 15/12/29.
//  Copyright © 2015年 WangShengFeng. All rights reserved.
//

#import "WSFMusicListViewController.h"
#import "WSFMusicPlayerViewController.h"
#import "WSFTrack.h"

@interface WSFMusicListViewController ()

@property (nonatomic, strong) NSArray *tracksArr;

@end

@implementation WSFMusicListViewController

- (NSArray *)tracksArr
{
    if (!_tracksArr) {
        AVQuery *query = [AVQuery queryWithClassName:@"WSFTrack"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            _tracksArr = [WSFTrack tracksArrWithAVObjectsArr:objects];
            [self.tableView reloadData];
        }];
    }
    return _tracksArr;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    cell.imageView.image = track.image;
    [cell layoutSubviews];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    WSFMusicPlayerViewController *playerVC = [WSFMusicPlayerViewController shareWSFMusicPlayerViewController];
    playerVC.currentTrackIndex = indexPath.row;
    playerVC.tracksArr = self.tracksArr;
    [self presentViewController:playerVC animated:YES completion:nil];
}

@end
