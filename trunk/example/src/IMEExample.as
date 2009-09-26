package
{
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	import ghostcat.display.GSprite;
	import ghostcat.manager.RootManager;
	import ghostcat.text.IME;
	import ghostcat.ui.controls.GText;
	import ghostcat.ui.tooltip.ToolTipSkin;
	import ghostcat.util.Util;

	[SWF(width="500",height="400")]
	[Frame(factoryClass="ghostcat.ui.RootLoader")]
	/**
	 * 这是一个自制输入法例子，完全不依赖外部环境，缺陷是需要载入词库，体积不小。
	 * 可能会和系统输入法冲突，请使用ctrl+enter切换到英文输入法（不要用shift，shift同时也会将内部输入法切换到英文- -）
	 * 
	 * @author flashyiyi
	 * 
	 */
	public class IMEExample extends GSprite
	{
		[Embed(source = "pinyin.txt",mimeType="application/octet-stream")]
		public var pinyin:Class;
		public var ime:IME;
		
		public var textInput1:TextField;
		public var textInput2:TextField;
		protected override function init():void
		{
			RootManager.register(this);
			
			textInput1 = Util.createObject(TextField,{type:TextFieldType.INPUT,x:100,y:50,width:300,height:50,background:true,border:true,wordWrap:true,multiline:true}) as TextField;
			addChild(textInput1);
			
			textInput2 = Util.createObject(TextField,{type:TextFieldType.INPUT,x:100,y:250,width:300,height:50,background:true,border:true,wordWrap:true,multiline:true}) as TextField;
			addChild(textInput2);
			
			var skin:GText = new ToolTipSkin();
			addChild(skin);
			
			ime = new IME(new pinyin().toString(),skin);
			ime.register(textInput1);
			ime.register(textInput2);
		}
	}
}
