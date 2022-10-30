## The JXJS Engine Team Credits
- [Jotaro-Gaming](https://youtube.com/c/JotaroGamingg) - Programmer and composer Friday Night Funkin: JXJS Engine
- [XuelDev](https://www.instagram.com/xueldev/) - Programmer Friday Night Funkin : JXJS Engine
- [Juanen100](https://twitter.com/Juanen1001) - Programmer Friday Night Funkin : JXJS Engine


## FNF
- [Kawaisprite](https://twitter.com/kawaisprite) - Musician of fnf
- [ninjamuffin99](https://twitter.com/ninja_muffin99) - Programmer of fnf
- [PhantomArcade3K](https://twitter.com/phantomarcade3k) - Animator of fnf
- [Evilsk8r](https://twitter.com/evilsk8r)  - Artist of fnf


# Building
THESE INSTRUCTIONS ARE FOR COMPILING THE GAME'S SOURCE CODE!!!
IF YOU JUST WANT TO PLAY AND NOT EDIT THE CODE CLICK [HERE](https://gamebanana.com/mods/326036)!!!

### Installing the Required Programs

First, you need to install Haxe and HaxeFlixel. I'm too lazy to write and keep updated with that setup (which is pretty simple). 
1. [Install Haxe](https://haxe.org/download/)
2. [Install HaxeFlixel](https://haxeflixel.com/documentation/install-haxeflixel/) after downloading Haxe (This is a required step and compilation will fail if it isn't installed!)

You'll also need to install a couple things that involve Gits. To do this, you need to do a few things first.
1. Download [git-scm](https://git-scm.com/downloads). Works for Windows, and Mac, just select your build. (Linux users can install the git package via their respective package manager.)
2. Run [this](https://github.com/Manux123/FNF-Cool-Engine/blob/master/Installation_of_the_Haxe_and_APIStuff_libraries.bat), and everything should be installed automatically
if it doesnt use the errors to download the left libraries

You should have everything ready for compiling the game! Follow the guide below to continue!

NOTE: If you see any messages relating to deprecated packages, ignore them. They're just warnings that don't affect compiling

The -debug flag is completely optional.
Applying it will make a folder called `export/debug/[TARGET]/bin` instead of `export/release/[TARGET]/bin`
