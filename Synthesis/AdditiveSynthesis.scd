s.reboot;


// SYNTHESIS
(
SynthDef.new(\sinusoids, {
    |
    effectBus, vol=1,
    amp0 = 1, amp1 = 0, amp2 = 0, amp3 = 0, amp4 = 0, amp5 = 0, amp6 = 0, amp7 = 0,
    atk0 = 1, atk1 = 0, atk2 = 0, atk3 = 0, atk4 = 0, atk5 = 0, atk6 = 0, atk7 = 0,
    rel0 = 1, rel1 = 0, rel2 = 0, rel3 = 0, rel4 = 0, rel5 = 0, rel6 = 0, rel7 = 0
    freq = 440, out = 0, gate = 0.0, vel = 64
    |

    var osc0, osc1, osc2, osc3;
    var sig, env;
    var amps  = [amp0, amp1, amp2, amp3, amp4, amp5, amp6, amp7];
    var rels  = [rel0, rel1, rel2, rel3, rel4, rel5, rel6, rel7];
    var atks  = [atk0, atk1, atk2, atk3, atk4, atk5, atk6, atk7];
    var freqs = [   1,    2,    3,    4,    5,    6,    7,    8];


    env = EnvGen.kr(Env.adsr(atks, 0.3, 0.5, rels), gate: gate);
    sig = Mix.ar(env * (SinOsc.ar(freq: freq * freqs, mul: amps)));
    sig = sig * vel.linexp(1, 127, 0.1, 0.9);

    Out.ar(effectBus, sig * vol);

    DetectSilence.ar(sig, amp: 0.01,time: 0.2, doneAction: Done.freeSelf);

}).send(s);


SynthDef.new(\reverb, {
    |
    inBus, mix = 0.5, room = 0.5, pan = 0
    |
    var input;

    input = In.ar(inBus, 1);
    Out.ar(0, FreeVerb.ar(input, mix, room) * (1 - pan)*0.5);
    Out.ar(1, FreeVerb.ar(input, mix, room) * (1 + pan)*0.5);
}).send(s);
)

(
s.plotTree;
// Midi Init
MIDIClient.init;
MIDIIn.connectAll;

// OSC Init
~netAddr = NetAddr("127.0.0.1", 57122);

~notes = Array.newClear(128);

b = Bus.audio(s,1);

x = Synth.new("reverb", [\inBus, b]);

)
s.plotTree



// CONTROL
(

//Note on
var noteOnFunc = {
	|veloc, num, chan, src|
	//[veloc, num].postln;

	~notes[num] = Synth.new(\sinusoids,
		[\gate, 1, \freq, num.midicps, \vel, veloc,\effectBus, b]);
};

//Note off
var noteOffFunc = {
	|veloc, num, chan, src|
	//[veloc, num].postln;
	~notes[num].set(\gate, 0);
	~notes[num] = nil;
};


// Attack Receive
var attackOSCReceive = {
	|msg|
	~notes.do({arg item, num;
		if(item != nil, {
			~notes[num].set(\atk0, msg[1], \atk1, msg[2], \atk2, msg[3], \atk3, msg[4]);
			~notes[num].set(\atk4, msg[5], \atk5, msg[6], \atk6, msg[7], \atK7, msg[8]);
		});
	});
};

// Release Receive
var releaseOSCReceive = {
	|msg|
	~notes.do({arg item, num;
		if(item != nil, {
			~notes[num].set(\rel0, msg[1], \rel1, msg[2], \rel2, msg[3], \rel3, msg[4]);
			~notes[num].set(\rel4, msg[5], \rel5, msg[6], \rel6, msg[7], \rel7, msg[8]);
		});
	});
};

// Amplitude Receive
var harmonicOSCReceive = {
	|msg|
	~notes.do({arg item, num;
		if(item != nil, {
			~notes[num].set(\amp0, msg[1], \amp1, msg[2], \amp2, msg[3], \amp3, msg[4]);
			~notes[num].set(\amp4, msg[5], \amp5, msg[6], \amp6, msg[7], \amp7, msg[8]);
		});
	});
};

var paramOSCReceive = {
	|msg|
	~notes.do({arg item, num;
		if(item != nil, {
			~notes[num].set(\vol, msg[1]);
		});
	});
	x.set(\mix, msg[2], \room, msg[3], \pan, (msg[4]*2)-1);
};



// MIDI
MIDIdef.noteOn(\noteOnPoliphony,   noteOnFunc);
MIDIdef.noteOff(\noteOffPoliphony, noteOffFunc);

// OSC in
OSCdef('AmplitudeOSCReceiver', harmonicOSCReceive, "/harmonics");
OSCdef('AttackOSCReceiver',    attackOSCReceive,   "/attack");
OSCdef('ReleaseOSCReceiver',   releaseOSCReceive,  "/release");
OSCdef('ParamOSCReceiver',     paramOSCReceive,      "/param");

SystemClock.sched(0.0, {
    ~notes.postln;
    1.0;
});

)
~netAddr  = NetAddr("25.53.229.113",  57120);

NetAddr.localAddr
