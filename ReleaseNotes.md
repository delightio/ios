Delight Release Notes
=====================
___

2.3.2
=====
---

* Fixed crash in iOS 6.x.

2.3.1
=====
---

* Fixed crash in unregisterPrivateView when the view had a refcount of 1.

2.3
===
---

* Added annotation mode - now possible to record the front camera in addition to the screen.
* Added uploadsAutomatically property, which can be used to turn on/off uploading of recordings.

2.2.2
=====
---

* Fixed crash when recording finished in DelightPrivate.framework.
* Fixed an issue where private view contents would sometimes be shown when animated.
* Fixed an issue where gesture dots were not positioned correctly.

2.2.1
=====
---

* Removed dependencies on AssetsLibrary and OpenGLES.
* Removed savesToPhotoAlbum property.

2.2
===
---

* Added DelightPrivate.framework, a special version of Delight that uses private API calls for high performance.
* Removed OpenGL support from Delight.framework (use DelightPrivate.framework instead).

2.1.3
=====
---

* Improved OpenGL performance.
* Improved stability when recording UIWebViews.

2.1.2
=====
---

* Fixed a crash that occurred when capturing a UIWebView.
* Fixed a bug relating to resuming partial uploads.

2.1.1
=====
---

* Fixed a bug where gestures would not be drawn if Delight was started before a window had been added.

2.1
===
---

* Added OpenGL ES support.

2.0.5
=====
---

* Minor bug fixes.

2.0.4
=====
---

* Make private views flash when tapped.

2.0.3
=====
---

* Fixed a crash that occurred when unregistering a UIWebView as a private view.

2.0.2
=====
---

* Fixed an issue where private views would be hidden too early.

2.0.1
=====
---

* Fixed an issue where the application would terminate after being in the background for a while.

2.0
===
___

Delight 2.0 contains several API changes, performance improvements, and bug fixes. Users running previous versions of the framework must upgrade to version 2.0; otherwise, new sessions will not be recorded, regardless of whether recordings have been scheduled.

Important Notes
---------------

* A new framework dependency has been added: developers must now link AssetsLibrary.framework in their targets.

Changelog
---------

* API changes:
  * **Properties**: To attach arbitrary metadata to sessions, you can call `[Delight setPropertyValue:forKey:]` with a key and value of your choosing. The value must be either an NSString or NSNumber. In the control panel, it is possible to filter recordings by property.

  * **Debug Logging**: Debug logging to the console can be turned on/off by calling `[Delight setDebugLogEnabled:]`.

  * It is no longer possible to manually set the scale factor or maximum frame rate. Reasonable defaults will be used.

  * Pausing/resuming recording and manually triggering screenshots are no longer supported.

* Improved UIKit performance.

* Smoother gesture drawing.

* Secure UITextFields are now automatically registered as private views.

* Fixed a crash that occurred when a new session could not be created (e.g. if the app token was invalid).

* Fixed a crash that occurred when recording a UIWebView.

* Fixed touch locations being incorrect in windows other than the main window.

