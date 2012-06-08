//
//  TeapotView.h
//  OpenGLSample
//
//  Copyright (c) 2012 Pipely Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@interface TeapotView : UIView {
	// The pixel dimensions of the backbuffer
	GLint backingWidth;
	GLint backingHeight;
    
	EAGLContext *context;
	
	// OpenGL names for the renderbuffer and framebuffers used to render to this view
	GLuint viewRenderbuffer, viewFramebuffer;
	
	// OpenGL name for the depth buffer that is attached to viewFramebuffer, if it exists (0 if it does not exist)
	GLuint depthRenderbuffer;

	NSInteger animationFrameInterval;
	CADisplayLink *displayLink;

    GLfloat dx, dy, angle;
}

@property (readonly, nonatomic, getter=isAnimating) BOOL animating;
@property (nonatomic) NSInteger animationFrameInterval;

- (void)startAnimation;
- (void)stopAnimation;
- (void)drawView;

@end
