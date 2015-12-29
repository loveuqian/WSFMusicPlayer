//
//  WSFMusicPlayerViewController.h
//  WSFMusicPlayer
//
//  Created by WangShengFeng on 15/12/24.
//  Copyright © 2015年 WangShengFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"

@class WSFTrack;

@interface WSFMusicPlayerViewController : UIViewController

@property (nonatomic, assign) NSInteger currentTrackIndex;
@property (nonatomic, strong) WSFTrack *track;
@property (nonatomic, strong) NSArray *tracksArr;

SingletonInterface(WSFMusicPlayerViewController);

@end
