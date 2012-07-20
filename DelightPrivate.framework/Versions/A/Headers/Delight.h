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

/** Starts capturing the screen and recording gestures, with no annotation.
 
 @see startWithAppToken:annotation:
 @param appToken The application token from your [control panel](http://delight.io/apps).
 */
+ (void)startWithAppToken:(NSString *)appToken;

/** Starts capturing the screen and recording gestures. The recording will automatically end when the app is sent to the background. A new recording will be started whenever the app is brought to the foreground. Recordings only take place if you have scheduled recordings in your [control panel](http://delight.io/apps).
 
 @warning This method should only be called once, typically in your application delegate's `applicationDidFinishLaunching:withOptions:` method.
 @param appToken The application token from your [control panel](http://delight.io/apps).
 @param annotation The type of annotation. Annotation can be used to capture the front camera, if supported by the device.
 */
+ (void)startWithAppToken:(NSString *)appToken annotation:(DLAnnotation)annotation;

/** Stops the current recording and all future recordings.
 */
+ (void)stop;

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
 * @name Controlling Uploads
 * ---------------------------------------------------------------------------------------
 */

/** Sets whether the current recording should be automatically uploaded when the app gets sent to the background. By default, the recording will be uploaded. If this property is set to NO, the recording will not be uploaded.
  
 @param uploadsAutomatically YES if the current recording will be uploaded when the app gets sent to the background; otherwise, NO.
 */
+ (void)setUploadsAutomatically:(BOOL)uploadsAutomatically;

/** Returns a Boolean value indicating whether the current recording will be uploaded when the app gets sent to the background.
 
 @return YES if the current recording will be uploaded when the app gets sent to the background; otherwise, NO.
 */
+ (BOOL)uploadsAutomatically;

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
