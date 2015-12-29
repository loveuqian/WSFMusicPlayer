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
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *imageUrlStr;

+ (NSArray *)tracksArrWithAVObjectsArr:(NSArray *)arr;

@end
