/*
Copyright (c) 2007 FlexMDI Contributors.  See:
    http://code.google.com/p/flexmdi/wiki/ProjectContributors

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/


package flexmdi.containers
{
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	import flexmdi.events.MDIWindowEvent;
	import flexmdi.managers.MDIManager;
	
	import mx.collections.ArrayCollection;
	import mx.containers.Panel;
	import mx.controls.Button;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	import mx.managers.CursorManager;
	
	
	//--------------------------------------
	//  Events
	//--------------------------------------
	
	/**
	 *  Dispatched when the minimize button is clicked.
	 *
	 *  @eventType flexmdi.events.MDIWindowEvent.MINIMIZE
	 */
	[Event(name="minimize", type="mdi.events.MDIWindowEvent")]
	
	/**
	 *  If the window is minimized, this event is dispatched when the titleBar is clicked. 
	 * 	If the window is maxmimized, this event is dispatched upon clicking the restore button
	 *  or double clicking the titleBar.
	 *
	 *  @eventType flexmdi.events.MDIWindowEvent.RESTORE
	 */
	[Event(name="restore", type="mdi.events.MDIWindowEvent")]
	
	/**
	 *  Dispatched when the maximize button is clicked or when the window is in a
	 *  normal state (not minimized or maximized) and the titleBar is double clicked.
	 *
	 *  @eventType flexmdi.events.MDIWindowEvent.MAXIMIZE
	 */
	[Event(name="maximize", type="mdi.events.MDIWindowEvent")]
	
	/**
	 *  Dispatched when the close button is clicked.
	 *
	 *  @eventType flexmdi.events.MDIWindowEvent.CLOSE
	 */
	[Event(name="close", type="mdi.events.MDIWindowEvent")]
	
	/**
	 *  Dispatched when the window gains focus and is given topmost z-index of MDIManager's children.
	 *
	 *  @eventType flexmdi.events.MDIWindowEvent.FOCUS_START
	 */
	[Event(name="focusStart", type="mdi.events.MDIWindowEvent")]
	
	/**
	 *  Dispatched when the window loses focus and no longer has topmost z-index of MDIManager's children.
	 *
	 *  @eventType flexmdi.events.MDIWindowEvent.FOCUS_END
	 */
	[Event(name="focusEnd", type="mdi.events.MDIWindowEvent")]
	
	/**
	 *  Dispatched when the window starts being dragged.
	 *
	 *  @eventType flexmdi.events.MDIWindowEvent.DRAG_START
	 */
	[Event(name="dragStart", type="mdi.events.MDIWindowEvent")]
	
	/**
	 *  Dispatched while the window is being dragged.
	 *
	 *  @eventType flexmdi.events.MDIWindowEvent.DRAG
	 */
	[Event(name="drag", type="mdi.events.MDIWindowEvent")]
	
	/**
	 *  Dispatched when the window stops being dragged.
	 *
	 *  @eventType flexmdi.events.MDIWindowEvent.DRAG_END
	 */
	[Event(name="dragEnd", type="mdi.events.MDIWindowEvent")]
	
	/**
	 *  Dispatched when a resize handle is pressed.
	 *
	 *  @eventType flexmdi.events.MDIWindowEvent.RESIZE_START
	 */
	[Event(name="resizeStart", type="mdi.events.MDIWindowEvent")]
	
	/**
	 *  Dispatched while the mouse is down on a resize handle.
	 *
	 *  @eventType flexmdi.events.MDIWindowEvent.RESIZE
	 */
	[Event(name="resize", type="mdi.events.MDIWindowEvent")]
	
	/**
	 *  Dispatched when the mouse is released from a resize handle.
	 *
	 *  @eventType flexmdi.events.MDIWindowEvent.RESIZE_END
	 */
	[Event(name="resizeEnd", type="mdi.events.MDIWindowEvent")]
	
	
	/**
	 * Central window class used in flexmdi. Includes min/max/close buttons by default.
	 */
	public class MDIWindow extends Panel
	{
		/**
	     * @private
	     */
	    private static const DEFAULT_EDGE_HANDLE_SIZE:Number = 4;
	    
	    /**
	     * @private
	     */
		private static const DEFAULT_CORNER_HANDLE_SIZE:Number = 10;
	    
	    /**
	     * @private
	     * Internal storage for windowState property.
	     */
		private var _windowState:int;
		
		/**
	     * @private
	     * Internal storage of previous state, used in min/max/restore logic.
	     */
		private var _prevWindowState:int;
		
		/**
	     * @private
	     * Parent of window controls (min, restore/max and close buttons).
	     */
		private var controlsHolder:UIComponent;
		
		/**
		 * @private
		 * Flag to determine whether or not close button is visible.
		 */
		private var _showCloseButton:Boolean = true;
		
		/**
		 * Array of controlsHolder's child components.
		 */
		public var controls:Array;
		
		/**
		 * Minimize window button.
		 */
		public var minimizeBtn:Button;
		
		/**
		 * Maximize/restore window button.
		 */
		public var maximizeRestoreBtn:Button;
		
		/**
		 * Close window button.
		 */
		public var closeBtn:Button;
		
		/**
		 * Height of window when minimized.
		 */
		public var minimizeHeight:Number;
		
		/**
		 * Flag determining whether or not this window is resizable.
		 */
		public var resizable:Boolean;
		
		/**
	     * @private
	     * Resize handle for top edge of window.
	     */
		private var resizeHandleTop:Button;
		
		/**
	     * @private
	     * Resize handle for right edge of window.
	     */
		private var resizeHandleRight:Button;
		
		/**
	     * @private
	     * Resize handle for bottom edge of window.
	     */
		private var resizeHandleBottom:Button;
		
		/**
	     * @private
	     * Resize handle for left edge of window.
	     */
		private var resizeHandleLeft:Button;
		
		/**
	     * @private
	     * Resize handle for top left corner of window.
	     */
		private var resizeHandleTL:Button;
		
		/**
	     * @private
	     * Resize handle for top right corner of window.
	     */
		private var resizeHandleTR:Button;
		
		/**
	     * @private
	     * Resize handle for bottom right corner of window.
	     */
		private var resizeHandleBR:Button;
		
		/**
	     * @private
	     * Resize handle for bottom left corner of window.
	     */
		private var resizeHandleBL:Button;		
		
		/**
		 * Resize handle currently in use.
		 */
		private var currentResizeHandle:Button;
		
		/**
	     * Rectangle to represent window's size and position when resize begins
	     * or window's size/position is saved.
	     */
		public var savedWindowRect:Rectangle;
		
		/**
		 * @private
		 * Flag used to intelligently dispatch drag related events
		 */
		private var _dragging:Boolean;
		
		/**
		 * @private
	     * Mouse's x position when resize begins.
	     */
		private var dragStartMouseX:Number;
		
		/**
		 * @private
	     * Mouse's y position when resize begins.
	     */
		private var dragStartMouseY:Number;
		
		/**
		 * @private
	     * Maximum allowable x value for resize. Used to enforce minWidth.
	     */
		private var dragMaxX:Number;
		
		/**
		 * @private
	     * Maximum allowable x value for resize. Used to enforce minHeight.
	     */
		private var dragMaxY:Number;
		
		/**
		 * @private
	     * Amount the mouse's x position has changed during current resizing.
	     */
		private var dragAmountX:Number;
		
		/**
		 * @private
	     * Amount the mouse's y position has changed during current resizing.
	     */
		private var dragAmountY:Number;
		
		/**
	     * Window's context menu.
	     */
		public var winContextMenu:ContextMenu = null;
		
		/**
		 * Reference to MDIManager instance this window is managed by, if any.
	     */
		public var windowManager:MDIManager;
		
		[Embed(source="/flexmdi/assets/img/resizeCursorV.gif")]
		private var resizeCursorV:Class;
		[Embed(source="/flexmdi/assets/img/resizeCursorH.gif")]
		private var resizeCursorH:Class;
		[Embed(source="/flexmdi/assets/img/resizeCursorTLBR.gif")]
		private var resizeCursorTLBR:Class;
		[Embed(source="/flexmdi/assets/img/resizeCursorTRBL.gif")]
		private var resizeCursorTRBL:Class;
		
		/**
		 * Constructor
	     */
		public function MDIWindow()
		{
			super();
			controls = new Array();
			doubleClickEnabled = true;
			minWidth = 200;
			minHeight = 200;
			windowState = MDIWindowState.NORMAL;
			resizable = true;
			styleName = "mdiWindowFocus";
			
			addEventListener(FlexEvent.CREATION_COMPLETE, componentComplete);			
		}
		
		/**
		 * @private
		 */
		private function componentComplete(event:FlexEvent):void
		{
			minimizeHeight = this.titleBar.height;
		}
		
		/**
		 * Create resize handles and window controls.
		 */
		override protected function createChildren():void
		{
			super.createChildren();
			
			// edges
			if(!resizeHandleTop)
			{
				resizeHandleTop = new Button();
				resizeHandleTop.x = MDIWindow.DEFAULT_CORNER_HANDLE_SIZE * .5;
				resizeHandleTop.y = -(MDIWindow.DEFAULT_EDGE_HANDLE_SIZE * .5);
				resizeHandleTop.height = MDIWindow.DEFAULT_EDGE_HANDLE_SIZE;
				resizeHandleTop.alpha = 0;
				resizeHandleTop.focusEnabled = false;
				rawChildren.addChild(resizeHandleTop);
			}
			
			if(!resizeHandleRight)
			{
				resizeHandleRight = new Button();
				resizeHandleRight.y = MDIWindow.DEFAULT_CORNER_HANDLE_SIZE * .5;
				resizeHandleRight.width = MDIWindow.DEFAULT_EDGE_HANDLE_SIZE;
				resizeHandleRight.alpha = 0;
				resizeHandleRight.focusEnabled = false;
				rawChildren.addChild(resizeHandleRight);
			}
			
			if(!resizeHandleBottom)
			{
				resizeHandleBottom = new Button();
				resizeHandleBottom.x = MDIWindow.DEFAULT_CORNER_HANDLE_SIZE * .5;
				resizeHandleBottom.height = MDIWindow.DEFAULT_EDGE_HANDLE_SIZE;
				resizeHandleBottom.alpha = 0;
				resizeHandleBottom.focusEnabled = false;
				rawChildren.addChild(resizeHandleBottom);
			}
			
			if(!resizeHandleLeft)
			{
				resizeHandleLeft = new Button();
				resizeHandleLeft.x = -(MDIWindow.DEFAULT_EDGE_HANDLE_SIZE * .5);
				resizeHandleLeft.y = MDIWindow.DEFAULT_CORNER_HANDLE_SIZE * .5;
				resizeHandleLeft.width = MDIWindow.DEFAULT_EDGE_HANDLE_SIZE;
				resizeHandleLeft.alpha = 0;
				resizeHandleLeft.focusEnabled = false;
				rawChildren.addChild(resizeHandleLeft);
			}
			
			// corners
			if(!resizeHandleTL)
			{
				resizeHandleTL = new Button();
				resizeHandleTL.x = resizeHandleTL.y = -(MDIWindow.DEFAULT_CORNER_HANDLE_SIZE * .3);
				resizeHandleTL.width = resizeHandleTL.height = MDIWindow.DEFAULT_CORNER_HANDLE_SIZE;
				resizeHandleTL.alpha = 0;
				resizeHandleTL.focusEnabled = false;
				rawChildren.addChild(resizeHandleTL);
			}
			
			if(!resizeHandleTR)
			{
				resizeHandleTR = new Button();
				resizeHandleTR.width = resizeHandleTR.height = MDIWindow.DEFAULT_CORNER_HANDLE_SIZE;
				resizeHandleTR.alpha = 0;
				resizeHandleTR.focusEnabled = false;
				rawChildren.addChild(resizeHandleTR);
			}
			
			if(!resizeHandleBR)
			{
				resizeHandleBR = new Button();
				resizeHandleBR.width = resizeHandleBR.height = MDIWindow.DEFAULT_CORNER_HANDLE_SIZE;
				resizeHandleBR.alpha = 0;
				resizeHandleBR.focusEnabled = false;
				rawChildren.addChild(resizeHandleBR);
			}
			
			if(!resizeHandleBL)
			{
				resizeHandleBL = new Button();
				resizeHandleBL.width = resizeHandleBL.height = MDIWindow.DEFAULT_CORNER_HANDLE_SIZE;
				resizeHandleBL.alpha = 0;
				resizeHandleBL.focusEnabled = false;
				rawChildren.addChild(resizeHandleBL);
			}
			
			// controls			
			if(controls.length == 0)
			{
				minimizeBtn = new Button();
				minimizeBtn.width = 10;
				minimizeBtn.height = 10;
				minimizeBtn.styleName = "minimizeBtn";
				controls.push(minimizeBtn);
				
				maximizeRestoreBtn = new Button();
				maximizeRestoreBtn.width = 10;
				maximizeRestoreBtn.height = 10;
				maximizeRestoreBtn.styleName = "increaseBtn";
				controls.push(maximizeRestoreBtn);
				
				closeBtn = new Button();
				closeBtn.width = 10;
				closeBtn.height = 10;
				closeBtn.styleName = "closeBtn";
				closeBtn.visible = showCloseButton;
				controls.push(closeBtn);				
			}
			
			controlsHolder = new UIComponent();
			rawChildren.addChild(controlsHolder);
			
			for(var i:int = 0; i < controls.length; i++)
			{
				var control:UIComponent = controls[i];
				
				control.x = this.width - ((controls.length - i) * 20);
				control.y = (titleBar.height - control.height) / 2;
				control.buttonMode = true;
				controlsHolder.addChild(control);
			}
			
			addListeners();
		}		
		
		/**
		 * Position resize handles and window controls.
		 */
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			// edges
			resizeHandleTop.width = this.width - MDIWindow.DEFAULT_CORNER_HANDLE_SIZE;
			
			resizeHandleRight.x = this.width - MDIWindow.DEFAULT_EDGE_HANDLE_SIZE * .5;
			resizeHandleRight.height = this.height - MDIWindow.DEFAULT_CORNER_HANDLE_SIZE;
			
			resizeHandleBottom.y = this.height - MDIWindow.DEFAULT_EDGE_HANDLE_SIZE * .5;
			resizeHandleBottom.width = this.width - MDIWindow.DEFAULT_CORNER_HANDLE_SIZE;
			
			resizeHandleLeft.height = this.height - MDIWindow.DEFAULT_CORNER_HANDLE_SIZE;
			
			// corners			
			resizeHandleTR.x = this.width - MDIWindow.DEFAULT_CORNER_HANDLE_SIZE * .7;
			resizeHandleTR.y = -(MDIWindow.DEFAULT_CORNER_HANDLE_SIZE * .3);
			
			resizeHandleBR.x = this.width - MDIWindow.DEFAULT_CORNER_HANDLE_SIZE * .7;
			resizeHandleBR.y = this.height - MDIWindow.DEFAULT_CORNER_HANDLE_SIZE * .7;
			
			resizeHandleBL.x = -(MDIWindow.DEFAULT_CORNER_HANDLE_SIZE * .3);
			resizeHandleBL.y = this.height - MDIWindow.DEFAULT_CORNER_HANDLE_SIZE * .7;
			
			// position window controls
			var visibleControls:Array = new Array();
			
			for(var i:int = 0; i < controlsHolder.numChildren; i++)
			{
				var control:UIComponent = controlsHolder.getChildAt(i) as UIComponent;
				if(control.visible)
				{
					visibleControls.push(control);
				}
			}
			
			for(i = 0; i < visibleControls.length; i++)
			{
				control = visibleControls[i] as UIComponent;
				
				control.x = this.width - ((visibleControls.length - i) * 20);
				control.y = (titleBar.height - control.height) / 2;
			}
		}
		
		public function get showCloseButton():Boolean
		{
			return _showCloseButton;
		}
		
		public function set showCloseButton(value:Boolean):void
		{
			_showCloseButton = value;
			if(closeBtn)
			{
				closeBtn.visible = value;
				invalidateDisplayList();
			}
		}
		
		/**
		 * Add listeners for resize handles and window controls.
		 */
		private function addListeners():void
		{
			// edges
			resizeHandleTop.addEventListener(MouseEvent.ROLL_OVER, onResizeButtonRollOver, false, 0, true);
			resizeHandleTop.addEventListener(MouseEvent.ROLL_OUT, onResizeButtonRollOut, false, 0, true);
			resizeHandleTop.addEventListener(MouseEvent.MOUSE_DOWN, onResizeButtonPress, false, 0, true);
			
			resizeHandleRight.addEventListener(MouseEvent.ROLL_OVER, onResizeButtonRollOver, false, 0, true);
			resizeHandleRight.addEventListener(MouseEvent.ROLL_OUT, onResizeButtonRollOut, false, 0, true);
			resizeHandleRight.addEventListener(MouseEvent.MOUSE_DOWN, onResizeButtonPress, false, 0, true);
			
			resizeHandleBottom.addEventListener(MouseEvent.ROLL_OVER, onResizeButtonRollOver, false, 0, true);
			resizeHandleBottom.addEventListener(MouseEvent.ROLL_OUT, onResizeButtonRollOut, false, 0, true);
			resizeHandleBottom.addEventListener(MouseEvent.MOUSE_DOWN, onResizeButtonPress, false, 0, true);
			
			resizeHandleLeft.addEventListener(MouseEvent.ROLL_OVER, onResizeButtonRollOver, false, 0, true);
			resizeHandleLeft.addEventListener(MouseEvent.ROLL_OUT, onResizeButtonRollOut, false, 0, true);
			resizeHandleLeft.addEventListener(MouseEvent.MOUSE_DOWN, onResizeButtonPress, false, 0, true);
			
			// corners
			resizeHandleTL.addEventListener(MouseEvent.ROLL_OVER, onResizeButtonRollOver, false, 0, true);
			resizeHandleTL.addEventListener(MouseEvent.ROLL_OUT, onResizeButtonRollOut, false, 0, true);
			resizeHandleTL.addEventListener(MouseEvent.MOUSE_DOWN, onResizeButtonPress, false, 0, true);
			
			resizeHandleTR.addEventListener(MouseEvent.ROLL_OVER, onResizeButtonRollOver, false, 0, true);
			resizeHandleTR.addEventListener(MouseEvent.ROLL_OUT, onResizeButtonRollOut, false, 0, true);
			resizeHandleTR.addEventListener(MouseEvent.MOUSE_DOWN, onResizeButtonPress, false, 0, true);
			
			resizeHandleBR.addEventListener(MouseEvent.ROLL_OVER, onResizeButtonRollOver, false, 0, true);
			resizeHandleBR.addEventListener(MouseEvent.ROLL_OUT, onResizeButtonRollOut, false, 0, true);
			resizeHandleBR.addEventListener(MouseEvent.MOUSE_DOWN, onResizeButtonPress, false, 0, true);
			
			resizeHandleBL.addEventListener(MouseEvent.ROLL_OVER, onResizeButtonRollOver, false, 0, true);
			resizeHandleBL.addEventListener(MouseEvent.ROLL_OUT, onResizeButtonRollOut, false, 0, true);
			resizeHandleBL.addEventListener(MouseEvent.MOUSE_DOWN, onResizeButtonPress, false, 0, true);
			
			// titleBar
			titleBar.addEventListener(MouseEvent.MOUSE_DOWN, onTitleBarPress, false, 0, true);
			titleBar.addEventListener(MouseEvent.MOUSE_UP, onTitleBarRelease, false, 0, true);
			titleBar.addEventListener(MouseEvent.DOUBLE_CLICK, maximizeRestore, false, 0, true);
			titleBar.addEventListener(MouseEvent.CLICK, unMinimize, false, 0, true);
			
			// window controls
			if(minimizeBtn)
			{
				minimizeBtn.addEventListener(MouseEvent.CLICK, minimize, false, 0, true);
			}
			if(maximizeRestoreBtn)
			{
				maximizeRestoreBtn.addEventListener(MouseEvent.CLICK, maximizeRestore, false, 0, true);
			}
			if(closeBtn)
			{
				closeBtn.addEventListener(MouseEvent.CLICK, close, false, 0, true);
			}
			
			// clicking anywhere brings window to front
			this.addEventListener(MouseEvent.MOUSE_DOWN, bringToFront);
		}
		
		/**
		 * Bring this window to front of parent's child list. Called automatically by clicking on window.
		 * Can be called manually by developer.
		 */
		public function bringToFront(event:Event = null):void
		{
			var indexToCheck:int;
			if(event != null && event.type == "newWindow")
			{
				indexToCheck = parent.numChildren - 2;
			}
			else
			{
				indexToCheck = parent.numChildren - 1;
			}
			
			for each(var win:MDIWindow in windowManager.windowList)
			{
				if(win != this && win.parent.getChildIndex(win) == indexToCheck)
				{
					win.dispatchEvent(new MDIWindowEvent(MDIWindowEvent.FOCUS_END, win));
				}
			}
			if(parent.getChildIndex(this) != parent.numChildren - 1)
			{
				parent.setChildIndex(this, parent.numChildren - 1);
				dispatchEvent(new MDIWindowEvent(MDIWindowEvent.FOCUS_START, this));
			}
		}
		
		/**
		 *  Minimize the window.
		 */
		public function minimize(event:MouseEvent = null):void
		{
			// if the panel is floating, save its state
			if(windowState == MDIWindowState.NORMAL)
			{
				savePanel();
			}
			_prevWindowState = windowState;
			dispatchEvent(new MDIWindowEvent(MDIWindowEvent.MINIMIZE, this));
			windowState = MDIWindowState.MINIMIZED;
			showControls = false;
		}
		
		
		/**
		 *  Called from maximize/restore button 
		 * 
		 *  @event MouseEvent (optional)
		 */
		public function maximizeRestore(event:MouseEvent = null):void
		{
			if(maximizeRestoreBtn.styleName == "increaseBtn")
			{
				savePanel();
				maximize();
			}
			else
			{
				maximizeRestoreBtn.styleName = "increaseBtn";
				windowState = MDIWindowState.NORMAL;
				dispatchEvent(new MDIWindowEvent(MDIWindowEvent.RESTORE, this));
			}
		}
		
		/**
		 * Maximize the window.
		 */
		public function maximize():void
		{
			showControls = true;
			windowState = MDIWindowState.MAXIMIZED;
			maximizeRestoreBtn.styleName = "decreaseBtn";
			dispatchEvent(new MDIWindowEvent(MDIWindowEvent.MAXIMIZE, this));
		}
		
		/**
		 * Close the window.
		 */
		public function close(event:MouseEvent = null):void
		{
			dispatchEvent(new MDIWindowEvent(MDIWindowEvent.CLOSE, this));
		}
		
		/**
		 * Save the panel's floating coordinates.
		 * 
		 * @private
		 */
		private function savePanel():void
		{
			savedWindowRect = new Rectangle(this.x, this.y, this.width, this.height);
		}
		
		/**
		 * Not fully supported yet. Should be made public once it is.
		 * 
		 * @private
		 */
		private function addControl(uic:UIComponent, index:int = -1):void
		{
			uic.buttonMode = true;
			if(index > -1)
			{
				controlsHolder.addChildAt(uic, index);
			}
			else
			{
				controlsHolder.addChild(uic);
			}
			invalidateDisplayList();
		}
		
		/**
		 * Title bar dragging.
		 * 
		 * @private
		 */
		private function onTitleBarPress(event:MouseEvent):void
		{
			if(this.windowState != MDIWindowState.MINIMIZED)
			{
				this.startDrag(false, new Rectangle(0, 0, parent.width - this.width, parent.height - this.height - 5));
				systemManager.addEventListener(MouseEvent.MOUSE_UP, onTitleBarRelease);
				systemManager.addEventListener(MouseEvent.MOUSE_MOVE, onWindowMove);
				systemManager.stage.addEventListener(Event.MOUSE_LEAVE, onTitleBarRelease, false, 0, true);
			}
		}
		
		private function onWindowMove(event:MouseEvent):void
		{
			if(!_dragging)
			{
				_dragging = true;
				dispatchEvent(new MDIWindowEvent(MDIWindowEvent.DRAG_START, this));
			}
			dispatchEvent(new MDIWindowEvent(MDIWindowEvent.DRAG, this));
		}
		
		private function onTitleBarRelease(event:Event):void
		{
			this.stopDrag();
			if(_dragging)
			{
				_dragging = false;
				dispatchEvent(new MDIWindowEvent(MDIWindowEvent.DRAG_END, this));
			}
			systemManager.removeEventListener(MouseEvent.MOUSE_UP, onTitleBarRelease);
			systemManager.removeEventListener(MouseEvent.MOUSE_MOVE, onWindowMove);
			systemManager.stage.removeEventListener(Event.MOUSE_LEAVE, onTitleBarRelease);
		}
		
		/**
		 * Restore window to state it was in prior to being minimized.
		 */
		public function unMinimize(event:MouseEvent = null):void
		{
			if(minimized)
			{
				showControls = true;
				
				windowState = _prevWindowState;
				if(windowState == MDIWindowState.NORMAL)
				{
					dispatchEvent(new MDIWindowEvent(MDIWindowEvent.RESTORE, this));
				}
				else
				{
					dispatchEvent(new MDIWindowEvent(MDIWindowEvent.MAXIMIZE, this));
				}
			}
		}
		
		/**
		 * Mouse down on any resize handle.
		 */
		private function onResizeButtonPress(event:MouseEvent):void
		{
			if(!minimized && resizable)
			{
				currentResizeHandle = event.target as Button;
				setCursor(currentResizeHandle);
				dragStartMouseX = parent.mouseX;
				dragStartMouseY = parent.mouseY;
				savedWindowRect = new Rectangle(this.x, this.y, this.width, this.height);
				
				dragMaxX = savedWindowRect.x + (savedWindowRect.width - minWidth);
				dragMaxY = savedWindowRect.y + (savedWindowRect.height - minHeight);
				
				systemManager.addEventListener(Event.ENTER_FRAME, onResizeButtonDrag, false, 0, true);
				systemManager.addEventListener(MouseEvent.MOUSE_UP, onResizeButtonRelease, false, 0, true);
				systemManager.stage.addEventListener(Event.MOUSE_LEAVE, onMouseLeaveStage, false, 0, true);
				dispatchEvent(new MDIWindowEvent(MDIWindowEvent.RESIZE_START, this));
			}
		}
		
		/**
		 * Mouse move while mouse is down on a resize handle
		 */
		private function onResizeButtonDrag(event:Event):void
		{
			if(!minimized && resizable)
			{
				dragAmountX = parent.mouseX - dragStartMouseX;
				dragAmountY = parent.mouseY - dragStartMouseY;
				
				if(currentResizeHandle == resizeHandleTop && parent.mouseY > 0)
				{
					this.y = Math.min(this.parent.mouseY, dragMaxY);
					this.height = Math.max(savedWindowRect.height - dragAmountY, minHeight);
				}
				else if(currentResizeHandle == resizeHandleRight && parent.mouseX < parent.width)
				{
					this.width = Math.max(this.mouseX, minWidth);
				}
				else if(currentResizeHandle == resizeHandleBottom && parent.mouseY < parent.height)
				{
					this.height = Math.max(parent.mouseY - this.y, minHeight);
				}
				else if(currentResizeHandle == resizeHandleLeft && parent.mouseX > 0)
				{
					this.x = Math.min(this.parent.mouseX, dragMaxX);
					this.width = Math.max(savedWindowRect.width - dragAmountX, minWidth);
				}
				else if(currentResizeHandle == resizeHandleTL && parent.mouseX > 0 && parent.mouseY > 0)
				{
					this.x = Math.min(this.parent.mouseX, dragMaxX);
					this.y = Math.min(this.parent.mouseY, dragMaxY);
					this.width = Math.max(savedWindowRect.width - dragAmountX, minWidth);
					this.height = Math.max(savedWindowRect.height - dragAmountY, minHeight);				
				}
				else if(currentResizeHandle == resizeHandleTR && parent.mouseX < parent.width && parent.mouseY > 0)
				{
					this.y = Math.min(this.parent.mouseY, dragMaxY);
					this.width = Math.max(this.mouseX, minWidth);
					this.height = Math.max(savedWindowRect.height - dragAmountY, minHeight);
				}
				else if(currentResizeHandle == resizeHandleBR && parent.mouseX < parent.width && parent.mouseY < parent.height)
				{
					this.width = Math.max(this.mouseX, minWidth);
					this.height = Math.max(this.mouseY, minHeight);
				}
				else if(currentResizeHandle == resizeHandleBL && parent.mouseX > 0 && parent.mouseY < parent.height)
				{
					this.x = Math.min(this.parent.mouseX, dragMaxX);
					this.width = Math.max(savedWindowRect.width - dragAmountX, minWidth);
					this.height = Math.max(this.mouseY, minHeight);
				}
				dispatchEvent(new MDIWindowEvent(MDIWindowEvent.RESIZE, this));
			}
		}
		
		private function onResizeButtonRelease(event:MouseEvent = null):void
		{
			if(!minimized && resizable)
			{
				currentResizeHandle = null;
				systemManager.removeEventListener(Event.ENTER_FRAME, onResizeButtonDrag);
				systemManager.removeEventListener(MouseEvent.MOUSE_UP, onResizeButtonRelease);
				systemManager.stage.removeEventListener(Event.MOUSE_LEAVE, onMouseLeaveStage);
				CursorManager.removeCursor(CursorManager.currentCursorID);
				dispatchEvent(new MDIWindowEvent(MDIWindowEvent.RESIZE_END, this));
			}
		}
		
		private function onMouseLeaveStage(event:Event):void
		{
			onResizeButtonRelease();
			systemManager.stage.removeEventListener(Event.MOUSE_LEAVE, onMouseLeaveStage);
		}
		
		private function setCursor(target:Button):void
		{
			var cursorClass:Class;
			
			if(target == resizeHandleTop || target == resizeHandleBottom)
			{
				cursorClass = resizeCursorV;
			}
			else if(target == resizeHandleRight || target == resizeHandleLeft)
			{
				cursorClass = resizeCursorH;
			}
			else if(target == resizeHandleTL || target == resizeHandleBR)
			{
				cursorClass = resizeCursorTLBR;
			}
			else if(target == resizeHandleTR || target == resizeHandleBL)
			{
				cursorClass = resizeCursorTRBL;
			}
			
			CursorManager.removeCursor(CursorManager.currentCursorID);
			CursorManager.setCursor(cursorClass, 2, -10, -10);
		}
		
		private function onResizeButtonRollOver(event:MouseEvent):void
		{
			// event.buttonDown is to detect being dragged over
			if(!minimized && resizable && !event.buttonDown)
			{
				setCursor(event.target as Button);
			}
		}
		
		private function onResizeButtonRollOut(event:MouseEvent):void
		{
			if(!event.buttonDown)
			{
				CursorManager.removeCursor(CursorManager.currentCursorID);
			}
		}
		
		public function set showControls(value:Boolean):void
		{
			controlsHolder.visible = value;
		}
		
		private function get windowState():int
		{
			return _windowState;
		}
		
		private function set windowState(newState:int):void
		{
			_prevWindowState = _windowState;
			_windowState = newState;
			
			updateContextMenu(_windowState);
		}
		
		public function get minimized():Boolean
		{
			return _windowState == MDIWindowState.MINIMIZED;
		}
		
		public function get maximized():Boolean
		{
			return _windowState == MDIWindowState.MAXIMIZED;
		}
		
		public function updateContextMenu(currentState:int):void
		{
			var defaultContextMenu : ContextMenu = new ContextMenu();
				defaultContextMenu.hideBuiltInItems();
			
			var minimizeItem:ContextMenuItem = new ContextMenuItem("Minimize");
		  		minimizeItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
		  		minimizeItem.enabled = currentState != MDIWindowState.MINIMIZED;
		  		defaultContextMenu.customItems.push(minimizeItem);	
			
			var maximizeItem:ContextMenuItem = new ContextMenuItem("Maximize");
		  		maximizeItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
		  		maximizeItem.enabled = currentState != MDIWindowState.MAXIMIZED;
		  		defaultContextMenu.customItems.push(maximizeItem);	
			
			var restoreItem:ContextMenuItem = new ContextMenuItem("Restore");
		  		restoreItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
		  		restoreItem.enabled = currentState != MDIWindowState.NORMAL;
		  		defaultContextMenu.customItems.push(restoreItem);	
			
			var closeItem:ContextMenuItem = new ContextMenuItem("Close");
		  		closeItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
		  		defaultContextMenu.customItems.push(closeItem);  
	

			var arrangeItem:ContextMenuItem = new ContextMenuItem("Auto Arrange");
				arrangeItem.separatorBefore = true;
		  		arrangeItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);	
		  		defaultContextMenu.customItems.push(arrangeItem);

       	 	var arrangeFillItem:ContextMenuItem = new ContextMenuItem("Auto Arrange Fill");
		  		arrangeFillItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);  	
		  		defaultContextMenu.customItems.push(arrangeFillItem);   
               	
            var cascadeItem:ContextMenuItem = new ContextMenuItem("Cascade");
		  		cascadeItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
		  		defaultContextMenu.customItems.push(cascadeItem);                     	
			
			var showAllItem:ContextMenuItem = new ContextMenuItem("Show All Windows");
		  		showAllItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
		  		defaultContextMenu.customItems.push(showAllItem);  
			
        	this.contextMenu = defaultContextMenu;
		}
		
		private function menuItemSelectHandler(event:ContextMenuEvent):void
		{
			switch(event.target.caption)
			{
				case("Minimize"):
					minimize();
				break;
				
				case("Maximize"):
					maximize();
				break;
				
				case("Restore"):
					if(this.windowState == MDIWindowState.MINIMIZED)
					{
						unMinimize();
					}
					else if(this.windowState == MDIWindowState.MAXIMIZED)
					{
						maximizeRestore();
					}	
				break;
				
				case("Close"):
					close();
				break;
				
				case("Auto Arrange"):
					this.windowManager.tile(false, this.windowManager.tilePadding);
				break;
				
				case("Auto Arrange Fill"):
					this.windowManager.tile(true, this.windowManager.tilePadding);
				break;
				
				case("Cascade"):
					this.windowManager.cascade();
				break;
				
				case("Show All Windows"):
					this.windowManager.showAllWindows();
				break;

			}
		}
	}
}