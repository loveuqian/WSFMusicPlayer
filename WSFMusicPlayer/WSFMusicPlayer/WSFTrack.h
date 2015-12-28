//
//  WSFTrack.h
//  WSFMusicPlayer
//
//  Created by WangShengFeng on 15/12/25.
//  Copyright © 2015年 WangShengFeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DOUAudioFile.h"

@interface WSFTrack : NSObject <DOUAudioFile>

@property (nonatomic, copy) NSString *artist;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSURL *audioFileURL;

+ (instancetype)trackWithAVObject:(AVObject *)object;
+ (NSArray *)tracksArrWithAVObjectsArr:(NSArray *)arr;

@end
