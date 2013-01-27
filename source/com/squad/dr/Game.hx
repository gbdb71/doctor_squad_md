package com.squad.dr;

import com.squad.dr.Spawner;
import com.squad.dr.User;
import org.flixel.FlxG;

class Game
{
  var _frame:Float;
  var _timer:Float;
  var _state:String;

  private static var _steps:Array<Array<String>> = [
        ["Need Ephidrine Stat!", "syringe", "Ephidrine"],
        ["Inject Paradoxamol!", "syringe", "Paradoxamol"],
        ["Need Adrenaline Stat!", "syringe", "Adrenaline"],
        ["Incision", "scalpel", ""]
      ];

  public function new()
  {
    _frame = 0.0;
    _switch_to("Start");
  }

  public function update()
  {
    var elapsed = FlxG.elapsed;
    _frame += elapsed;
    _timer += elapsed;
    switch(_state) {
      case "Start":
        _state_start();
      case "Spawn":
        _state_spawn();
      case "Play":
        _state_play();
    }
  }

  private function _state_start()
  {
    if (_timer > 2.0) {
      _switch_to('Spawn');
    }
  }

  private function _state_spawn()
  {
    if (User.me.is_boss) {
      Spawner.god.create('Generator', null, null, {});
      Spawner.god.create('Scalpel', User.randomPlayer(), null, {
        x: 400,
        y: 400
      });
      Spawner.god.create('Syringe', User.randomPlayer(), null, {
        x: 200,
        y: 400,
        drugs: ["Adrenaline", "Ephidrine", "Paradoxamol"]
      });

      



      for (userId in User.me.team)
      {
        Spawner.god.create('Clipboard', userId, null, {
          steps: [ 
            _randomStep(),
            _randomStep(),
            _randomStep(),
            ]
        }); 
      }
    }
    _switch_to('Play');
  }

  private function _randomStep()
  {
    var i = Std.int(Math.random() * (_steps.length - 1));
    return _steps[i];
  }

  private function _state_play()
  {
  }

  private function _switch_to(state)
  {
    trace("GAME STATE : " + state);
    _timer = 0.0;
    _state = state;
  }
}
