# Add the following line to your project in Framer Studio. 
# myModule = require "myModule"
# Reference the contents by name, like myModule.myFunction() or myModule.myVar

TouchEmulator = require "hammer-touchemulator"
TouchEmulator()
Hammer = require "hammerjs"


exports.init = ->
  HammerEvents =

    Pan: "pan"
    PanStart: "panstart"
    PanMove: "panmove"
    PanEnd: "panend"
    PanCancel: "pancancel"
    PanLeft: "panleft"
    PanRight: "panright"
    PanUp: "panup"
    PanDown: "pandown"

    Pinch: "pinch"
    PinchStart: "pinchstart"
    PinchMove: "pinchmove"
    PinchEnd: "pinchend"
    PinchCancel: "pinchcancel"
    PinchIn: "pinchin"
    PinchOut: "pinchout"

    Press: "press"
    PressUp: "pressup"

    Rotate: "rotate"
    RotateStart: "rotatestart"
    RotateMove: "rotatemove"
    RotateEnd: "rotateend"
    RotateCanel: "rotatecancel"

    Swipe: "swipe"
    SwipeUp: "swipeup"
    SwipeDown: "swipedown"
    SwipeLeft: "swipeleft"
    SwipeRight: "swiperight"

    Tap: "tap"

  # Add the Hammer events to the base Framer events
  window.Events = _.extend Events, HammerEvents

  # Patch the on method on layers to listen to Hammer events
  class HammerLayer extends Framer.Layer
    
    on: (eventName, f) ->
      
      if eventName in _.values(HammerEvents)
        @ignoreEvents = false
        hammer = new Hammer(@_element)
        hammer.get(eventName)?.set({ enable: true });
        hammer.on eventName, f
      
      else
        super eventName, f

  # Replace the default Layer with the HammerLayer
  window.Layer = HammerLayer