class Main {
	static function main() {
		kha.System.init(
			{title: "Khatalogue - 01a", width: 640, height: 240},
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
		g1.setPixel(320, 120, kha.Color.White);
		g1.end();
	}
}
