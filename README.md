Delight IO
=========================

Basic Setup
-----------

1. Sign up on [http://delight.io](http://delight.io) to receive your app token.

2. Add Delight.framework to your target. Also make sure the following frameworks are linked:
    * AVFoundation
    * CoreGraphics
    * CoreMedia
    * CoreVideo
    * QuartzCore
    * SystemConfiguration

3. In your build settings, add `-ObjC` to "Other Linker Flags".

4. In your application delegate, `#import <Delight/Delight.h>`. In `applicationDidFinishLaunching:withOptions:`, call `[Delight startWithAppToken:]` along with the app token obtained from step 1.

Advanced Setup
--------------

### Stopping the Recording ###

By default, recording will stop when the user presses the device's home button or after 10 minutes, whichever comes first. To stop recording earlier, call `[Delight stop]`. 

After a recording has been stopped, it is not possible to restart it again in that session.

### Saving to Photo Album ###

If you would like the video to be copied to the user's Photo Album after each recording, call `[Delight setSavesToPhotoAlbum:YES]`. By default the video is not copied.

### Properties ###

You can attach arbitrary metadata to recordings by calling `[Delight setPropertyValue:forKey:]`. The value must be either an NSString or NSNumber. In the control panel, it is possible to filter recordings by property.

### Debug Log ###

By default, debug log statements from Delight are suppressed. To turn them on, call `[Delight setDebugLogEnabled:YES]`.

OpenGL ES
---------

To record applications that use OpenGL ES, you must link DelightPrivate.framework instead of Delight.framework. This is a special version of Delight that uses private APIs, and is able to record OpenGL layers at high frame rates. Follow the same steps as in the Basic Setup, but change the import statement to `#import <DelightPrivate/Delight.h>`.

**Note:** Since DelightPrivate.framework uses private APIs, it should not be used in App Store builds.

Private Views
-------------

### Registering / Unregistering ###

You may not want to record certain views, such as password prompts. Call `[Delight registerPrivateView:description:]` with a view and a descriptive text to make a view private (will appear blacked out in the recording). You must call `[Delight unregisterPrivateView:]` before the view is deallocated. `[Delight privateViews]` will return an NSSet of all private views currently registered.

Note that UITextFields with the secureTextEntry property set to true are automatically registered as private views.

### Hiding the Keyboard ###

To allow/prevent the keyboard from being recorded, call `[Delight setHidesKeyboardInRecording:]`. When set to YES, the keyboard area will be covered up by a grey box in the recording and keystroke gestures will not be drawn. By default, the keyboard is shown in the recording, except for when the user is entering text into a secure UITextField.

Viewing Recordings
------------------

Log in to your control panel at [delight.io](http://delight.io) to view your recordings. You can filter your recordings by version and build, as defined in your application's Info.plist file. If you have turned on [saving to Photo Album](#saving-to-photo-album) you may also view recordings by launching the Photos app on the device.

Troubleshooting
---------------

* **Q**: Why do I get "Error creating pixel buffer:  status=-6661, pixelBufferPool=0x0"?

  **A**: The hardware-accelerated audio decoder may be blocking the video encoder. Try setting the audio session category to AVAudioSessionCategoryAmbient to use software audio decoding instead: `[[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:NULL];`

* **Q**: Why is my video rotated 90º?

  **A**: The screen capturing operates at a window level rather than a view controller level. Windows in iOS are always in portrait mode; the view controllers take care of rotation. If your app is in landscape mode the video will therefore appear rotated. You can use the rotation control in the video player to rotate during playback.

* **Q**: How can I reach you for help and feedback?

  **A**: We would love to hear from you. Please tweet us [@delightio](http://twitter.com/delightio) or email us [feedback@delight.io](mailto:feedback@delight.io)
