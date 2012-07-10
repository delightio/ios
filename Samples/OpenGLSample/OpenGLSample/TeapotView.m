//
//  TeapotView.m
//  OpenGLSample
//
//  Copyright (c) 2012 Pipely Inc. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/EAGLDrawable.h>
#import "TeapotView.h"
#import "teapot.h"

// CONSTANTS
#define kTeapotScale				3.0

// MACROS
#define DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) / 180.0 * M_PI)

@interface TeapotView ()

- (BOOL)createFramebuffer;
- (void)destroyFramebuffer;
- (void)setupView;

@end

@implementation TeapotView

@synthesize animating;
@dynamic animationFrameInterval;

// Implement this to override the default layer class (which is [CALayer class]).
// We do this so that our view will be backed by a layer that is capable of OpenGL ES rendering.
+ (Class)layerClass
{
	return [CAEAGLLayer class];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		CAEAGLLayer *eaglLayer = (CAEAGLLayer *)self.layer;
	
		eaglLayer.opaque = YES;
		eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
									[NSNumber numberWithBool:NO], kEAGLDrawablePropertyRetainedBacking, kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat, nil];
	
		context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
	
		if (!context || ![EAGLContext setCurrentContext:context]) {
			[self release];
			return nil;
		}
	
		animating = FALSE;
		animationFrameInterval = 1;
		displayLink = nil;
        
		[self setupView];
	}
	
	return self;
}

- (void)dealloc
{	
	if ([EAGLContext currentContext] == context) {
		[EAGLContext setCurrentContext:nil];
	}
	
	[context release];
	[super dealloc];
}
	
- (void)setupView
{
	const GLfloat			lightAmbient[] = {0.2, 0.2, 0.2, 1.0};
	const GLfloat			lightDiffuse[] = {1.0, 0.6, 0.0, 1.0};
	const GLfloat			matAmbient[] = {0.6, 0.6, 0.6, 1.0};
	const GLfloat			matDiffuse[] = {1.0, 1.0, 1.0, 1.0};	
	const GLfloat			matSpecular[] = {1.0, 1.0, 1.0, 1.0};
	const GLfloat			lightPosition[] = {0.0, 0.0, 1.0, 0.0}; 
	const GLfloat			lightShininess = 100.0,
							zNear = 0.1,
							zFar = 1000.0,
							fieldOfView = 60.0;
	GLfloat					size;
	
	// Configure OpenGL lighting
	glEnable(GL_LIGHTING);
	glEnable(GL_LIGHT0);
	glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT, matAmbient);
	glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE, matDiffuse);
	glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR, matSpecular);
	glMaterialf(GL_FRONT_AND_BACK, GL_SHININESS, lightShininess);
	glLightfv(GL_LIGHT0, GL_AMBIENT, lightAmbient);
	glLightfv(GL_LIGHT0, GL_DIFFUSE, lightDiffuse);
	glLightfv(GL_LIGHT0, GL_POSITION, lightPosition); 			
	glShadeModel(GL_SMOOTH);
	glEnable(GL_DEPTH_TEST);
		
	// Configure OpenGL arrays
	glEnableClientState(GL_VERTEX_ARRAY);
	glEnableClientState(GL_NORMAL_ARRAY);
	glVertexPointer(3 ,GL_FLOAT, 0, teapot_vertices);
	glNormalPointer(GL_FLOAT, 0, teapot_normals);
	glEnable(GL_NORMALIZE);

	// Set the OpenGL projection matrix
	glMatrixMode(GL_PROJECTION);
	size = zNear * tanf(DEGREES_TO_RADIANS(fieldOfView) / 2.0);
	CGRect rect = self.bounds;
	glFrustumf(-size, size, -size / (rect.size.width / rect.size.height), size / (rect.size.width / rect.size.height), zNear, zFar);
	glViewport(0, 0, rect.size.width, rect.size.height);
    
    glTranslatef(0.0, -0.1, -1.0);
    glScalef(kTeapotScale, kTeapotScale, kTeapotScale);

	// Make the OpenGL modelview matrix the default
	glMatrixMode(GL_MODELVIEW);
}

// Updates the OpenGL view
- (void)drawView
{
	[EAGLContext setCurrentContext:context];
		
	glBindFramebufferOES(GL_FRAMEBUFFER_OES, viewFramebuffer);
	glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	
    GLfloat matrix[16];
    glGetFloatv(GL_MODELVIEW_MATRIX, matrix);
    
    glLoadIdentity();
    glRotatef(angle, dy, dx, 0);    
    glMultMatrixf(matrix);
        
	// Draw teapot. The new_teapot_indicies array is an RLE (run-length encoded) version of the teapot_indices array in teapot.h
	for (int i = 0; i < num_teapot_indices; i += new_teapot_indicies[i] + 1) {
		glDrawElements(GL_TRIANGLE_STRIP, new_teapot_indicies[i], GL_UNSIGNED_SHORT, &new_teapot_indicies[i+1]);
	}
 
	glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);
    
	[context presentRenderbuffer:GL_RENDERBUFFER_OES];
}

// If our view is resized, we'll be asked to layout subviews.
// This is the perfect opportunity to also update the framebuffer so that it is
// the same size as our display area.
- (void)layoutSubviews
{
	[EAGLContext setCurrentContext:context];
	[self destroyFramebuffer];
	[self createFramebuffer];
	[self drawView];
}

- (BOOL)createFramebuffer
{
	// Generate IDs for a framebuffer object and a color renderbuffer
	glGenFramebuffersOES(1, &viewFramebuffer);
	glGenRenderbuffersOES(1, &viewRenderbuffer);
	
	glBindFramebufferOES(GL_FRAMEBUFFER_OES, viewFramebuffer);
	glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);
	// This call associates the storage for the current render buffer with the EAGLDrawable (our CAEAGLLayer)
	// allowing us to draw into a buffer that will later be rendered to screen wherever the layer is (which corresponds with our view).
	[context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:(id<EAGLDrawable>)self.layer];
	glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, viewRenderbuffer);
	
	glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &backingWidth);
	glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &backingHeight);
	
	// For this sample, we also need a depth buffer, so we'll create and attach one via another renderbuffer.
	glGenRenderbuffersOES(1, &depthRenderbuffer);
	glBindRenderbufferOES(GL_RENDERBUFFER_OES, depthRenderbuffer);
	glRenderbufferStorageOES(GL_RENDERBUFFER_OES, GL_DEPTH_COMPONENT16_OES, backingWidth, backingHeight);
	glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_DEPTH_ATTACHMENT_OES, GL_RENDERBUFFER_OES, depthRenderbuffer);

	if (glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES) != GL_FRAMEBUFFER_COMPLETE_OES) {
		NSLog(@"failed to make complete framebuffer object %x", glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES));
		return NO;
	}
	
	return YES;
}

// Clean up any buffers we have allocated.
- (void)destroyFramebuffer
{
	glDeleteFramebuffersOES(1, &viewFramebuffer);
	viewFramebuffer = 0;
	glDeleteRenderbuffersOES(1, &viewRenderbuffer);
	viewRenderbuffer = 0;
	
	if (depthRenderbuffer) {
		glDeleteRenderbuffersOES(1, &depthRenderbuffer);
		depthRenderbuffer = 0;
	}
}

- (NSInteger)animationFrameInterval
{
	return animationFrameInterval;
}

- (void)setAnimationFrameInterval:(NSInteger)frameInterval
{
	// Frame interval defines how many display frames must pass between each time the
	// display link fires. The display link will only fire 30 times a second when the
	// frame internal is two on a display that refreshes 60 times a second. The default
	// frame interval setting of one will fire 60 times a second when the display refreshes
	// at 60 times a second. A frame interval setting of less than one results in undefined
	// behavior.
	if (frameInterval >= 1) {
		animationFrameInterval = frameInterval;
		
		if (animating) {
			[self stopAnimation];
			[self startAnimation];
		}
	}
}

- (void)startAnimation
{
	if (!animating) {
        displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(drawView)];
        [displayLink setFrameInterval:animationFrameInterval];
        [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
		
		animating = TRUE;
	}
}

- (void)stopAnimation
{
	if (animating) {
        [displayLink invalidate];
        displayLink = nil;
        
		animating = FALSE;
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event 
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    CGPoint oldLocation = [touch previousLocationInView:self];
    
    dx = (location.x - oldLocation.x) / 2.0;
    dy = (location.y - oldLocation.y) / 2.0;
    angle = 180.0 * sqrt(dx * dx + dy * dy) / self.bounds.size.width;
}

@end
