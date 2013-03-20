//
//  Delight.h
//  Delight
//
//  Copyright (c) 2012 Pipely Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    DLAnnotationNone,
    DLAnnotationFrontVideoAndAudio
} DLAnnotation;


/** The `Delight` class is used to set up screen and gesture recording. Refer to the [QuickStart Guide](http://delight.io/docs) for installation instructions.

 The most important method is `startWithAppToken:`, which in most cases should be called as soon as possible after app launch, typically in your application delegate's `applicationDidFinishLaunching:withOptions:` method.
 */
@interface Delight : NSObject

/**---------------------------------------------------------------------------------------
 * @name Starting and Stopping Recording
 * ---------------------------------------------------------------------------------------
 */

/** Starts capturing the screen and recording gestures. The recording will automatically end when the app is sent to the background. A new recording will be started whenever the app is brought to the foreground. Recordings only take place if you have scheduled recordings in your [control panel](http://delight.io/apps).

 @warning This method should only be called once, typically in your application delegate's `applicationDidFinishLaunching:withOptions:` method.
 @param appToken The application token from your [control panel](http://delight.io/apps).
 */
+ (void)startWithAppToken:(NSString *)appToken;

/** Starts recording with optional front camera. 
 
 @param appToken The application token from your [control panel](http://delight.io/apps).
 @param annotation Use `DLAnnotationFrontVideoAndAudio` to capture the front camera.
 */

+ (void)startWithAppToken:(NSString *)appToken annotation:(DLAnnotation)annotation;


/** Stops the current recording and all future recordings.
 */
+ (void)stop;

/**---------------------------------------------------------------------------------------
 * @name Controlling Privacy
 * ---------------------------------------------------------------------------------------
 */

/** Sets whether the on-screen keyboard should be covered up in the recording. Calling this method does not affect whether the on-screen keyboard is hidden for the user.

 **Note**: The keyboard is automatically hidden in the recording whenever the user is editing a UITextField with `secureTextEntry` enabled.

 @param hidesKeyboardInRecording YES if the on-screen keyboard will be covered up in the recording; otherwise, NO.
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
 * @name Tracking events
 * ---------------------------------------------------------------------------------------
 */

/** Tracks an event.

 @param eventName The name of the event.
 @param eventInfo A dictionary of additional information to track with the event (optional).
 */
+ (void)trackEvent:(NSString *)eventName info:(NSDictionary *)eventInfo;

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

@end
