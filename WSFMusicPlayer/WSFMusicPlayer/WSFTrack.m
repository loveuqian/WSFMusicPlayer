//
//  WSFTrack.m
//  WSFMusicPlayer
//
//  Created by WangShengFeng on 15/12/25.
//  Copyright © 2015年 WangShengFeng. All rights reserved.
//

#import "WSFTrack.h"

@implementation WSFTrack

+ (instancetype)trackWithArtist:(NSString *)artist title:(NSString *)title audioFileURL:(NSString *)audioFileURL
{
    WSFTrack *track = [[WSFTrack alloc] init];

    track.artist = artist;
    track.title = title;
    track.audioFileURL = [NSURL URLWithString:audioFileURL];

    return track;
}

@end
