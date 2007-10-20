/*
  Sound.java
  Copyright (C) 2004-2005  Mikael Magnusson <mikma@users.sourceforge.net>
  
  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version.
  
  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.
  
  You should have received a copy of the GNU General Public License
  along with this program; if not, write to the Free Software
  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

package net.sourceforge.iaxclient;
import java.io.IOException;
import java.io.File;
import java.io.DataInputStream;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.StringTokenizer;

public class Sound {
    public final int SAMPLE_RATE = 8000;

    private short[] data;
    private int repeat;
    private int id;

    public Sound(short[] data, int repeat) {
	this.data = data;
	this.repeat = repeat;
	this.id = -1;
    }

    public Sound(short[] data) {
	this(data, 1);
    }

    public Sound() {
	this(null, 1);
    }

    public void init(String tonelist)
    {
	// FIXME

// The tonelist itself is defined by a sequence of elements, seperated by ,'s.
// Each element consist of a frequency (f) with a possible frequency attached
// (f1+f2) to it. Behind the frequency there is an optional duration, in
// milliseconds. If the element starts with a !, that element is NOT repeat,
// so only if all elements start with !, the tonelist is time-limited, all
// others will repeat indefinitly.
//
// In tech-talk:
//   tonelist = element[,element]*
//   element = [!]freq[+freq2][/duration]

	class Tone {
	    boolean exclam;
	    int freq;
	    int freq2;
	    int duration;

	    Tone(boolean exclam, int freq, int freq2, int duration)
	    {
		this.exclam = exclam;
		this.freq = freq;
		this.freq2 = freq2;
		this.duration = duration;
	    }
	}

	StringTokenizer st = new StringTokenizer(tonelist);
	ArrayList tones = new ArrayList();

	while (st.hasMoreTokens()) {
	    String element = st.nextToken(",");
	    int length = element.length();

	    boolean exclam = false;
	    int freq = 0;
	    int freq2 = 0;
	    int duration = -1;

	    int idx1 = element.lastIndexOf('/');
	    if (idx1 >= 0) {
		String durationstr = element.substring(idx1+1,length);
		duration = Integer.parseInt(durationstr);
	    } else {
		idx1 = length;
	    }

	    int idx2 = element.lastIndexOf('+');
	    if (idx2 >= 0) {
		String freq2str = element.substring(idx2+1,idx1);
		freq2 = Integer.parseInt(freq2str);
	    } else {
		idx2 = idx1;
	    }

	    int idx3 = 0;
	    if (element.charAt(0) == '!') {
		exclam = true;
		idx3 = 1;
	    }

	    String freqstr = element.substring(idx3,idx2);
	    freq = Integer.parseInt(freqstr);

	    trace("Ind:" + exclam + ","
		  + freq + "," + freq2 + "," + duration);

	    Tone tone = new Tone(exclam, freq, freq2, duration);
	   
	    if (duration != -1) {
		tones.add(tone);
	    }
	}

	int duration = 0;
	for (Iterator iter = tones.iterator(); iter.hasNext();) {
	    Tone tone = (Tone) iter.next();

	    duration += tone.duration;
	}

	int len = (int)(duration * SAMPLE_RATE / 1000);

	data = new short[len];

	trace("len:" + len);

	int pos = 0;
	for (Iterator iter = tones.iterator(); iter.hasNext();) {
	    Tone tone = (Tone) iter.next();

	    trace("pos:" + pos);

	    pos += set(pos, tone.freq, tone.freq2,
		       (double)tone.duration / 1000);
	}
    }

    public int set(int pos, double freq, double freq2, double duration)
    {
	int len = (int)(duration * SAMPLE_RATE);
	int attackLen = (int)(0.01 * SAMPLE_RATE);
	int releaseLen = (int)(0.02 * SAMPLE_RATE);
	int releasePos = len - releaseLen;
	double maxValue = Short.MAX_VALUE * 0.8;
	double releaseStep = maxValue / releaseLen;
	double attackStep = maxValue / attackLen;
	double ampl = 0;

	for (int i = 0; i < len; i++) {
	    if (i < attackLen) {
		ampl += attackStep;
	    } else if (i > releasePos) {
		ampl -= releaseStep;
	    }

	    if (freq2 == 0) {
		if (freq == 0) {
		    data[i + pos] = 0;
		} else {
		    data[i + pos] =
			(short)(ampl * 
				Math.sin(freq * Math.PI * i / SAMPLE_RATE));
		}
	    } else {
		data[i + pos] =
		    (short)(ampl * 0.5 *  
			    ( Math.sin(freq * Math.PI * i / SAMPLE_RATE) +
			      Math.sin(freq2 * Math.PI * i / SAMPLE_RATE)));
	    }
	}

	return len;
    }

    // Frequencies in Herz and duration in Sec.
    public void init(double freq1, double freq2,
		     double duration, double proc) {
	if (proc > 1) {
	    proc = 1;
	}

	int len = (int)(duration * SAMPLE_RATE);
	int onLen = (int)(len * proc);

	data = new short[len];

	for (int i = 0; i < onLen; i++) {
	    data[i] =
		(short)(Short.MAX_VALUE * 0.8 * 
			( 0.5 * Math.sin(freq1 * Math.PI * i / SAMPLE_RATE) +
			  0.5 * Math.sin(freq2 * Math.PI * i / SAMPLE_RATE)));
	}

	for (int i = onLen; i < len; i++) {
	    data[i] = 0;
	}
    }

    public static Sound load(String filename) throws IOException
    {
	return load(new File(filename));
    }

    public static Sound load(File file) throws IOException
    {
	int len = (int)file.length();
	short[] data = new short[len];

	FileInputStream is = new FileInputStream(file);
	DataInputStream ds = new DataInputStream(is);

	for (int i = 0; i < len / 2; i++) {
	    data[i] = ds.readShort();
	}
	
	Sound sound = new Sound(data, 1);
	return sound;
    }

    public void setData(short[] data) {
	this.data = data;
    }
    
    public short[] getData() { return data; }

    public void setRepeat(int repeat) {
	this.repeat = repeat;
    }

    public int getRepeat() { return repeat; }

    protected void setId(int id) { this.id = id; }

    protected int getId() { return id; }

    public void trace(String str) {
	//System.out.println(str);
    }
}
