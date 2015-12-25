//
//  WSFTrack+Extension.m
//  WSFMusicPlayer
//
//  Created by WangShengFeng on 15/12/25.
//  Copyright © 2015年 WangShengFeng. All rights reserved.
//

#import "WSFTrack+Extension.h"

@implementation WSFTrack (Extension)

+ (NSArray *)tracksArr
{
    WSFTrack *track1 = [WSFTrack trackWithArtist:@"田馥甄"
                                           title:@"小幸运"
                                    audioFileURL:@"http://sc1.111ttt.com/2015/3/11/28/104281920346.mp3"];
    WSFTrack *track2 = [WSFTrack trackWithArtist:@"big bang"
                                           title:@"if you"
                                    audioFileURL:@"http://sc1.111ttt.com/2015/1/12/24/105241801375.mp3"];
    WSFTrack *track3 = [WSFTrack trackWithArtist:@"周二珂"
                                           title:@"走在冷风中"
                                    audioFileURL:@"http://sc1.111ttt.com/2015/1/06/09/99092220246.mp3"];
    WSFTrack *track4 = [WSFTrack trackWithArtist:@"林俊杰"
                                           title:@"不为谁而作的歌"
                                    audioFileURL:@"http://sc1.111ttt.com/2015/1/12/24/105241804268.mp3"];

    return @[ track1, track2, track3, track4 ];
}

@end
