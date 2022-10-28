package states.awards;

import flixel.FlxState;
import flixel.FlxG;

class ClearState extends FlxState {

    override public function create() {
        super.create();

        resetAwards();
    }

    public function resetAwards() {
        FlxG.save.data.usernameAward = false;

        leave();
    }

    public function leave() {
        FlxG.switchState(new states.awards.AwardsState());
    }
}