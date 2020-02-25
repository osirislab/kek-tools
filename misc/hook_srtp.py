import frida
import sys
import json
import time
from pprint import pprint

SCRIPT = """
var moduleName = "libwhatsapp.so";
var srtp_protect = 0x3F99A0;
var srtp_unprotect = 0x3F99D0; //srtp_unprotect_tramp

var baseAddr = Module.getBaseAddress(moduleName);
Interceptor.attach(baseAddr.add(srtp_protect), {
    onEnter: function(args) {
        var func_name = "srtp_protect";
        var stream_list = Memory.readPointer(args[0]);
        var stream_template = Memory.readPointer(args[0].add(4));
        var user_data = Memory.readPointer(args[0].add(8));

        var ctx = {"stream_list": stream_list, "stream_template": stream_template, "user_data": user_data};
        var rtp_hdr = Memory.readPointer(args[1]);
        var pkt_octet_len = Memory.readPointer(args[2]);
        var data = {"func": func_name, "ctx": ctx, "rtp_hdr": rtp_hdr, "pkt_octet_len": pkt_octet_len};
        send(JSON.stringify(data));
    }
});

Interceptor.attach(baseAddr.add(srtp_unprotect), {
    onEnter: function(args) {
        var func_name = "srtp_unprotect";
        var stream_list = Memory.readPointer(args[0]);
        var stream_template = Memory.readPointer(args[0].add(4));
        var user_data = Memory.readPointer(args[0].add(8));

        var ctx = {"stream_list": stream_list, "stream_template": stream_template, "user_data": user_data};
        var rtp_hdr = Memory.readPointer(args[1]);
        var pkt_octet_len = Memory.readPointer(args[2]);
        var data = {"func": func_name, "ctx": ctx, "rtp_hdr": rtp_hdr, "pkt_octet_len": pkt_octet_len};
        send(JSON.stringify(data));
    }
});
"""

# device = frida.get_device('emulator-5554')
# device.enable_spawn_gating()
# pid = device.spawn(['com.whatsapp'])
# session = device.attach(pid)
# device.resume(pid)

session = frida.get_device('emulator-5554').attach('com.whatsapp')

script = session.create_script(SCRIPT)

def on_message(message, data):
    try:
        pprint(message['payload'])
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
