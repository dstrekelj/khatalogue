# 1. Introduction

This entry provides a brief introduction to the fundamentals of working with Kha. Specifically, the presented samples demonstrate how to:

* set up a new Kha project;
* draw to the framebuffer with the `graphics1` API;
* utilise a consistent, platform-agnostic pseudorandom number generator;
* make use of elapsed time;
* schedule function calls.

By the end of this entry, the reader should have a firm grasp on how to set up a basic Kha project, and how to work with commonly used Kha APIs.

## 1.1. System initialisation

Every Kha project begins with a call to `System.init()`, marking the initialisation of the targeted system's application context. This not only sets up the rendering context, but also initialises APIs that handle input devices (keyboard, mouse, gamepad, touchpad, microphone, sensors ...), output devices (display, headphones, speakers, ...), scheduling, and more.

The application context is initialised with a configuration structure which can contain:

* the `title`, a text string used for the application title;
* window `width`, an integer describing the context window width;
* window `height`, an integer describing the context window height;
* `samplesPerPixel`, an integer setting the amount of anti-aliasing.

All of the above options are optional, as they have default values to fall back on.

Along with the configuration, the context is also given a callback function to be executed when the initial set up finishes.

With the above in mind, a simple Kha project can be boiled down to the following:

```haxe
class Main {
	static function main() : Void {
		kha.System.init(
			{title: "Kha project", width: 640, height: 240},
			init
		);
	}

	static function init() : Void {
		kha.System.notifyOnRender(render);
		kha.Scheduler.addTimeTask(update, 0, 1 / 60);
	}

	static function update() : Void {}

	static function render(framebuffer : kha.Framebuffer) : Void {}
}
```

Note the use of the `init()` function to set up `render()` and `update()` loops once the application context is initialised. The rendering frame rate is uncapped, and the application is expected to update at 60 frames per second. Kha's scheduler will go to great lengths to maintain the desired frame rate, even as far as going backwards and forwards in simulation time to achieve that.

> **Simulation time?**
>
> Kha distinguishes between _real time_ and _simulation time_.
>
> Real time is the running time of the application, from the moment the application context is initialised up until the moment the application is closed. As such, it only moves forwards.
>
> Simulation time is the running time of the scheduler. If the application is paused, out of focus, or halted in any way, the simulation time stops as well. Simulation time can move backwards _and_ forwards to attempt synchronisation in case of dropped frames, network latency, and similar. 

## 1.2. Rendering context

The rendering context is exposed in the form of a framebuffer, which is the visible colour output of the application. The framebuffer can be accessed and modified through any of Kha's graphics APIs:

* `graphics1` (`g1`), a 1D API modelled after old pixel-pushing hardware;
* `graphics2` (`g2`), a 2D API modelled after HTML5 canvas and Java painter APIs;
* `graphics4` (`g4`), a 3D API modelled after shader-based graphics APIS (OpenGL ES 2, Direct 3D 11).

Kha's graphics APIs are generational. Not only does each API mimic a particular generation of computer graphics APIs, the higher-level APIs also provide implementations for their predecessors. Generally, an API like `g1` makes use of the 'most modern' API implemented for the target platform, such as `g2` or `g4`. This way, the lower-level APIs can be used even if the rendering context is set up by a higher-level API.

> **Where's `graphics3`?**
>
> Following the generational design, the `graphics3` API aims to be an old-school 3D graphics API modelled after early OpenGL. At the time of writing, the name is just a placeholder, and the API is not yet implemented.

Drawing to the framebuffer is a three-step process:

1. Choose a graphics API (e.g. `g2`) and prepare the rendering context with a call to `begin()` (e.g. `g2.begin()`);
2. Use drawing functions provided by the API;
3. After all drawing is performed, finalize the context with a call to `end()` (e.g. `g2.end()`).

The samples in this entry make use of `g1`, because its simplicity won't distract from the other showcased APIs. Drawing to the framebuffer with `g1` is performed as follows:

```haxe
static function render(framebuffer : kha.Framebuffer) : Void {
	var g1 = framebuffer.g1;
	g1.begin();
	g1.setPixel(320, 120, kha.Color.White);
	g1.end();
}
```

This sample draws a white pixel to the framebuffer at position (320, 120) relative to its top-left corner. 

## 1.3. Random number generation

Kha's pseudorandom number generator - located in `kha.math.Random` - is an implementation of the Mersenne Twister. Using it is the recommended way of performing pseudorandom number generation, because the underlying implementation does not make use of platform-specific APIs and should therefore be consistent across all supported platforms.

To use the generator, instantiate it with an integer seed. Alternatively, rely on the static instance and methods which the `kha.math.Random` class provides for convenience.

```haxe
static var random = new kha.math.Random(0);
```

The generator makes it possible to generate floating point or integer numbers, either at 'random' or in a specified range. To draw a number of pixels at random positions, generate integer numbers in the range of framebuffer dimensions. Note that setting pixels outside the framebuffer dimensions results in an attempt to write outside of allocated framebuffer memory, which will cause the application to crash.

```haxe
g1.begin();
for (i in 0...(framebuffer.width * framebuffer.height)) {
	g1.setPixel(
		random.GetUpTo(framebuffer.width - 1),
		random.GetUpTo(framebuffer.height - 1),
		kha.Color.White
	);
}
g1.end();
```

This sample creates 'white noise', as different pixels are coloured white every frame, at random.

## 1.4. Simulation time

The scheduler - located in `kha.Scheduler` - is a powerful API for scheduling and managing time and frame tasks. It also exposes the previously discussed real and simulation time variables.

This sample demonstrates how simulation time can be used with a periodic function to draw animated pixels to the framebuffer.

First, declare `amplitude` and `period` variables for the periodic function.

```haxe
static var amplitude : Int = 100;
static var period : Int = 100;
```

Then, draw a row of pixels the width of the framebuffer, calculating the periodic function in the process.

```haxe
g1.begin();
for (i in 0...framebuffer.width) {
	var dy = Math.sin(kha.Scheduler.time() + i / period);
	g1.setPixel(
		i,
		120 + Std.int(amplitude * dy),
		kha.Color.White
	);
}
g1.end();
```

The result is an animated sine wave.

## 1.5. Colours

Kha also provides an API for working with colours in the form of `kha.Color`. At run-time, a colour is represented by a 32-bit (unsigned) integer where colour channels are packed in an ARGB format. At compile-time, the API allows for colours to be created from a hex string, integer value, byte components, or float components. Additionally, colour channels can be read or written to directly with use of byte or float values.

Continuing the previous sample, colouring the sine wave according to the calculated `dy` value can be performed as follows. First, declare a static `color` variable for the pixel colour.

```haxe
static var color : kha.Color = kha.Color.White;
```

Then, modify the colour's alpha channel value according to the calculated `dy`.

```haxe
g1.begin();
for (i in 0...framebuffer.width) {
	var dy = Math.sin(kha.Scheduler.time() + i / period);
	color.A = Math.abs(dy);
	g1.setPixel(
		i,
		120 + Std.int(amplitude * dy),
		color
	);
}
g1.end();
```

The result is a sine wave of a brigther colour towards its peaks, and darker colour towards its valleys.

## 1.6. Scheduling tasks

This final sample sets up a task which randomises `amplitude`, `period`, and `color` parameter values periodically, therefore generating sine waves of various colours, shapes, and sizes.

First, set up constants for minimum and maximum parameter values, as well as a constant for the task period. Note that the scheduler observes the passage of time in seconds, and the same goes for scheduled time tasks.

```haxe
static inline var MAX_AMPLITUDE : Int = 100;
static inline var MIN_AMPLITUDE : Int = 10;

static inline var MAX_COLOR_CHANNEL_VALUE : Float = 1.0;
static inline var MIN_COLOR_CHANNEL_VALUE : Float = 0.3;

static inline var MAX_PERIOD : Int = 100;
static inline var MIN_PERIOD : Int = 10;

static inline var TASK_PERIOD : Int = 2;
```

Then, initialise the parameters.

```haxe
static var random = new kha.math.Random(0);

static var amplitude : Int = MAX_AMPLITUDE;
static var period : Int = MAX_PERIOD;
static var color : kha.Color = kha.Color.White;
```

Next, define the randomisation function. The `amplitude` and `period` parameters will be given a value in the range specified by their minimum and maximum values. The same goes for the `color` parameter's colour channel values.

```haxe
static function randomize() : Void {
	amplitude = random.GetIn(MIN_AMPLITUDE, MAX_AMPLITUDE);
	period = random.GetIn(MIN_PERIOD, MAX_PERIOD);
	color = kha.Color.fromFloats(
		random.GetFloatIn(0.3, 1.0),
		random.GetFloatIn(0.3, 1.0),
		random.GetFloatIn(0.3, 1.0)
	);
}
```

Following that, schedule the randomisation task to occur at the specified period, beginning with the time the application starts.

```haxe
static function init() : Void {
	// ...
	kha.Scheduler.addTimeTask(randomize, 0, TASK_PERIOD);
}
```

The `render()` code remains untouched, as all changes are performed by the `randomize()` function.
