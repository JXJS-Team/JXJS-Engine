package states.modding;

class ModPaths {

    public static function config() {
        return 'mods/config.cool';
    }

    public static function image(key:String) {
        return 'mods/images/${key}.png';
    }
}