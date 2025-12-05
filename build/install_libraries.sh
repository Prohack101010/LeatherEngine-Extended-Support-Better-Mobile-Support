#! /bin/sh

echo Installing all required libraries.

haxelib update haxelib --global --quiet
haxelib install format --quiet
haxelib install hxp --quiet
haxelib git lime https://github.com/Prohack101010/lime_le --quiet --skip-dependencies
haxelib git openfl https://github.com/swordcubes-grave-of-shite/openfl --quiet --skip-dependencies
haxelib git flixel https://github.com/swordcubes-grave-of-shite/flixel dev --quiet --skip-dependencies
haxelib git flixel-addons https://github.com/swordcubes-grave-of-shite/flixel-addons dev --quiet --skip-dependencies
haxelib git flixel-ui https://github.com/swordcubes-grave-of-shite/flixel-ui dev --quiet --skip-dependencies
haxelib git linc_luajit https://github.com/Leather128/linc_luajit.git --quiet
haxelib git hscript-improved https://github.com/CodenameCrew/hscript-improved fe673c21b278819805aaa730216ec527c2507443 --quiet
haxelib git scriptless-polymod https://github.com/Vortex2Oblivion/scriptless-polymod --quiet
haxelib git hxNoise https://github.com/whuop/hxNoise --quiet
haxelib git hxvlc https://github.com/Vortex2Oblivion/hxvlc --quiet
haxelib install hxdiscord_rpc --quiet --skip-dependencies
haxelib git fnf-modcharting-tools https://github.com/Vortex2Oblivion/FNF-Modcharting-Tools --quiet
haxelib git flxanimate https://github.com/Vortex2Oblivion/flxanimate --quiet
haxelib git thx.core https://github.com/fponticelli/thx.core --quiet
haxelib git thx.semver https://github.com/fponticelli/thx.semver.git --quiet
haxelib git grig.audio https://github.com/FunkinCrew/grig.audio refactor/fft-cam-version --quiet
haxelib git funkin.vis https://github.com/FunkinCrew/funkVis --quiet
haxelib git jsonpath https://github.com/EliteMasterEric/jsonpath --quiet
haxelib git jsonpatch https://github.com/EliteMasterEric/jsonpatch --quiet --skip-dependencies
haxelib install hxcpp-debug-server --quiet
haxelib install hxgamemode --quiet
haxelib install mobile-controls --quiet
haxelib install flixel-perspective --quiet
haxelib install extension-androidtools --quiet --skip-dependencies
haxelib git hxcpp https://github.com/CodenameCrew/cne-hxcpp --quiet

echo Finished
