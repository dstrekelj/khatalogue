class Main {
	static var random = new kha.math.Random(0);

	static function main() {
		kha.System.init(
			{title: "Khatalogue - 01b", width: 640, height: 240},
			init
		);
	}

	static function init() : Void {
		kha.System.notifyOnRender(render);
		kha.Scheduler.addTimeTask(update, 0, 1 / 60);
	}

	static function update() : Void {}

	static function render(framebuffer : kha.Framebuffer) : Void {
		var g1 = framebuffer.g1;
		g1.begin();
		for (i in 0...(framebuffer.width * framebuffer.height)) {
			g1.setPixel(
				random.GetUpTo(framebuffer.width - 1),
				random.GetUpTo(framebuffer.height - 1),
				kha.Color.White
			);
		}
		g1.end();
	}
}
