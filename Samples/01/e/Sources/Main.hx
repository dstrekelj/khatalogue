class Main {
	static inline var MAX_AMPLITUDE : Int = 100;
	static inline var MIN_AMPLITUDE : Int = 10;

	static inline var MAX_COLOR_CHANNEL_VALUE : Float = 1.0;
	static inline var MIN_COLOR_CHANNEL_VALUE : Float = 0.3;

	static inline var MAX_PERIOD : Int = 100;
	static inline var MIN_PERIOD : Int = 10;

	static inline var TASK_PERIOD : Int = 2;

	static var random = new kha.math.Random(0);

	static var amplitude : Int = MAX_AMPLITUDE;
	static var period : Int = MAX_PERIOD;

	static var color : kha.Color = kha.Color.White;

	static function main() {
		kha.System.init(
			{title: "Khatalogue - 01e", width: 640, height: 240},
			init
		);
	}

	static function init() : Void {
		kha.System.notifyOnRender(render);
		kha.Scheduler.addTimeTask(update, 0, 1 / 60);
		kha.Scheduler.addTimeTask(randomize, 0, TASK_PERIOD);
	}

	static function randomize() : Void {
		amplitude = random.GetIn(MIN_AMPLITUDE, MAX_AMPLITUDE);
		period = random.GetIn(MIN_PERIOD, MAX_PERIOD);
		color = kha.Color.fromFloats(
			random.GetFloatIn(MIN_COLOR_CHANNEL_VALUE, MAX_COLOR_CHANNEL_VALUE),
			random.GetFloatIn(MIN_COLOR_CHANNEL_VALUE, MAX_COLOR_CHANNEL_VALUE),
			random.GetFloatIn(MIN_COLOR_CHANNEL_VALUE, MAX_COLOR_CHANNEL_VALUE)
		);
	}

	static function update() : Void {}

	static function render(framebuffer : kha.Framebuffer) : Void {
		var g1 = framebuffer.g1;
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
	}
}
