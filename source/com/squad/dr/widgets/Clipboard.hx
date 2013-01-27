package com.squad.dr.widgets;

import org.flixel.FlxSprite;
import org.flixel.FlxG;
import org.flixel.FlxText;

import com.squad.dr.PubNub;
import com.squad.dr.widgets.Widget;

typedef Step = {
  var message : String;
  var action  : String;
  var data    : String;
}

class Clipboard extends Widget
{
  private var _steps:Array<Step>;
  private var _currentStep:Int=0;
  private var _messageLabel:FlxText;
  private var _finished:Bool=false;
  private var _attrSteps: Array<Dynamic>;
  private var _listen_key:Int = 0;

  public override function initialise(attributes:Dynamic)
  {
    _steps = new Array<Step>();

    _attrSteps = attributes.steps;
    for (step in _attrSteps)
    {
      var s = {
        message: step[0],
        action:  step[1],
        data:    step[2]
      }
      _steps.push(s);
    }

    _listen_key = PubNub.room.register({type: "tool"});

    _messageLabel = new FlxText(0, 0, 4800, "Your tasklist..." );
    _messageLabel.size = 12;
    add(_messageLabel);

    _updateUI();
    PubNub.room.send({type: "clipboard", action: "init", widgetId: _widgetId, data: _steps.length + "" });
  }


  private function _stepComplete() {
    PubNub.room.send({type: "clipboard", action: "stepcomplete", widgetId: _widgetId, data: _steps[_currentStep].message});
    if (_steps.length > _currentStep+1) {
      _currentStep += 1;
    } else {
      PubNub.room.send({type: "clipboard", action: "complete", widgetId: _widgetId});
      _finished = true;
    }
    _updateUI();
  }

  private function _updateUI()
  {
    if( _finished )
      _messageLabel.text = "All done good job!";
    else
      _messageLabel.text = _steps[_currentStep].message;
  }

  public override function update()
  {
    super.update();
    PubNub.room.consume(_listen_key, function(message) {
      DrSquad.log( "message" );
      DrSquad.log( message + "" );
      DrSquad.log( "_steps[_currentStep]" );
      DrSquad.log( _steps[_currentStep] + "" );
      if (message.action == _steps[_currentStep].action &&
          _steps[_currentStep].data == "" || _steps[_currentStep].data == message.data )
      {
        DrSquad.log("Good Job!");
        _stepComplete();
      }
    });
  }

  public override function destroy()
  {
    PubNub.room.deregister(_listen_key);
    super.destroy();
  }

}
