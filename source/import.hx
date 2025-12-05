#if !macro
import Paths;
import utilities.CoolUtil;
import utilities.CoolUtil.PrintType;
import utilities.Options;

#if mobile
import mobile.*;
import mobile.objects.*;
#end

#if sys
import sys.*;
import sys.io.*;
#elseif js
import js.html.*;
#end

using StringTools;
#end
