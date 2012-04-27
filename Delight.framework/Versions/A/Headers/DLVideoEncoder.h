//
//  DLVideoEncoder.h
//  Delight
//
//  Created by Chris Haugli on 4/9/12.
//  Copyright (c) 2012 Pipely Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

/* 
   DLVideoEncoder encodes video to a file.
 */
@interface DLVideoEncoder : NSObject {
    AVAssetWriter *videoWriter;
    AVAssetWriterInput *videoWriterInput;
    AVAssetWriterInputPixelBufferAdaptor *avAdaptor;
    CVPixelBufferPoolRef pixelBufferPool;
    
    NSTimeInterval recordingStartTime;
    NSTimeInterval pauseStartTime;
    NSTimeInterval totalPauseDuration;
}

@property (nonatomic, readonly, getter=isRecording) BOOL recording;
@property (nonatomic, readonly, getter=isPaused) BOOL paused;
@property (nonatomic, assign) BOOL encodesRawGLBytes;
@property (nonatomic, assign) BOOL savesToPhotoAlbum;
@property (nonatomic, retain) NSString *outputPath;
@property (nonatomic, assign) CGSize videoSize;
@property (nonatomic, assign) double averageBitRate;

- (void)startNewRecording;
- (void)stopRecording;
- (void)writeFrameImage:(UIImage *)frameImage;
- (void)encodeRawBytesForGLView:(UIView *)glView backingWidth:(GLint)backingWidth backingHeight:(GLint)backingHeight;
- (void)pause;
- (void)resume;

@end
