import hxd.snd.Channel;
import hxd.res.Sound;
import hxd.snd.Manager;
import haxe.Timer;
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

		//var music = hxd.Res.Spring_Village;
		var music = hxd.Res.samples_sound_res_music_loop;
		var thunder = hxd.Res.mixkit_strong_close_thunder_explosion_1300;

		var musicChannel = music.play(true);
		trace("music is playing");

		musicChannel.onEnd = function() {
			trace("Loop");
		}

		Timer.delay(()->thunder.play(), 3_000);

		trace('ogg supported: ${Sound.supportedFormat(OggVorbis)}');
	}
}

class Main {
	static function main() {
		hxd.Res.initEmbed();
		new App();
	}
}
