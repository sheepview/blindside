/*
  Constants.java
  Copyright (C) 2004-2005  Mikael Magnusson <mikma@users.sourceforge.net>

  This library is free software; you can redistribute it and/or
  modify it under the terms of the GNU Lesser General Public
  License as published by the Free Software Foundation; either
  version 2.1 of the License, or (at your option) any later version.
  
  This library is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  Lesser General Public License for more details.
  
  You should have received a copy of the GNU Lesser General Public
  License along with this library; if not, write to the Free Software
  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307  USA
*/

package net.sourceforge.iaxclient.jni;

public interface Constants {
    /* Define audio type constants */
    int AUDIO_INTERNAL      =  0;
    int AUDIO_INTERNAL_PA   =  1;
    int AUDIO_INTERNAL_FILE =  2;
    int AUDIO_EXTERNAL      = 99;
    
    /* G.723.1 compression */
    int FORMAT_G723_1    = 1 << 0;
    /* GSM compression */
    int FORMAT_GSM       = 1 << 1;
    /* Raw mu-law data (G.711) */
    int FORMAT_ULAW      = 1 << 2;
    /* Raw A-law data (G.711) */
    int FORMAT_ALAW      = 1 << 3;
    /* ADPCM, 32kbps  */
    int FORMAT_G726      = 1 << 4;
    /* ADPCM IMA */
    int FORMAT_ADPCM     = 1 << 5;
    /* Raw 16-bit Signed Linear (8000 Hz) PCM */
    int FORMAT_SLINEAR   = 1 << 6;
    /* LPC10, 180 samples/frame */
    int FORMAT_LPC10     = 1 << 7;
    /* G.729a Audio */
    int FORMAT_G729A     = 1 << 8;
    /* Speex Audio */
    int FORMAT_SPEEX     = 1 << 9;
    /* iLBC Audio */
    int FORMAT_ILBC      = 1 << 10;
    /* Maximum audio format */
    int FORMAT_MAX_AUDIO = 1 << 15;
    /* JPEG Images */
    int FORMAT_JPEG      = 1 << 16;
    /* PNG Images */
    int FORMAT_PNG       = 1 << 17;
    /* H.261 Video */
    int FORMAT_H261      = 1 << 18;
    /* H.263 Video */
    int FORMAT_H263      = 1 << 19;
    /* H.263+ Video */
    int FORMAT_H263_PLUS = 1 << 20;
    /* MPEG4 Video */
    int FORMAT_MPEG4     = 1 << 21;
    /* H264 Video */
    int FORMAT_H264      = 1 << 23;
    /* Theora Video */
    int FORMAT_THEORA    = 1 << 24;

    int EVENT_TEXT                 = 1;
    int EVENT_LEVELS               = 2;
    int EVENT_STATE                = 3;
    int EVENT_NETSTAT              = 4;
    int EVENT_URL                  = 5;	// URL push via IAX(2)
    int EVENT_VIDEO                = 6;	// video data (pointer)
    int EVENT_REGISTRATION         = 7;

    int CALL_STATE_FREE     = 0;
    int CALL_STATE_ACTIVE   = 1<<1;
    int CALL_STATE_OUTGOING = 1<<2;
    int CALL_STATE_RINGING  = 1<<3;
    int CALL_STATE_COMPLETE = 1<<4;
    int CALL_STATE_SELECTED = 1<<5;
    int CALL_STATE_BUSY     = 1<<6;
    int CALL_STATE_TRANSFER = 1<<7;

    int TEXT_TYPE_STATUS     = 1;
    int TEXT_TYPE_NOTICE     = 2;
    int TEXT_TYPE_ERROR      = 3;
    /* FATAL ERROR: User Agent should probably display error, then die. */
    int TEXT_TYPE_FATALERROR = 4;
    int TEXT_TYPE_IAX        = 5;

    /* registration replys, corresponding to IAX_EVENTs*/
    int IAXC_REGISTRATION_REPLY_ACK     = 18;   /* IAX_EVENT_REGACC  */
    int IAXC_REGISTRATION_REPLY_REJ     = 30;   /* IAX_EVENT_REGREJ  */
    int IAXC_REGISTRATION_REPLY_TIMEOUT = 6;    /* IAX_EVENT_TIMEOUT */

    int URL_URL         = 1;       /* URL received */
    int URL_LDCOMPLETE  = 2;       /* URL loading complete */
    int URL_LINKURL     = 3;       /* URL link request */
    int URL_LINKREJECT  = 4;       /* URL link reject */
    int URL_UNLINK      = 5;       /* URL unlink */


    int EVENT_BUFSIZ      = 256;

    int IAXC_AD_INPUT           = 1<<0;
    int IAXC_AD_OUTPUT          = 1<<1;
    int IAXC_AD_RING            = 1<<2;
    int IAXC_AD_INPUT_DEFAULT   = 1<<3;
    int IAXC_AD_OUTPUT_DEFAULT  = 1<<4;
    int IAXC_AD_RING_DEFAULT    = 1<<5;
    
    int IAXC_FILTER_DENOISE     = 1<<0;
    int IAXC_FILTER_AGC         = 1<<1;
    int IAXC_FILTER_ECHO        = 1<<2;
    /* Analog (mixer-based) AGC */
    int IAXC_FILTER_AAGC        = 1<<3;
    /* Send CN frames when silence detected */
    int IAXC_FILTER_CN          = 1<<4;

    int DEFAULT_PORTNO = 4569;
}
