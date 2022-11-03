package modding;

class ModPaths {

    public static function data(key:String) {
        return 'mods/data/${key}';
    } 

    public static function themeImage(key:String) {
        return 'mods/themes/${key}.png';
    }
}