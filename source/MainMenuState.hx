package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import Achievements;
import editors.MasterEditorMenu;
import flixel.FlxCamera;

using StringTools;

class MainMenuState extends MusicBeatState
{
	private var camGame:FlxCamera;
	private var camAchievement:FlxCamera;

	public static var psychEngineVersion:String = '0.6.2';
	public static var Zer0Version:String = '1.0';
	public static var curSelected:Int = 0;

	var optionShit:Array<String> = ['story_mode', 'freeplay', 'options', 'credits', 'awards'];
	var menuItems:FlxTypedGroup<FlxSprite>;
	var freeplay:FlxSprite;
	var options:FlxSprite;
	var credits:FlxSprite;
	var awards:FlxSprite;
	var story:FlxSprite;

	var bg:FlxSprite;	

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		camGame = new FlxCamera();
		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camAchievement);
		FlxCamera.defaultCameras = [camGame];

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		bg = new FlxSprite().loadGraphic(Paths.image('BG'));
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		story = new FlxSprite(-100, -400).loadGraphic(Paths.image('mainmenu/Adventure-Mode'));
		menuItems.add(story);
		story.scrollFactor.set();
		story.antialiasing = ClientPrefs.globalAntialiasing;
		story.setGraphicSize(Std.int(story.width * 0.7));
		story.y += 230;		
		story.x -= 200;
		story.alpha = 0.60;

		freeplay = new FlxSprite(-100, -400).loadGraphic(Paths.image('mainmenu/menu_freeplay'));
		menuItems.add(freeplay);
		freeplay.scrollFactor.set();
		freeplay.antialiasing = ClientPrefs.globalAntialiasing;
		freeplay.setGraphicSize(Std.int(freeplay.width * 0.7));
		freeplay.y += 230;		
		freeplay.x -= 200;
		freeplay.alpha = 0.60;

		options = new FlxSprite(-100, -400).loadGraphic(Paths.image('mainmenu/menu_options'));
		menuItems.add(options);
		options.scrollFactor.set();
		options.antialiasing = ClientPrefs.globalAntialiasing;
		options.setGraphicSize(Std.int(options.width * 0.7));
		options.y += 230;
		options.x -= 200;
		options.alpha = 0.60;

		credits = new FlxSprite(-100, -400).loadGraphic(Paths.image('mainmenu/menu_credits'));
		menuItems.add(credits);
		credits.scrollFactor.set();
		credits.antialiasing = ClientPrefs.globalAntialiasing;
		credits.setGraphicSize(Std.int(credits.width * 0.7));
		credits.y += 230;
		credits.x -= 200;
		credits.alpha = 0.60;

		awards = new FlxSprite(-100, -400).loadGraphic(Paths.image('mainmenu/menu_awards'));
		menuItems.add(awards);
		awards.scrollFactor.set();
		awards.antialiasing = ClientPrefs.globalAntialiasing;
		awards.setGraphicSize(Std.int(awards.width * 0.7));
		awards.y += 200;
		awards.x -= 200;
		awards.alpha = 0.60;	
		
		var versionShit:FlxText = new FlxText(12, FlxG.height - 24, 0, "Vs Zer0 V" + Zer0Version, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);


		// NG.core.calls.event.logEvent('swag').send();

		#if html5
		FlxG.sound.playMusic(Paths.music('freakyMenu'));
		#end
		
		changeItem();

		super.create();
	}

	public function goToState()
	{
		var daChoice:String = optionShit[curSelected];

		switch (daChoice)
		{
			case 'story_mode':
				MusicBeatState.switchState(new StoryMenuState());
			case 'freeplay':
				MusicBeatState.switchState(new FreeplayState());
			case 'options':
				MusicBeatState.switchState(new options.OptionsState());
			case 'credits':
				MusicBeatState.switchState(new CreditsState());	
			case 'awards':
				MusicBeatState.switchState(new AchievementsMenuState());				
		}
	}

	public function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;	

		switch (optionShit[curSelected])
		{
			case 'story_mode':
				story.alpha = 1;
				freeplay.alpha = 0.6; 
				awards.alpha = 0.6;				
				credits.alpha = 0.6;  
				options.alpha = 0.6; 
			case 'freeplay':
				story.alpha = 0.6;
				freeplay.alpha = 1; 
				awards.alpha = 0.6;				
				credits.alpha = 0.6;  
				options.alpha = 0.6; 				
			case 'options':		
				story.alpha = 0.6;
				freeplay.alpha = 0.6;	
				awards.alpha = 0.6;  
				credits.alpha = 0.6; 
				options.alpha = 1; 
			case 'credits':	
				story.alpha = 0.6;
				freeplay.alpha = 0.6;
				awards.alpha = 0.6;		
				credits.alpha = 1; 
				options.alpha = 0.6;  
			case 'awards':
				story.alpha = 0.6;
				freeplay.alpha = 0.6;	
				awards.alpha = 1;				
				credits.alpha = 0.6; 
				options.alpha = 0.6; 				
		}						
	}
}
