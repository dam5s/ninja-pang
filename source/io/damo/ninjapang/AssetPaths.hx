package io.damo.ninjapang;

#if FLX_UNIT_TEST
@:build(flixel.system.FlxAssets.buildFileReferences("../assets", true))
#else
@:build(flixel.system.FlxAssets.buildFileReferences("assets", true))
#end

class AssetPaths {}
