<CsoundSynthesizer>
<CsInstruments>
sr = 44100 
ksmps = 32 
0dbfs = 1 
nchnls = 2

;initialise global
gaverb init 0

instr 1
;input values
kselect invalue "select"
ktime invalue "time"
kfine invalue "pitch"
kcoarse invalue "pitch coarse"
kolaps invalue "olaps" 
kgrsize init 1
kgrsize invalue "size"
kgrsizecoarse  invalue "size coarse"
kamp invalue "amp"
kfreq = kolaps/kgrsize
kps = 1/kolaps
ktable invalue "table"

;filter input values
kcutoff invalue "cutoff"
kcutoff portk kcutoff, 0.001
kq invalue "q"
kq portk kq, 0.001 
;bandpass values
kwidth invalue "width"
ksep invalue "sep"

;resonator input values
kresfreq invalue "kresfreq"
kresfreq portk kresfreq, 0.001
kresbw invalue "kresbw"
kreswet invalue "kreswet"
kreswet portk kreswet, 0.001

;reverb input values
kRvbWet invalue "krvbwet"
kRvbWet portk kRvbWet, 0.001

;pan value
kpan invalue "kpan"
kpan portk kpan, 0.001


;wavetable switch
if (ktable == 0) then
asig syncgrain kamp, kfreq, kfine*kcoarse, kgrsize*kgrsizecoarse, kps*ktime, 1, 10, 30
elseif (ktable == 1) then
asig syncgrain kamp, kfreq, kfine*kcoarse, kgrsize*kgrsizecoarse, kps*ktime, 2, 10, 30
elseif (ktable == 2) then
asig syncgrain kamp, kfreq, kfine*kcoarse, kgrsize*kgrsizecoarse, kps*ktime, 3, 10, 30
elseif (ktable == 3) then
asig syncgrain kamp, kfreq, kfine*kcoarse, kgrsize*kgrsizecoarse, kps*ktime, 4, 10, 30
elseif (ktable == 4) then
asig syncgrain kamp, kfreq, kfine*kcoarse, kgrsize*kgrsizecoarse, kps*ktime, 5, 10, 30
endif


;filter switch
if(kselect == 0) then
aflt moogladder asig, kcutoff, kq 
elseif (kselect == 1) then
aflt lowpass2 asig, kcutoff, kq 
elseif (kselect == 2) then
aflt resony asig, kcutoff, kwidth, 4, ksep
endif

;balance filters
afin balance aflt, asig

;balance resonator
ares reson afin, kresfreq, kresbw
afin2 balance ares, afin
awet =(afin*1-kreswet) + (afin2*kreswet)

;verb and pan
gaverb    =         gaverb + (afin * kRvbWet)
apanL = awet * sin(kpan*$M_PI_2)
apanR = awet * cos(kpan*$M_PI_2)

kRvbDry = kRvbWet/4
outs (apanL*(1-kRvbDry))/1.2, (apanR*(1-kRvbDry))/1.2
endin 

  
instr 2
;pan value
kpan invalue "kpan"
kpan portk ((kpan/1.33)+0.25), 0.001
;change kpan range to 0.25-0.7518..

;reverb value
kfeedback		invalue "kfeedback"
kverbfilt		invalue "kverb"

;lp filter for reverb + verb
kfrq    			portk kverbfilt, 0.004
averbfilt		butterlp gaverb, kfrq
aL, aR  			reverbsc averbfilt, averbfilt, kfeedback, 12000, sr, 0.5, 1 

apanL = aL * sin(kpan*$M_PI_2)
apanR = aR * cos(kpan*$M_PI_2)
outs apanL/1.2, apanR/1.2

clear gaverb
endin


</CsInstruments>
<CsScore>

i1 0 200
i2 0 200

f1 0 0 1 "bassoonc2.wav" 0 0 0
f2 0 0 1 "flutec3.wav" 0 0 0	
f3 0 0 1 "harpsc2.wav" 0 0 0
f4 0 0 1 "pianoc2.wav" 0 0 0
f5 0 0 1 "xyloc3.wav" 0 0 0

f10   0   8192   20   2   1

</CsScore>
</CsoundSynthesizer> 
<bsbPanel>
 <label>Widgets</label>
 <objectName/>
 <x>791</x>
 <y>166</y>
 <width>987</width>
 <height>808</height>
 <visible>true</visible>
 <uuid/>
 <bgcolor mode="nobackground">
  <r>255</r>
  <g>255</g>
  <b>255</b>
 </bgcolor>
 <bsbObject version="2" type="BSBVSlider">
  <objectName>time</objectName>
  <x>91</x>
  <y>154</y>
  <width>26</width>
  <height>102</height>
  <uuid>{cc29e75a-51d3-4b6b-a2ca-879e66950718}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <minimum>0.00000000</minimum>
  <maximum>1.00000000</maximum>
  <value>0.24509804</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>-1.00000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject version="2" type="BSBVSlider">
  <objectName>amp</objectName>
  <x>39</x>
  <y>151</y>
  <width>20</width>
  <height>100</height>
  <uuid>{e0e3ab83-3d0b-4791-beea-7d97a176bbac}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <minimum>0.00000000</minimum>
  <maximum>0.10000000</maximum>
  <value>0.00000000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>-1.00000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject version="2" type="BSBVSlider">
  <objectName>pitch</objectName>
  <x>151</x>
  <y>154</y>
  <width>20</width>
  <height>100</height>
  <uuid>{888eb1a2-9088-4869-8d1d-76414a8ac1e0}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <minimum>50.00000000</minimum>
  <maximum>75.00000000</maximum>
  <value>67.25000000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>-1.00000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject version="2" type="BSBLabel">
  <objectName/>
  <x>36</x>
  <y>110</y>
  <width>39</width>
  <height>25</height>
  <uuid>{dcce668f-b876-422c-8804-163c7d91d518}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <label>amp
</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject version="2" type="BSBLabel">
  <objectName/>
  <x>133</x>
  <y>108</y>
  <width>50</width>
  <height>33</height>
  <uuid>{9089a32f-5721-44fa-9b11-9d2c0f5c36e8}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <label>pitch fine

</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject version="2" type="BSBLabel">
  <objectName/>
  <x>84</x>
  <y>109</y>
  <width>37</width>
  <height>25</height>
  <uuid>{a30568ca-27f3-4e71-a71e-cd8b99fdf6b9}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <label>time
</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject version="2" type="BSBVSlider">
  <objectName>olaps</objectName>
  <x>44</x>
  <y>327</y>
  <width>20</width>
  <height>100</height>
  <uuid>{14288c1f-944f-4e47-85aa-f76378a8bcc7}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <minimum>0.00100000</minimum>
  <maximum>1.00000000</maximum>
  <value>0.53047000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>-1.00000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject version="2" type="BSBLabel">
  <objectName/>
  <x>40</x>
  <y>286</y>
  <width>52</width>
  <height>23</height>
  <uuid>{31a3bd2e-05ab-46ce-9beb-8dfb141b8679}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <label>olaps
</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject version="2" type="BSBVSlider">
  <objectName>size</objectName>
  <x>104</x>
  <y>329</y>
  <width>20</width>
  <height>100</height>
  <uuid>{1bf7e2b9-82c2-4834-8f5f-eddcc6869fb9}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <minimum>0.00010000</minimum>
  <maximum>0.00100000</maximum>
  <value>0.00082000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>-1.00000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject version="2" type="BSBLabel">
  <objectName/>
  <x>103</x>
  <y>286</y>
  <width>53</width>
  <height>27</height>
  <uuid>{abe5764c-0cf4-4148-9891-3af18eb81d81}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <label>size
</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject version="2" type="BSBScope">
  <objectName/>
  <x>671</x>
  <y>156</y>
  <width>251</width>
  <height>154</height>
  <uuid>{9c36f623-d63c-4b0b-9d7a-f9533d42931f}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <value>-255.00000000</value>
  <type>poincare</type>
  <zoomx>2.00000000</zoomx>
  <zoomy>1.00000000</zoomy>
  <dispx>1.00000000</dispx>
  <dispy>1.00000000</dispy>
  <mode>0.00000000</mode>
 </bsbObject>
 <bsbObject version="2" type="BSBVSlider">
  <objectName>cutoff</objectName>
  <x>270</x>
  <y>156</y>
  <width>20</width>
  <height>100</height>
  <uuid>{f4630edd-68c4-44c1-ba27-48bc7666cf98}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <minimum>50.00000000</minimum>
  <maximum>20000.00000000</maximum>
  <value>5436.50000000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>-1.00000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject version="2" type="BSBLabel">
  <objectName/>
  <x>264</x>
  <y>109</y>
  <width>34</width>
  <height>24</height>
  <uuid>{59389fce-f5da-421c-8d8e-1ac7b20d9912}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <label>cutoff</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject version="2" type="BSBVSlider">
  <objectName>q</objectName>
  <x>303</x>
  <y>157</y>
  <width>20</width>
  <height>100</height>
  <uuid>{47a771d3-3c95-48a2-9bda-50834e20bb2e}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <minimum>0.00000000</minimum>
  <maximum>1.00000000</maximum>
  <value>0.23000000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>-1.00000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject version="2" type="BSBLabel">
  <objectName/>
  <x>304</x>
  <y>108</y>
  <width>21</width>
  <height>27</height>
  <uuid>{403cf0ef-a507-4c8a-b1fa-f448f60b26c6}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <label>q</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject version="2" type="BSBDropdown">
  <objectName>select</objectName>
  <x>264</x>
  <y>46</y>
  <width>138</width>
  <height>42</height>
  <uuid>{438e0dde-da83-4e72-a8af-d2a749ecb2d8}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <bsbDropdownItemList>
   <bsbDropdownItem>
    <name>Moogladder</name>
    <value>0</value>
    <stringvalue/>
   </bsbDropdownItem>
   <bsbDropdownItem>
    <name> Butterworth</name>
    <value>1</value>
    <stringvalue/>
   </bsbDropdownItem>
   <bsbDropdownItem>
    <name> bandpass</name>
    <value>2</value>
    <stringvalue/>
   </bsbDropdownItem>
  </bsbDropdownItemList>
  <selectedIndex>1</selectedIndex>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject version="2" type="BSBVSlider">
  <objectName>krvbwet</objectName>
  <x>471</x>
  <y>171</y>
  <width>20</width>
  <height>100</height>
  <uuid>{1f9287b5-b429-499e-b19f-a02501d8420d}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <minimum>0.00000000</minimum>
  <maximum>1.00000000</maximum>
  <value>0.94000000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>-1.00000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject version="2" type="BSBLabel">
  <objectName/>
  <x>449</x>
  <y>122</y>
  <width>51</width>
  <height>25</height>
  <uuid>{13e79763-e960-4662-b1a3-fdb15d3d796d}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <label>verb wet
</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject version="2" type="BSBVSlider">
  <objectName>kfeedback</objectName>
  <x>518</x>
  <y>173</y>
  <width>20</width>
  <height>100</height>
  <uuid>{5a07db7e-0116-4646-a8a3-00f89804f7bf}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <minimum>0.00000000</minimum>
  <maximum>1.00000000</maximum>
  <value>0.99000000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>-1.00000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject version="2" type="BSBLabel">
  <objectName/>
  <x>511</x>
  <y>122</y>
  <width>58</width>
  <height>26</height>
  <uuid>{95668f72-1577-473a-b1d2-c4e834166b0e}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <label>feedback
</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject version="2" type="BSBVSlider">
  <objectName>kverb</objectName>
  <x>566</x>
  <y>174</y>
  <width>20</width>
  <height>100</height>
  <uuid>{84227eec-8a55-4133-b412-74228cb1ed77}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <minimum>1000.00000000</minimum>
  <maximum>20000.00000000</maximum>
  <value>15630.00000000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>-1.00000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject version="2" type="BSBLabel">
  <objectName/>
  <x>579</x>
  <y>121</y>
  <width>80</width>
  <height>25</height>
  <uuid>{7ffbe047-31e4-4fad-a2d3-90e97c9880fc}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <label>verb filter
</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject version="2" type="BSBDropdown">
  <objectName>table</objectName>
  <x>41</x>
  <y>40</y>
  <width>150</width>
  <height>54</height>
  <uuid>{ea2e0ff6-e829-4c99-9140-a3f32c15ca55}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <bsbDropdownItemList>
   <bsbDropdownItem>
    <name>bassoonc2</name>
    <value>0</value>
    <stringvalue/>
   </bsbDropdownItem>
   <bsbDropdownItem>
    <name> flutec3</name>
    <value>1</value>
    <stringvalue/>
   </bsbDropdownItem>
   <bsbDropdownItem>
    <name> harpsc2</name>
    <value>2</value>
    <stringvalue/>
   </bsbDropdownItem>
   <bsbDropdownItem>
    <name> pianoc2</name>
    <value>3</value>
    <stringvalue/>
   </bsbDropdownItem>
   <bsbDropdownItem>
    <name> xyloc3</name>
    <value>4</value>
    <stringvalue/>
   </bsbDropdownItem>
  </bsbDropdownItemList>
  <selectedIndex>2</selectedIndex>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject version="2" type="BSBVSlider">
  <objectName>pitch coarse</objectName>
  <x>191</x>
  <y>155</y>
  <width>20</width>
  <height>100</height>
  <uuid>{f78d2020-f214-4e4d-987a-821fa8936321}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <minimum>1.00000000</minimum>
  <maximum>1000.00000000</maximum>
  <value>160.84000000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>-1.00000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject version="2" type="BSBLabel">
  <objectName/>
  <x>158</x>
  <y>289</y>
  <width>80</width>
  <height>25</height>
  <uuid>{d93741ef-f543-4b75-9bf6-ca140ef30acf}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <label>size coarse
</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject version="2" type="BSBVSlider">
  <objectName>size coarse</objectName>
  <x>167</x>
  <y>329</y>
  <width>20</width>
  <height>100</height>
  <uuid>{766e624e-5b7a-4d42-8876-4050f3068887}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <minimum>1.00000000</minimum>
  <maximum>10.00000000</maximum>
  <value>8.20000000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>-1.00000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject version="2" type="BSBLabel">
  <objectName/>
  <x>183</x>
  <y>109</y>
  <width>49</width>
  <height>29</height>
  <uuid>{86731d37-9082-4fb9-b721-7cf1dd0c925d}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <label>coarse
</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject version="2" type="BSBVSlider">
  <objectName>width</objectName>
  <x>339</x>
  <y>158</y>
  <width>20</width>
  <height>100</height>
  <uuid>{bc1cbadd-fd16-4625-8a5d-109ab5094c9e}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <minimum>10.00000000</minimum>
  <maximum>3000.00000000</maximum>
  <value>1983.40000000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>-1.00000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject version="2" type="BSBVSlider">
  <objectName>sep</objectName>
  <x>373</x>
  <y>159</y>
  <width>20</width>
  <height>100</height>
  <uuid>{dfd7484a-c2e6-4c3a-880c-b195abf7c2a9}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <minimum>0.50000000</minimum>
  <maximum>2.00000000</maximum>
  <value>1.53500000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>-1.00000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject version="2" type="BSBLabel">
  <objectName/>
  <x>332</x>
  <y>107</y>
  <width>44</width>
  <height>36</height>
  <uuid>{7ffcf5fb-6be8-4c97-b2fd-ff578eb43689}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <label>band width</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject version="2" type="BSBLabel">
  <objectName/>
  <x>381</x>
  <y>110</y>
  <width>34</width>
  <height>27</height>
  <uuid>{8be59b8d-0256-4571-a68d-d2171f44f2d5}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <label>sep
</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject version="2" type="BSBVSlider">
  <objectName>kresfreq</objectName>
  <x>531</x>
  <y>345</y>
  <width>20</width>
  <height>100</height>
  <uuid>{9d48f513-1193-49db-a61b-56a06d85f51b}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <minimum>50.00000000</minimum>
  <maximum>10000.00000000</maximum>
  <value>1045.00000000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>-1.00000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject version="2" type="BSBLabel">
  <objectName/>
  <x>509</x>
  <y>316</y>
  <width>73</width>
  <height>25</height>
  <uuid>{28045c65-76a9-4572-a89f-227fc35d6a2f}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <label>resonator freq
</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject version="2" type="BSBVSlider">
  <objectName>kresbw</objectName>
  <x>588</x>
  <y>343</y>
  <width>20</width>
  <height>100</height>
  <uuid>{8b6d94fb-e8c9-4a68-a13b-e8c9e486791f}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <minimum>20.00000000</minimum>
  <maximum>200.00000000</maximum>
  <value>97.40000000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>-1.00000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject version="2" type="BSBLabel">
  <objectName/>
  <x>584</x>
  <y>316</y>
  <width>32</width>
  <height>23</height>
  <uuid>{9b5a5b7d-66e0-4515-b8ae-7d6439eb8db9}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <label>bw
</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject version="2" type="BSBVSlider">
  <objectName>kreswet</objectName>
  <x>474</x>
  <y>343</y>
  <width>20</width>
  <height>100</height>
  <uuid>{426e924b-2923-4423-86bb-4bbdeb52e10f}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <minimum>0.00000000</minimum>
  <maximum>1.00000000</maximum>
  <value>0.00000000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>-1.00000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject version="2" type="BSBLabel">
  <objectName/>
  <x>456</x>
  <y>315</y>
  <width>52</width>
  <height>26</height>
  <uuid>{d44e0839-c170-42a8-99b5-f1bf16799129}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <label>dry wet</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject version="2" type="BSBKnob">
  <objectName>kpan</objectName>
  <x>295</x>
  <y>341</y>
  <width>80</width>
  <height>80</height>
  <uuid>{4756ee7e-9f71-4283-a9a7-f50bc1a41266}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <minimum>0.00000000</minimum>
  <maximum>1.00000000</maximum>
  <value>0.38000000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>0.01000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject version="2" type="BSBLabel">
  <objectName/>
  <x>40</x>
  <y>10</y>
  <width>80</width>
  <height>25</height>
  <uuid>{03d82ad9-2ce5-4366-aef1-d9bb18aaac07}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <label>Input sample</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>14</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject version="2" type="BSBLabel">
  <objectName/>
  <x>266</x>
  <y>15</y>
  <width>80</width>
  <height>25</height>
  <uuid>{938eb618-2700-4d64-90b3-c0d7c42240cf}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <label>Filter type</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>14</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject version="2" type="BSBLabel">
  <objectName/>
  <x>507</x>
  <y>76</y>
  <width>80</width>
  <height>25</height>
  <uuid>{4a64af45-fb60-4f67-893a-2965582e4c9f}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <label>reverb
</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>14</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject version="2" type="BSBLabel">
  <objectName/>
  <x>502</x>
  <y>284</y>
  <width>80</width>
  <height>25</height>
  <uuid>{bc0a44c6-2276-484d-8652-898931329366}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <label>resonator
</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>14</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject version="2" type="BSBLabel">
  <objectName/>
  <x>295</x>
  <y>301</y>
  <width>80</width>
  <height>25</height>
  <uuid>{c05113b9-7076-49b7-9ac9-36c1f52e289a}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <label>pan</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject version="2" type="BSBScope">
  <objectName/>
  <x>30</x>
  <y>460</y>
  <width>236</width>
  <height>150</height>
  <uuid>{ef90a64f-0eeb-4433-98fb-dbcd411b4f40}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <value>1.00000000</value>
  <type>scope</type>
  <zoomx>2.00000000</zoomx>
  <zoomy>1.00000000</zoomy>
  <dispx>1.00000000</dispx>
  <dispy>1.00000000</dispy>
  <mode>0.00000000</mode>
 </bsbObject>
 <bsbObject version="2" type="BSBScope">
  <objectName/>
  <x>391</x>
  <y>458</y>
  <width>250</width>
  <height>154</height>
  <uuid>{4c1b9335-2957-412b-9938-ddd36b7348c1}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <value>2.00000000</value>
  <type>scope</type>
  <zoomx>2.00000000</zoomx>
  <zoomy>1.00000000</zoomy>
  <dispx>1.00000000</dispx>
  <dispy>1.00000000</dispy>
  <mode>0.00000000</mode>
 </bsbObject>
</bsbPanel>
<bsbPresets>
</bsbPresets>
