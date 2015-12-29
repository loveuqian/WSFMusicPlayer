//
//  WSFTrack.m
//  WSFMusicPlayer
//
//  Created by WangShengFeng on 15/12/25.
//  Copyright © 2015年 WangShengFeng. All rights reserved.
//

#import "WSFTrack.h"

@implementation WSFTrack

+ (NSArray *)tracksArrWithAVObjectsArr:(NSArray *)arr
{
    NSMutableArray *mArr = [NSMutableArray array];
    for (AVObject *object in arr) {
        WSFTrack *track = [WSFTrack trackWithAVObject:object];
        [mArr addObject:track];
    }
    return mArr;
}

+ (instancetype)trackWithAVObject:(AVObject *)object
{
    WSFTrack *track = [[WSFTrack alloc] init];

    track.artist = [object objectForKey:@"artist"];
    track.title = [object objectForKey:@"title"];
    track.audioFileURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", [object objectForKey:@"audioFileURL"]]];

    return track;
}

@end
