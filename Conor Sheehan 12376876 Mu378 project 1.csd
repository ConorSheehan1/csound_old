<CsoundSynthesizer>
<CsOptions>
</CsOptions>
<CsInstruments>
sr = 44100
kr = 4410
nchnls = 2
0dbfs = 1

;riser
instr 1
;for expon istart, idur, iend can't use 0!
ksig expon 0.1, p3, 1
kratio line 0.5, p3, 2
iskiptime = 0
iloop = 1
asignal diskin2 "harpsc2.wav", kratio *p4, iskiptime, iloop
;a1[a2]ifilcod, kratio, [iskiptime], [iloop]
outs (asignal*ksig)/2, (asignal*ksig)/2
endin

;laser
instr 2
ksig expon 0.1, p3, 1
kratio line 5, p3, 2
iskiptime = 0
iloop = 2
asignal diskin2 "harpsc2.wav", kratio *p4, iskiptime, iloop
outs (asignal*ksig)/2, (asignal*ksig)/2
endin

;bass
instr 3
kratio = 0.5
iskiptime = 1
iloop = 2
asignal diskin2 "harpsc2.wav", kratio *p4, iskiptime, iloop
outs asignal/2, asignal/2
endin

;reverse
instr 4
kratio = 0.5
iskiptime = 1
iloop = 4
asignal diskin2 "harpsc2.wav", kratio *p4, iskiptime, iloop
outs asignal/2, asignal/2
endin

;noise
instr 5
ksig expon 0.1, p3, 1
kratio line 1, p3, 4 
iskiptime = 0
iloop = 1
asignal diskin2 "harpsc2.wav", kratio*p4, iskiptime, iloop
outs (asignal*ksig)/2, (asignal*ksig)/2
endin

;Reverb Bell (sine wave, freq offset p4)
instr 6
kvol      line 1, p3, 0.001 
kfreq     cpsmidinn (p5)
;			    amp    freq    table(0=sine) phase[0-1]
asound1 poscil kvol, p4*kfreq 
kfrq    port 100, 0.004, 20000
;lowpass filter keep!
a1      butterlp asound1, kfrq
a2      linseg 0, 0.003, 1, 0.01, 0.7, 0.005, 0, 1, 0
aL, aR  reverbsc a1, a2, 0.85, 12000, sr, 0.5, 1
outs (a1 + aL)/4, (a2 + aR)/4
endin

;Flooper downlifter
instr 7
;flooper2 kamp, kpitch, kloopstart, kloopend, kcrossfade, ifn [,istart, imode, ifenv, iskip]
;imode = 0(normal) 1(backwards) 2(back and forth)
klin line 0.5, p3, 0
kamp = 1
kpitch linseg 1, p3/10, 1, (p3/10)*9, 0
kloopstart = 0.4
kloopend = 0.8
kcrossfade = 0.2
ifn = 1
kamp2 = 1
kmod2 = 10
kmod poscil kamp2, kmod2
asignal flooper2 ((kamp+kmod)*klin)/4, kpitch, kloopstart, kloopend, kcrossfade, ifn
outs asignal, asignal
endin


;///////Drums/////////////////////////////////////////////////////////////////////////
;kick
instr 10
kvol      line 1, p3, 0.001 
kfreq     line 1, p3, 0.1
;			    amp    freq    table(0=sine) phase[0-1]
asound1 poscil kvol, p4*kfreq 
outs asound1/2, asound1/2
endin

;click
instr 11
kvol expon 2, p3, 0.000001
kratio = 1000
iskiptime = 0
iloop = 0
aclick diskin2 "harpsc2.wav", kratio, iskiptime, iloop
outs (aclick*kvol)/2, (aclick*kvol)/2
endin

;snare
instr 12
iskiptime = 0
iloop = 1
kratio = 10000
kvol expon 1, p3, 0.01
asnare diskin2 "harpsc2.wav", kratio, iskiptime, iloop
outs asnare*kvol,asnare*kvol
endin

;bouncy bell
instr 13
ksig expon 1, p3, 0.0001
kratio = 100
iskiptime = 0
iloop = 1
asignal diskin2 "harpsc2.wav", kratio, iskiptime, iloop
outs asignal*ksig, asignal*ksig
endin

</CsInstruments>
<CsScore>

;noise intro
;		Star	Dur	   Kratio
t 0 128
i5		0		8		6000 
s

;rising lasers
t 0 128 
i1		0		8		0.5

i2		0		1		1
i2		+		1		1.1
i2		+		1		1.2
i2		+		1		1.3
i2		+		1		1.4
i2		+		1		1.5
i2		+		1		1.6
i2		+		1		1.7

i5		0 		1		6000
i5		+		1		6000
i5		+		1		6000
i5		+		1		6000
i5		+		1		6000
i5		+		1		7000
i5		+		1		8000
i5		+		1		9000
s

;drum w/ lasers pewpew
r4
t 0 128
i1		0		1		1 

i2		0		1		1
i2		+		1		1
i2		+		1		1
i2		+		1		1
i2		+		1		1
i2		+		1		1
i2		+		1		1
i2		+		1		1

i3		0		1		1
i3		+		1		1
i3		+		1		0
i3		+		1		1
i3		+		1		0
i3		+		1		1
i3		+		1		1
i3		+		1		0

i4		 0	   8	   -1

i10     0	   1    110
i10     +	   1    110
i10     +	   1    110
i10     +	   1    110
i10     +	   1    110
i10     +	   1    110
i10     +	   1    110
i10     +	   1    110  

i11     1     1       
i11     2.5   1 
i11     5     1       
i11     6.5   1 

i12     1     1      
i12     2.7   1
i12     5     1      
i12     6.7   1

i13     3.5   1
s

;bass break
r2 
t 0 128 
i1     0     0.5     1

i3     0     1       1
i3     +     1       2
i3     2.5   1       0
i3     +     1       1
i3     4.0   1       0
i3     +     1       1
i3     +     1       0.5
i3     +     1       2

i4     2     2      -2
s 

;drum break
t 0 128
; bell  start  dur   Freqoffset  midinn
i6      3.5    4     35          32

i10     0      2     110
i10     1.5    1     110
i10     2.5    1     110

i11     0     1
i11     +     1
i11     +     1
i11     +     1
i11     +     1
i11     +     1
i11     +     1
i11     +     1

i12     3     2 
s

t 0 128
i6      2      4     35     32

i10     0      2     110
i10     1.5    1     110
i10     2.5    1     110
i10     6.5    1     110

i11     0     1
i11     +     1
i11     +     1
i11     +     1
i11     +     1
i11     +     1
i11     +     1
i11     +     1

i12     3     2 
s

r2
t 0 128
i6      3.5    4     35    32

i10     0      2     110
i10     1.5    1     110
i10     2.25   1     110
i10     2.5    1     110
i10     5.5    1     110
i10     5.75   1     110
i10     6.5    1     110

i11     0     1
i11     +     1
i11     +     1
i11     +     1
i11     +     1
i11     +     1
i11     +     1
i11     +     1
s

;reverb bell, reversed bass and kick
t 0 128 
i4		0	   8		-1

i6     0      1     35    32
i6     +      1     35    35
i6     +      1     35    28
i6     +      1     35    25

i6     +      1     35    30
i6     +      1     35    25
i6     +      1     35    28
i6     +      1     35    20

i10     0      2     110
i10     1.5    1     110
i10     2.5    1     110
i10     6.5    1     110
s

t 0 128
i4		0	   8		-1.5

i6     0      1     35    32
i6     +      1     35    35
i6     +      1     35    28
i6     +      1     35    25

i6     +      1     35    30
i6     +      1     35    25
i6     +      1     35    30
i6     +      1     35    25

i10     0      2     110
i10     1.5    1     110
i10     2.5    1     110
i10     6.5   1     110
s

t 0 128
i4		0		4		-1.8
i4		+		4		-1.8

i6     0      1     35    32
i6     +      1     35    35
i6     +      1     35    28
i6     +      1     35    25

i6     +      1     35    30
i6     +      1     35    25
i6     +      1     35    28
i6     +      1     35    20

i10     0      2     110
i10     1.5    1     110
i10     2.5    1     110
i10     6.5    1     110
s

t 0 128
i4		0		2		-1.9
i4		+		2		-1.9
i4		+		2		-2
i4		+		2		-2

i6     0      1     35    32
i6     +      1     35    35
i6     +      1     35    28
i6     +      1     35    25

i6     +      1     35    30
i6     +      1     35    25
i6     +      1     35    28
i6     +      1     35    20

i10     0      2     110
i10     1.5    1     110
i10     2.5    1     110
i10     6.5    1     110
s

;repeat with full drums
t 0 128
i4		0		2		-1
i4		+		2		-1
i4		+		2		-1
i4		+		2		-1

i6     0      1     35    32
i6     +      1     35    35
i6     +      1     35    28
i6     +      1     35    25

i6     +      1     35    30
i6     +      1     35    25
i6     +      1     35    28
i6     +      1     35    20

i10     0	   1    110
i10     +	   1    110
i10     +	   1    110
i10     +	   1    110
i10     +	   1    110
i10     +	   1    110
i10     +	   1    110
i10     +	   1    110  

i11     1     1       
i11     2.5   1 
i11     5     1       
i11     6.5   1 

i12     1     1      
i12     2.7   1
i12     5     1      
i12     6.7   1

i13     3.5   1
s

t 0 128
i4		0      2		-1.5
i4		+      2		-1.5
i4		+      2		-1.5
i4		+      2		-1.5

i6     0      1     35    32
i6     +      1     35    35
i6     +      1     35    28
i6     +      1     35    25

i6     +      1     35    30
i6     +      1     35    25
i6     +      1     35    30
i6     +      1     35    25

i10     0	   1    110
i10     +	   1    110
i10     +	   1    110
i10     +	   1    110
i10     +	   1    110
i10     +	   1    110
i10     +	   1    110
i10     +	   1    110  

i11     1     1       
i11     2.5   1 
i11     5     1       
i11     6.5   1 

i12     1     1      
i12     2.7   1
i12     5     1      
i12     6.7   1

i13     3.5   1
s

t 0 128
i4		0		2		-1.8
i4		2.5		1.5		-1.8
i4		+		2		-1.8
i4		3.5		2		-1.8
i4		+		2		-1.8

i6     0      1     35    32
i6     +      1     35    35
i6     +      1     35    28
i6     +      1     35    25

i6     +      1     35    30
i6     +      1     35    25
i6     +      1     35    28
i6     +      1     35    20

i10     0	   1    110
i10     +	   1    110
i10     +	   1    110
i10     +	   1    110
i10     +	   1    110
i10     +	   1    110
i10     +	   1    110
i10     +	   1    110  

i11     1     1       
i11     2.5   1 
i11     5     1       
i11     6.5   1 

i12     1     1      
i12     2.7   1
i12     5     1      
i12     6.7   1

i13     3.5   1
s

t 0 128
i4		0		2		-1.9
i4		2.5		1.5		-1.9
i4		4   	1		-2
i4		4.5		1.5		-2
i4		4       1      -2
i4		5.5		1.5		-2
i4      6       2      -2

i6     0      1     35    32
i6     +      1     35    35
i6     +      1     35    28
i6     +      1     35    25
				
i6     +      1     35    30
i6     +      1     35    28
i6     +      1     35    30
i6     +      1     35    25

i10     0	   1    110
i10     +	   1    110
i10     +	   1    110
i10     +	   1    110
i10     +	   1    110
i10     +	   1    110
i10     +	   1    110
i10     +	   1    110  

i11     1     1       
i11     2.5   1 
i11     5     1       
i11     6.5   1 

i12     1     1      
i12     2.7   1
i12     5     1      
i12     6.7   1

i13     3.5   1
s

t 0 128
i6      0     1     35    25

i13     1     1
i13     +     1
i13     +     1

i11     4     1
i11     +     1
i11     +     1
i11     +     1
s

t 0 128
;end with flooper downlifter
;table start size  gen  file in csd directory   skiptime  format   channel
f1     0     0      1    "harpsc2.wav"              0         0         1

i6     0      1     35    13

i7     0     16
s

</CsScore>
</CsoundSynthesizer>
<bsbPanel>
 <label>Widgets</label>
 <objectName/>
 <x>100</x>
 <y>100</y>
 <width>320</width>
 <height>240</height>
 <visible>true</visible>
 <uuid/>
 <bgcolor mode="nobackground">
  <r>255</r>
  <g>255</g>
  <b>255</b>
 </bgcolor>
</bsbPanel>
<bsbPresets>
</bsbPresets>
<MacGUI>
ioView nobackground {65535, 65535, 65535}
</MacGUI>
