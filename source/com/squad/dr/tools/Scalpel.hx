package com.squad.dr.tools;
import com.squad.dr.widgets.Button;
import com.squad.dr.PubNub;

class Scalpel extends Tool
{
  public override function initialise(attributes:Dynamic)
  {
    attributes.image_name = "assets/dr/tools/scalpel.png";
    attributes.tool_name =  "Scalpel";
    super.initialise(attributes);
  }

  public override function onToolClick(): Void
  {
    trace("Scalpel was clicked");
  }
}
