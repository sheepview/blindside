/*
  OptionDialog.java
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

import java.awt.*;
import java.awt.event.*;

public class OptionDialog extends Dialog
{
    private Object selected = null;
    private Button focused = null;

    public OptionDialog(Frame parent, String title)
    {
	super(parent, title, true);
    }

    public OptionDialog(Dialog parent, String title)
    {
	super(parent, title, true);
    }

    public OptionDialog(Frame parent, Object message, String title,
			Object[] selectionValues,
			Object initialSelection)
    {
	super(parent, title, true);
	init(message, selectionValues, initialSelection);
    }
    
    public OptionDialog(Dialog parent, Object message, String title,
			Object[] selectionValues,
			Object initialSelection)
    {
	super(parent, title, true);
	init(message, selectionValues, initialSelection);
    }
    
    protected void init(Object message, Object[] selectionValues,
			Object initialSelection)
    {
	Panel topPan = new Panel(new GridLayout(0, 1));
	
	if (message instanceof Component) {
	    topPan.add((Component)message);
	} else {
	    topPan.add(new Label(message.toString()));
	}
	
	add(topPan, BorderLayout.CENTER);
	
	Panel pan = new Panel();
	
	for (int i=0; i < selectionValues.length; i++) {
	    final Object sel = selectionValues[i];
	    final int curSel = i;

	    if (sel instanceof Component) {
		pan.add((Component)sel);
	    } else {
		Button btn = new Button(sel.toString());
		
		if (sel == initialSelection) {
		    focused = btn;
		}
		
		btn.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
			    selected = sel;
			    hide();
			}
		    });
		pan.add(btn);
	    }
	}
	
	addWindowListener(new WindowAdapter() {
		public void windowClosing(WindowEvent e) {
		    hide();
		}
		public void windowOpened(WindowEvent e) {
		    if (focused != null) {
			focused.requestFocus();
		    }
		}
	    });
	
	add(pan, BorderLayout.SOUTH);
	selected = null;
    }
    
    public Object showConfirmDialog(Object message, Object[] selectionValues,
				    Object initialSelection)
    {
	init(message, selectionValues, initialSelection);

	pack();
	show();
	//	dispose();
	
	return selected;
    }
}
