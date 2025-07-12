import hxd.res.DefaultFont;
import hxd.Res;
import h2d.Text;

class App extends hxd.App {
	override function init() {
		super.init();

		var text = new Text(DefaultFont.get(), s2d);
		text.text = "Hello World!!";
		text.textAlign = Center;

		text.setPosition(s2d.width/2, s2d.height/2);
	}
}

class Main {
	static function main() {
		new App();
	}
}
