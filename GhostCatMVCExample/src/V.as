package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import ghostcat.mvc.GhostCatMVC;
	
	[V(name="test")]
	public class V extends Sprite
	{
		public var textField:TextField;
		public function V()
		{
			GhostCatMVC.instance.register(this);
			
			textField = new TextField();
			textField.text = "0";
			addChild(textField);
			
			addEventListener(MouseEvent.CLICK,clickHandler);
		}
		
		public function clickHandler(event:MouseEvent):void
		{
			GhostCatMVC.instance.call("test","c","execute",textField.text);
		}
		
		public function setText(v:String):void
		{
			textField.text = v;
		}
	}
}