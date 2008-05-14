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

package flexmdi.effects
{
	import flash.geom.Point;
	
	import flexmdi.containers.MDIWindow;
	import flexmdi.effects.effectClasses.MDIGroupEffectItem;
	import flexmdi.managers.MDIManager;
	
	import mx.containers.Panel;
	import mx.effects.Effect;
	import mx.effects.Move;
	import mx.effects.Resize;
	import mx.effects.Parallel;
	import flash.geom.Rectangle;
	
	/**
	 * Base effects implementation with no animation. Extending this class means the developer
	 * can choose to implement only certain effects, rather than all required by IMDIEffectsDescriptor.
	 */
	public class MDIEffectsDescriptorBase implements IMDIEffectsDescriptor
	{
		public function getWindowAddEffect(window:MDIWindow, manager:MDIManager):Effect
		{
			return new Effect();
		}
		
		public function getWindowMinimizeEffect(window:MDIWindow, manager:MDIManager, moveTo:Point = null):Effect
		{
			var parallel:Parallel = new Parallel();
			parallel.duration = 0;
			
			var resize:Resize = new Resize(window);
			resize.widthTo = window.minWidth;
			resize.heightTo = window.minimizeHeight;
			parallel.addChild(resize);
			
			if(moveTo != null)
			{
				var move:Move = new Move(window);
				move.xTo = moveTo.x;
				move.yTo = moveTo.y;
				parallel.addChild(move);
			}
			
			return parallel;
		}
		
		public function getWindowRestoreEffect(window:MDIWindow, manager:MDIManager, restoreTo:Rectangle):Effect
		{
			var parallel:Parallel = new Parallel();
			parallel.duration = 0;
			
			var resize:Resize = new Resize(window);
			resize.widthTo = restoreTo.width;
			resize.heightTo = restoreTo.height;
			parallel.addChild(resize);
			
			var move:Move = new Move(window);
			move.xTo = restoreTo.x;
			move.yTo = restoreTo.y;
			parallel.addChild(move);
			
			return parallel;
		}
		
		public function getWindowMaximizeEffect(window:MDIWindow, manager:MDIManager, bottomOffset:Number = 0):Effect
		{
			var parallel:Parallel = new Parallel();
			parallel.duration = 0;
			
			var resize:Resize = new Resize(window);
			resize.widthTo = manager.container.width;
			resize.heightTo = manager.container.height - bottomOffset;
			parallel.addChild(resize);
			
			var move:Move = new Move(window);
			move.xTo = 0;
			move.yTo = 0;
			parallel.addChild(move);
			
			return parallel;
		}
		
		public function getWindowCloseEffect(window:MDIWindow, manager:MDIManager):Effect
		{
			// have to return something so that EFFECT_END listener will fire
			var resize:Resize = new Resize(window);
			resize.duration = 0;
			resize.widthTo = window.width;
			resize.heightTo = window.height;
			
			return resize;
		}
		
		public function getWindowFocusStartEffect(window:MDIWindow, manager:MDIManager):Effect
		{
			return new Effect();
		}
		
		public function getWindowFocusEndEffect(window:MDIWindow, manager:MDIManager):Effect
		{
			return new Effect();
		}
		
		public function getWindowDragStartEffect(window:MDIWindow, manager:MDIManager):Effect
		{
			return new Effect();
		}
		
		public function getWindowDragEffect(window:MDIWindow, manager:MDIManager):Effect
		{
			return new Effect();
		}
		
		public function getWindowDragEndEffect(window:MDIWindow, manager:MDIManager):Effect
		{
			return new Effect();
		}
		
		public function getWindowResizeStartEffect(window:MDIWindow, manager:MDIManager):Effect
		{
			return new Effect();
		}
		
		public function getWindowResizeEffect(window:MDIWindow, manager:MDIManager):Effect
		{
			return new Effect();
		}
		
		public function getWindowResizeEndEffect(window:MDIWindow, manager:MDIManager):Effect
		{
			return new Effect();
		}		
		
		public function getTileEffect(items:Array, manager:MDIManager):Effect
		{
			var parallel:Parallel = new Parallel();
			parallel.duration = 0;
			
			for each(var item:MDIGroupEffectItem  in items)
			{	
				manager.bringToFront(item.window);
				var move:Move = new Move(item.window);
					move.xTo = item.moveTo.x;
					move.yTo = item.moveTo.y;
					parallel.addChild(move);
					
				item.setWindowSize();
			}
			
			return parallel;
		}
		
		public function getCascadeEffect(items:Array, manager:MDIManager):Effect
		{
			var parallel:Parallel = new Parallel();
			parallel.duration = 0;
			
			for each(var item:MDIGroupEffectItem in items)
			{
				
				if( ! item.isCorrectPosition )
				{
					var move:Move = new Move(item.window);
						move.xTo = item.moveTo.x;
						move.yTo = item.moveTo.y;
					
					parallel.addChild(move);
				
				}
				
				if( ! item.isCorrectSize )
				{
					
					var resize:Resize = new Resize(item.window);
						resize.widthTo = item.widthTo;
						resize.heightTo = item.heightTo;
					
					parallel.addChild(resize);
						
				}
			}
			
			return parallel;
		}		
		
		public function reTileMinWindowsEffect(window:MDIWindow, manager:MDIManager, moveTo:Point):Effect
		{
			var move:Move = new Move(window);
			move.duration = 0;
			move.xTo = moveTo.x;
			move.yTo = moveTo.y;
			return move
		}	
	}
}