//
//  Delight.h
//  Delight
//
//  Copyright (c) 2012 Pipely Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

/** The `Delight` class is used to set up screen and gesture recording. Refer to the [QuickStart Guide](http://delight.io/docs) for installation instructions.
 
 The most important method is `startWithAppToken:`, which in most cases should be called as soon as possible after app launch, typically in your application delegate's `applicationDidFinishLaunching:withOptions:` method. 
 */
@interface Delight : NSObject

/**---------------------------------------------------------------------------------------
 * @name Starting and Stopping Recording
 * ---------------------------------------------------------------------------------------
 */

/** Starts capturing the screen and recording gestures. The recording will automatically end after 10 minutes, or if the app is sent to the background, or if `stop` is called. A new recording will be started whenever the app is brought to the foreground. Recordings only take place if you have scheduled recordings in your [control panel](http://delight.io/apps), and recordings are not paused.
 
 @warning This method should only be called once, typically in your application delegate's `applicationDidFinishLaunching:withOptions:` method.
 @warning If your app uses OpenGL ES, do not use this method. Use `startOpenGLWithAppToken:` instead.
 @see stop
 @param appToken The application token from your [control panel](http://delight.io/apps).
 */
+ (void)startWithAppToken:(NSString *)appToken;

/** Stops the current recording, if there is one. Calling this method is optional. Recordings will automatically stop after 10 minutes, or if the app is sent to the background.
 @warning It is not possible to manually resume recording by calling `startWithAppToken:` again. A new recording will begin once the app has been sent to the background and then brought back to the foreground.
 */
+ (void)stop;

/**---------------------------------------------------------------------------------------
 * @name OpenGL ES Recording
 * ---------------------------------------------------------------------------------------
 */

/** Starts capturing the screen and recording gestures for OpenGL ES-based apps. You must also call either `takeOpenGLScreenshot:` or `takeOpenGLScreenshot:colorRenderbuffer:` inside your render loop, just before calling `-[EAGLContext presentRenderbuffer:]`.

 @see startWithAppToken:
 @param appToken The application token from your [control panel](http://delight.io/apps).
 */
+ (void)startOpenGLWithAppToken:(NSString *)appToken;

/** Writes the framebuffer pixel data to the recording. Call this method after drawing and before `-[EAGLContext presentRenderbuffer:]`. If you have multiple renderbuffers, use `takeOpenGLScreenshot:colorRenderbuffer:` instead.
 
 @see startOpenGLWithAppToken:
 @see takeOpenGLScreenshot:colorRenderbuffer:
 @param glView The OpenGL ES view.
 */
+ (void)takeOpenGLScreenshot:(UIView *)glView;

/** Writes the framebuffer pixel data to the recording. Call this method after drawing and before `-[EAGLContext presentRenderbuffer:]`. If your application creates only a single color renderbuffer which is already bound, you may use `takeOpenGLScreenshot:` instead.
 
 @see startOpenGLWithAppToken:
 @see takeOpenGLScreenshot:
 @param glView The OpenGL ES view.
 @param colorRenderbuffer The color renderbuffer object used to render the OpenGL ES view.
 */
+ (void)takeOpenGLScreenshot:(UIView *)glView colorRenderbuffer:(GLuint)colorRenderbuffer;

/**---------------------------------------------------------------------------------------
 * @name Adding Metadata
 * ---------------------------------------------------------------------------------------
 */

/** Sets a custom property for the current session. Session properties are shown when viewing recordings on delight.io, so this method can be used to attach arbitrary metadata to recordings. If multiple values are set for the same key, only the last value will be used.
 
 @param value The property value. Must be an NSString or NSNumber.
 @param key The property key.
 */
+ (void)setPropertyValue:(id)value forKey:(NSString *)key;

/**---------------------------------------------------------------------------------------
 * @name Controlling Privacy
 * ---------------------------------------------------------------------------------------
 */

/** Sets whether the on-screen keyboard should be covered up in the recording. Calling this method does not affect whether the on-screen keyboard is hidden for the user.
  
 **Note**: The keyboard is automatically hidden in the recording whenever the user is editing a UITextField with `secureTextEntry` enabled.
 
 @param hidesKeyboardInRecording YES if debug log statements should be printed to the console; otherwise, NO.
 */
+ (void)setHidesKeyboardInRecording:(BOOL)hidesKeyboardInRecording;

/** Returns a Boolean value indicating whether the on-screen keyboard will be covered up in the recording.
 
 @return YES if the on-screen keyboard will be covered up in the recording; otherwise, NO.
 */
+ (BOOL)hidesKeyboardInRecording;

/** Registers a view as being private, which covers it up in the recording.
 
 **Note**: Any UITextField with `secureTextEntry` enabled will automatically become a private view. No further action is required.
 
 @warning You must call `unregisterPrivateView:` before the view will be deallocated.
 @see unregisterPrivateView:
 @see privateViews
 @param view The view to make private.
 @param description A short description of the view, or `nil`. The description will appear in the recording.
 */
+ (void)registerPrivateView:(UIView *)view description:(NSString *)description;

/** Unregisters a private view. If the provided view was not private from before, this method has no effect.
  
 @see registerPrivateView:description:
 @see privateViews
 @param view The view to make non-private.
 */
+ (void)unregisterPrivateView:(UIView *)view;

/** Returns a set of all views that are currently private.
 
 @see registerPrivateView:description:
 @see unregisterPrivateView:
 @return A set of all views that are currently private.
 */
+ (NSSet *)privateViews;

/**---------------------------------------------------------------------------------------
 * @name Debugging
 * ---------------------------------------------------------------------------------------
 */

/** Sets whether debug log statements should be printed to the console. This can be useful for troubleshooting issues with the framework.
 
 @param debugLogEnabled YES if debug log statements should be printed to the console; otherwise, NO.
 */
+ (void)setDebugLogEnabled:(BOOL)debugLogEnabled;

/** Returns a Boolean value indicating whether debug log statements are printed to the console.
 
 @return YES if debug log statements are printed to the console; otherwise, NO.
 */
+ (BOOL)debugLogEnabled;

/** Sets whether recordings are saved to the user's photo album, accessible via the Photos app.
 
 @param savesToPhotoAlbum YES if recordings are to be saved to the user's photo album; otherwise, NO.
 */
+ (void)setSavesToPhotoAlbum:(BOOL)savesToPhotoAlbum;

/** Returns a Boolean value indicating whether recordings are saved to the user's photo album, accessible via the Photos app.
 
 @return YES if recordings are saved to the user's photo album; otherwise, NO.
 */
+ (BOOL)savesToPhotoAlbum;

@end
