import hxd.BitmapData;
import h2d.TileGroup;
import h2d.Bitmap;
import hxd.res.DefaultFont;
import hxd.Res;
import h2d.Text;

class App extends hxd.App {
	override function init() {
		super.init();

		var logo = hxd.Res.haxe_logo.toTile();
		var bmp = new Bitmap(logo, s2d);

		bmp.setPosition(s2d.width/2 - logo.width/2, s2d.height/2 - logo.height/2);

		var text = new Text(DefaultFont.get(), s2d);
		text.text = "Hello World!!";
		text.textAlign = Center;

		text.setPosition(s2d.width/2, s2d.height/2);
	}
}

class Main {
	static function main() {
		hxd.Res.initEmbed();
		new App();
	}
}
