package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import org.osmf.elements.ImageElement;

	[SWF(width="800", height="600")]
	
	public class _Snake extends Sprite
	{
		public var gameStage:Stage = stage;
		[Embed(source="eating.mp3")]
		public var soundClass:Class;
		public var eatingSound:Sound = new soundClass() as Sound;
		[Embed(source="carbon.jpg")]
		public var backgroundClass:Class;
		public var background:DisplayObject = new backgroundClass() as DisplayObject;
		public var _screen:gameScreen = new gameScreen();
		public var _food:snakeFood = new snakeFood();
		public var _scoreValue:int = 0;
		public var game:Game = new Game();
		
		public function _Snake()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			showScreen();
			showScore();
			showFood();
			game._snakeItem.x = this._screen.x + 300;
			game._snakeItem.y = this._screen.y + 300;
			stage.addChild(game._snakeItem);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN , game.onKeyDown);
			stage.addEventListener(MouseEvent.CLICK, game.onClick);
			addEventListener(Event.ENTER_FRAME , this.onEnterFrame);
			stage.addEventListener(Event.RESIZE, this.onResize);
			stage.dispatchEvent(new Event(Event.RESIZE));
			
			this.background.x = 0;
			this.background.y = 0;
			this._screen.x = 0;
			this._screen.y = 0;
		}
		
		public function showScreen():void
		{
			this.gameStage.addChild(background);
			this.gameStage.addChild(_screen);
		}
		
		public function showFood():void
		{
			this._food.x = this._screen.x + 50 + Math.random() * 500;
			this._food.y = this._screen.y + 50 + Math.random() * 500;
			this.gameStage.addChild(this._food);
		}
		
		public function showScore():void
		{
			this._screen.score.text = String(this._scoreValue);
		}
		
		public function reset():void
		{
			this.gameStage.removeChild(this._food);
			this._scoreValue = 0;
			this.showScore();
			this.showFood();
			game._snakeItem.x = this._screen.x + 300;
			game._snakeItem.y = this._screen.y + 300;
			game.vx = 1;
			game.vy = 0;
			game.snakeDirection = "";
			
			for(var i:int = game._snake.length-1; i > 0; --i){
				stage.removeChild(game._snake[i]);
				game._snake.splice(i, 1);
			}
		}
		
		public function onEnterFrame(event:Event):void
		{
			game.snakeMove();
			game.headMove();
			game.changeWay();
			
			if (game._snakeItem.x < this._screen.x + 25 || game._snakeItem.x > this._screen.x + 565 || game._snakeItem.y < this._screen.y + 25 || game._snakeItem.y > this._screen.y + 565) {
				this.reset();
			}
			
			for (var i:int = game._snake.length-1; i >= 1; --i) {
				if (game._snake[0].x == game._snake[i].x && game._snake[0].y == game._snake[i].y) {
					this.reset();
					break;
				}
			}
			
			if (game._snakeItem.hitTestObject(this._food)) {
				this.eatingSound.play();
				this._scoreValue++;
				this.gameStage.removeChild(this._food);
				this.showFood();
				game.addSnakeItem();
				stage.addChild(game.bodyPart);
				this.showScore();
			}
		}
		
		public function onResize(event:Event):void
		{
			this.background.width = stage.stageWidth;
			this.background.height = stage.stageHeight;
			
			this._screen.x = (stage.stageWidth - this._screen.width)/2;
			this._screen.y = (stage.stageHeight - this._screen.height)/2;
			
			this.gameStage.removeChild(this._food);
			this.showFood();
			game._snakeItem.x = this._screen.x + 300;
			game._snakeItem.y = this._screen.y + 300;
		}
	}
}