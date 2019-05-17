package
{
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	public class Control
	{
		public var snakeDirection:String = "";
		
		public function onKeyDown(event:KeyboardEvent):void
		{
			switch (event.keyCode) {
				case Keyboard.LEFT:
					this.snakeDirection = "left";
					break;
				
				case Keyboard.RIGHT:
					this.snakeDirection = "right";
					break;
				
				case Keyboard.UP:
					this.snakeDirection = "up";
					break;
				
				case Keyboard.DOWN:
					this.snakeDirection = "down";
					break;
			}
		}
		
		public function onClick(event:MouseEvent):void
		{
			switch (event.target.name) {
				case "instance7":
					this.snakeDirection = "up";
					break;
				
				case "instance10":
					this.snakeDirection = "down";
					break;
				
				case "instance16":
					this.snakeDirection = "left";
					break;
				
				case "instance13":
					this.snakeDirection = "right";
					break;
			}
		}
	}
}