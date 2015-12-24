//
//  WSFMusicPlayerViewController.m
//  WSFMusicPlayer
//
//  Created by WangShengFeng on 15/12/24.
//  Copyright © 2015年 WangShengFeng. All rights reserved.
//

#import "WSFMusicPlayerViewController.h"

@interface WSFMusicPlayerViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;
@property (weak, nonatomic) IBOutlet UIImageView *albumImageView;

@property (weak, nonatomic) IBOutlet UITableView *musicListTableView;
@property (nonatomic, strong) NSArray *musicUrlArr;

@end

@implementation WSFMusicPlayerViewController

- (NSArray *)musicUrlArr
{
    if (!_musicUrlArr) {
        _musicUrlArr = @[ xiaoxingyun, ifyou, zouzailengfengzhong, buweishuierzuodege ];
    }
    return _musicUrlArr;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.musicListTableView.delegate = self;
    self.musicListTableView.dataSource = self;
}

- (IBAction)playBtnClick:(UIButton *)sender
{
    //
}

- (IBAction)nextBtnClick
{
    //
}

- (IBAction)previousBtnClick
{
    //
}

#pragma mark tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];

    if (0 == indexPath.row) {
        cell.textLabel.text = @"小幸运";
        cell.detailTextLabel.text = @"田馥甄";
    }

    if (1 == indexPath.row) {
        cell.textLabel.text = @"if you";
        cell.detailTextLabel.text = @"big bang";
    }

    if (2 == indexPath.row) {
        cell.textLabel.text = @"走在冷风中";
        cell.detailTextLabel.text = @"周二珂";
    }

    if (3 == indexPath.row) {
        cell.textLabel.text = @"不为谁而作的歌";
        cell.detailTextLabel.text = @"林俊杰";
    }

    return cell;
}

@end
