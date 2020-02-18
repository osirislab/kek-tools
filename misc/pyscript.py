import frida
import sys
import json

SCRIPT = """
var mallocPtr = Module.findExportByName("/system/lib/libc.so", "malloc");
var malloc = new NativeFunction(mallocPtr, 'pointer', ['int']);

Interceptor.replace(mallocPtr, new NativeCallback(function(size) {
  send(size);
  return 0;
}, 'pointer', ['int']))
"""

"""
Interceptor.attach(Module.findExportByName("/system/lib/libc.so", "malloc"), {
  onEnter: function(args) {
    send(args[0].toInt32());
    args[0] = ptr("0");
  },
  //onLeave: function(retval) {
  //  retval.replace(0);
  //}
});
"""

#Doesn't crash. Maybe works.
# SCRIPT = """

# Interceptor.attach(Module.findExportByName("libwhatsapp.so", "Java_com_whatsapp_voipcalling_Voip_rejectCall"), {
#     onEnter: function(args) {
#         send(args[0]);
#     }
# });
# """

# SCRIPT = """
# Process.enumerateModulesSync()
#     .filter(function(m){ return m['path'].toLowerCase().indexOf('app') !=-1 ; })
#     .forEach(function(m) {
#         send(JSON.stringify(m, null, '  '));
#         // to list exports use Module.enumerateExportsSync(m.name)
#         Module.enumerateExportsSync(m.name)
#         .forEach(function(e) {
#             send(JSON.stringify(e, null, ' '));
#         });
#     });
# """

# SCRIPT = """
# var mName = 'app_process64';
# Module.enumerateExportsSync(mName)
#   .filter(function(e) {
#     var fromTypeFunction = e.type == 'function';
#     return fromTypeFunction;
#   })
#   .forEach(function(e) {
#     Interceptor.attach(Module.findExportByName(mName, e.name), {
#       onEnter: function(args) {
#         send(JSON.stringify(e, null, ' '));
#       }
#     })
#   })
# """

# #Dump all loaded classes
# DUMP_LOADED_CLASSES = """
# setImmediate(function() {
#     Java.perform(function() {
#         var classNames = '';
#         var counter = 0;
#         Java.enumerateLoadedClasses(
#         {
#             onMatch: function(className)
#             {
#                 var item = Java.use(className);

#                 classNames = classNames.concat('\\n', className);
#                 counter = counter + 1;
#                 if (counter >= 10) {
#                     send(classNames);
#                     counter = 0;
#                     classNames = '';
#                 }
#             },
#             onComplete:function() {}
#         });
#         send(classNames);
#     });
# });
# """

# HOOK_PACKAGE_INFO = """

# Java.perform(function() {
#     Java.enumerateLoadedClasses(
#     {
#         onMatch: function(className)
#         {
#             if (className == "android.content.pm.PackageInfo") {
#                 var item = Java.use(className);

#                 item.getInstance.overload(
#             }
#         }
#     });
# });

# """

# SCRIPT2 = """
# Java.enumerateLoadedClasses(
# {
#   onMatch: function(className)
#   {
#     if(className == "java.security.KeyPairGenerator")
#     {
#       var item = Java.use(className);

#       console.log("the PrivateKey class was just loaded");
#       item.getInstance.overload('java.lang.String').implementation = function(str)
#       {
#         console.log("[*] This got called ");
#         var ret = item.getInstance(str);
#         console.log("[*] return value4: "+retval);
#         return retval;
#       }
#     }
#   },
#   onComplete:function(){}
# });
# """

# #Works
# SCRIPT2 = "send(1337);"

session = frida.get_usb_device().attach("com.android.chrome")
script = session.create_script(SCRIPT)

def on_message(message, data):
    try:
        print(message['payload'])
    except:
        print("Non payload {}".format(message))
    # if message['type'] == 'send':
    #     payload = json.loads(message['payload'])
    #     print(payload)
        # if "type" in payload:
        #     print("\tAddress: {}\tType: {}\tName: {}".format(payload['address'], payload['type'], payload['name']))
        # else:
        #     print('\nPath: {}'.format(payload['path']))
        #     print("Base: {}\tName: {}".format(payload['base'], payload['name']))

script.on('message', on_message)
script.load()
sys.stdin.read()
