Delight
=========================

Basic Setup
-----------

1. Add Delight.framework to your target. Also make sure the following frameworks are linked:
    * AVFoundation
    * CoreGraphics
    * CoreMedia
    * CoreVideo
    * OpenGLES
    * QuartzCore
    * SystemConfiguration

2. In your build settings, add `-ObjC` to "Other Linker Flags".

3. In your application delegate, `#import <Delight/Delight.h>`. In `applicationDidFinishLaunching:withOptions:`, call `[Delight startWithAppToken:]`.

Advanced Setup
--------------

### Scale Factor ###

By default, recordings will be at 50% scale for iPhones and non-Retina iPads, and 25% scale for Retina iPads. These numbers were chosen to strike a balance between recording quality, performance and upload time. To record at a different scale, call `[Delight setScaleFactor:]` before `[Delight startWithAppToken:]`. The scale factor is a number between 0 and 1, for example 0.5 for 50% scale.

### Frame Rate ###

The frame rate will auto-adjust to become as high as possible. This may use up a lot of CPU, so you may want to reduce the frame rate to limit the effect on your app. To do so, call `[Delight setMaximumFrameRate:]` with the new maximum frame rate (in frames per second). You may need to experiment to find the right value. By default the maximum frame rate is 30 fps.

### Recording Control ###

Call `[Delight pause]` / `[Delight resume]` to temporarily pause recording. To stop recording altogether, call `[Delight stop]`.

### Saving to Photo Album ###

If you would like the video to be copied to the user's Photo Album after each recording, call `[Delight setSavesToPhotoAlbum:YES]`. By default the video is not copied. 

Private Views
-------------

### Registering / Unregistering ###

You may not want to record certain views, such as password prompts. Call `[Delight registerPrivateView:description:]` with a view and a descriptive text to make a view private (will appear blacked out in the recording). You must call `[Delight unregisterPrivateView:]` before the view is deallocated. `[Delight privateViews]` will return an NSSet of all private views currently registered. 

### Hiding the Keyboard ###

To allow/prevent the keyboard from being recorded, call `[Delight setHidesKeyboardInRecording:]`. When set to YES, the keyboard area will be covered up by a grey box in the recording and keystroke gestures will not be drawn. By default, the keyboard is shown in the recording.

OpenGL ES Support
-----------------

Currently delight.io only supports UIKit apps. OpenGL ES support is in the works, however, and interested parties should email us at [opengl@delight.io](mailto:opengl@delight.io) to sign up for the beta.

Viewing Recordings
------------------

Log in to your control panel at [delight.io](http://delight.io) to view your recordings. If you have turned on [saving to Photo Album](#saving-to-photo-album) you may also view recordings by launching the Photos app on the device.

Troubleshooting
---------------

* Q: Why do I get "Error creating pixel buffer:  status=-6661, pixelBufferPool=0x0"?
* A: The hardware-accelerated audio decoder may be blocking the video encoder. Try setting the audio session category to AVAudioSessionCategoryAmbient to use software audio decoding instead: `[[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:NULL];`

* Q: Why is my video rotated 90º?
* A: The screen capturing operates at a window level rather than a view controller level. Windows in iOS are always in portrait mode; the view controllers take care of rotation. If your app is in landscape mode the video will therefore appear rotated.

