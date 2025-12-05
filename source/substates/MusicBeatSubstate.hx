package substates;

import flixel.input.gamepad.FlxGamepad;
import states.MusicBeatState;
import lime.app.Application;
import flixel.input.FlxInput.FlxInputState;
import flixel.FlxSprite;
import flixel.FlxBasic;
import game.Conductor;
import utilities.PlayerSettings;
import utilities.Controls;
import game.Conductor.BPMChangeEvent;
import flixel.FlxG;
import flixel.FlxSubState;
import modding.scripts.languages.HScript;


#if mobile
import mobile.objects.FunkinMobilePad;
#end
import flixel.FlxCamera;
import flixel.input.actions.FlxActionInput;
import flixel.util.FlxDestroyUtil;

class MusicBeatSubstate extends FlxSubState {
	public var curStep:Int = 0;
	public var curBeat:Int = 0;
	public var controls(get, never):Controls;
	public static var instance:MusicBeatSubstate;

	#if HSCRIPT_ALLOWED
	public var stateScript:HScript;
	#end
	public static var usingController:Bool = false;
	#if mobile
	var mobilePad:FunkinMobilePad;
	//mobile
	public function addMobilePad(DPad:String, Action:String, visible:Bool = true):Void
	{
		if (mobilePad != null)
			removeMobilePad();

		mobilePad = new FunkinMobilePad(DPad, Action, 0.7);
		mobilePad.visible = visible;
		add(mobilePad);
	}

	public function addMobilePadCamera(DefaultDrawTarget:Bool = false):Void
	{
		if (mobilePad != null)
		{
			var camControls:FlxCamera = new FlxCamera();
			camControls.bgColor.alpha = 0;
			FlxG.cameras.add(camControls, DefaultDrawTarget);
			mobilePad.cameras = [camControls];
		}
	}

	public function removeMobilePad():Void
	{
		if (mobilePad != null)
			remove(mobilePad);
	}
	#end
	override public function create() {
		super.create();
		#if HSCRIPT_ALLOWED
		var statePath:String = Type.getClassName(Type.getClass(this)).replace(".", "/");
		if (sys.FileSystem.exists('mods/${Options.getData("curMod")}/classes/${statePath}.hx')) {
			stateScript = new HScript('mods/${Options.getData("curMod")}/classes/${statePath}.hx');
		}
		#end
	}
	public function new() {
		instance = this;
		super();
	}

	override function update(elapsed:Float) {
		var oldStep:Int = curStep;

		updateCurStep();
		curBeat = Math.floor(curStep / 4);

		if (oldStep != curStep && curStep > 0)
			stepHit();

		super.update(elapsed);

		if (FlxG.keys.checkStatus(FlxKey.fromString(Options.getData("fullscreenBind", "binds")), FlxInputState.JUST_PRESSED))
			FlxG.fullscreen = !FlxG.fullscreen;

		if (FlxG.keys.justPressed.F5 && Options.getData("developer"))
			FlxG.resetState();


		Application.current.window.title = MusicBeatState.windowNamePrefix + MusicBeatState.windowNameSuffix;

		if (FlxG.mouse.justPressed || FlxG.mouse.justMoved || FlxG.keys.justPressed.ANY #if mobile || MobileControls.justPressedAny() #end)
		{
			usingController = false;
		}
		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;
		if (gamepad != null)
		{
			if (gamepad.anyInput())
				usingController = true;
		}
	}

	
	override function destroy():Void {
		super.destroy();

		if (mobilePad != null)
			mobilePad = FlxDestroyUtil.destroy(mobilePad);
	}


	public function updateCurStep():Void {
		var lastChange:BPMChangeEvent = {
			stepTime: 0,
			songTime: 0,
			bpm: 0
		}
		for (i in 0...Conductor.bpmChangeMap.length) {
			if (Conductor.songPosition > Conductor.bpmChangeMap[i].songTime)
				lastChange = Conductor.bpmChangeMap[i];
		}

		curStep = lastChange.stepTime + Math.floor((Conductor.songPosition - lastChange.songTime) / Conductor.stepCrochet);
	}

	public function stepHit():Void {
		if (curStep % 4 == 0)
			beatHit();
	}

	public function beatHit():Void {
		// do literally nothing dumbass
	}

	@:noCompletion
	inline function get_controls():Controls
		return PlayerSettings.player1.controls;
}
