package com.squad.dr;

import org.flixel.FlxG;
import org.flixel.FlxState;
import org.flixel.FlxSprite;
import org.flixel.FlxPoint;
import org.flixel.FlxButton;

class Menu extends FlxState
{
  private var _startButton:FlxButton;
  private var _aboutButton:FlxButton;
  private var _exitButton:FlxButton;

  override public function create():Void
  {
    trace("showing menu screen");
    FlxG.mouse.show();
    FlxG.bgColor = 0xffffffff;

    var titleGraphic = new FlxSprite(0, 0);
    titleGraphic.loadGraphic("assets/dr/title.png");
    add(titleGraphic);

    _startButton = new FlxButton(120, 500, "Summon Squad", _onStartClick);
    _aboutButton = new FlxButton(120, 560, "About", _onAboutClick);
    _exitButton = new FlxButton(120, 620, "Exit", _onExitClick);

    add(_startButton);
    add(_aboutButton);
    add(_exitButton);
  }

  override public function destroy():Void
  {
    super.destroy();
  }

  override public function update():Void
  {
    super.update();
  }


  //buttons
  private function _onStartClick( ):Void
  {
    FlxG.switchState(new Lobby());
  }

  private function _onAboutClick( ):Void
  {
    FlxG.switchState(new About());
  }

  private function _onExitClick( ):Void
  {
    native.system.System.exit();
  }
}