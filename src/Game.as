package 
{
	public class Game extends Control
	{
		public var _snake:Array = new Array();
		public var _snakeItem:snakeItem = new snakeItem();
		public var speed:int = 10;
		public var vx:int = 1;
		public var vy:int = 0;
		public var bodyPart:snakeItem;
		
		public function Game()
		{
			this._snake.push(this._snakeItem);
		}
			
		public function headMove():void
		{
			this._snakeItem.x += this.vx * this.speed;
			this._snakeItem.y += this.vy * this.speed;
		}
		
		public function snakeMove():void
		{
			for (var i:int = this._snake.length - 1; i > 0; --i) {
				this._snake[i].x = this._snake[i-1].x;
				this._snake[i].y = this._snake[i-1].y;
			}
		}
		
		public function addSnakeItem():void
		{
			this.bodyPart = new snakeItem();
			this.bodyPart.x = this._snake[this._snake.length - 1].x;
			this.bodyPart.y = this._snake[this._snake.length - 1].y;
			this._snake.push(this.bodyPart);
		}
		
		public function changeWay():void
		{
			switch (this.snakeDirection) {
				case "left":
					if (this.vx != 1) {
						this.vx = -1;
						this.vy = 0;
					}
					break;
				
				case "right":
					if (this.vx != -1) {
						this.vx = 1;
						this.vy = 0;
					}
					break;
				
				case "up":
					if (this.vy != 1) {
						this.vx = 0;
						this.vy = -1;
					}
					break;
				
				case "down":
					if (this.vy != -1) {
						this.vx = 0;
						this.vy = 1;
					}
					break;
			}
		}
	}
}