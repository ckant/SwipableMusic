/**
 * Name:   Swipe Navigation for Music 
 * Pkg:    com.ckant.swipablemusic
 * Author: Chris Kant
 * Date:   02-07-2012 
 */

#import <MediaPlayer/MPAVController.h>
#import <MediaPlayer/MPSwipableView.h>
#import <MediaPlayer/MPSwipeGestureRecognizer.h>

%hook MPSwipableView

typedef enum {
  MP_SWIPE_DIRECTION_UP    = 1,
  MP_SWIPE_DIRECTION_DOWN  = 2,
  MP_SWIPE_DIRECTION_LEFT  = 3,
  MP_SWIPE_DIRECTION_RIGHT = 4
} MP_SWIPE_DIRECTION;

/**
 * Called when a swipe gesture was performed within the audio player
 */
-(void)_swipeGestureRecognized:(id)recognized {
  
  // Make sure swipe gesture recognizer is the MPSwipeGestureRecognizer
  if ([recognized isKindOfClass:[%c(MPSwipeGestureRecognizer) class]]) {
  
    // Music playback controller
    MPAVController* mpavController = [%c(MPAVController) sharedInstance];
    
    // Get swipe direction
    MPSwipeGestureRecognizer* swipeGestureRecognizer = 
      (MPSwipeGestureRecognizer*)recognized;
      
    MP_SWIPE_DIRECTION swipeDirection = 
      (MP_SWIPE_DIRECTION)swipeGestureRecognizer.swipeDirection;
    
    switch(swipeDirection) {
      
      case MP_SWIPE_DIRECTION_RIGHT: {
        [mpavController changePlaybackIndexBy:-1]; // Previous track
        break;
      } // case right

      case MP_SWIPE_DIRECTION_LEFT: {
        [mpavController changePlaybackIndexBy:1]; // Next track
        break;
      } // case left
      
      // Maintain default up and down swipe actions
      case MP_SWIPE_DIRECTION_UP:
      case MP_SWIPE_DIRECTION_DOWN:
      default: {
        %orig;
        break;
      } // case up/down/default

    } // switch swipeDirection
  
  } else {
    
    %orig;
  
  } // if instance of MPSwipeGestureRecognizer class

} // _swipeGestureRecognized

%end
