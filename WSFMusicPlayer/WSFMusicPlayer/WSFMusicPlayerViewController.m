//
//  WSFMusicPlayerViewController.m
//  WSFMusicPlayer
//
//  Created by WangShengFeng on 15/12/24.
//  Copyright © 2015年 WangShengFeng. All rights reserved.
//

#import "WSFMusicPlayerViewController.h"

@interface WSFMusicPlayerViewController ()

@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;
@property (weak, nonatomic) IBOutlet UIImageView *albumImageView;

@property (weak, nonatomic) IBOutlet UITableView *musicListTableView;

@end

@implementation WSFMusicPlayerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
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

@end
