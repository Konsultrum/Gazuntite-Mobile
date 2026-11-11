package com.gazuntite.common.view.component
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.core.UITextField;
	import mx.events.FlexEvent;
	import mx.events.FlexMouseEvent;
	
	import spark.components.DateSpinner;
	import spark.components.Group;
	import spark.components.HGroup;
	import spark.components.Image;
	import spark.components.Label;
	import spark.components.PopUpAnchor;
	import spark.components.TextInput;
	import spark.formatters.DateTimeFormatter;
	
	public class FreeTextInput extends HGroup
	{
		[Embed(source="assets/images/19-check.png")]
		public static const okImage:Class;
		
		[Embed(source="assets/images/11-x.png")]
		public static const cancelImage:Class;
		
		private var _prompt:String = "Tap to enter";
		
		[Bindable]
		public function get prompt():String
		{
			return _prompt;
		}
		
		public function set prompt(value:String):void
		{
			_prompt = value;
			invalidateProperties();
		}
		
		private var _text:String = null;
		
		[Bindable]
		public function get text():String
		{
			return _text;
		}
		
		public function set text(value:String):void
		{
			_text = value;
			invalidateProperties();
		}
		
		private var _editMode:Boolean = false;
		[Bindable]
		public function get editMode():Boolean
		{
			return _editMode;
		}
		public function set editMode(value:Boolean):void
		{
			if (value!=_editMode)
			{
				_editMode = value;
				invalidateProperties();
			}
		}
		
		protected var label:Label;
		protected var textInputField:TextInput;
		protected var okButton:Image;
		protected var cancelButton:Image;
		
		public function FreeTextInput()
		{
			super();
			this.verticalAlign = 'middle';
		}
		
		protected function onLabelClick(event:MouseEvent):void
		{
			editMode = true;
			invalidateProperties();
		}
		protected override function createChildren():void
		{
			super.createChildren();
			
			// add Label
			label = new Label();
			label.addEventListener(MouseEvent.CLICK, onLabelClick, false, 0, true);
			
			this.addElement(label);
			
			// add text input
			textInputField = new TextInput();
			textInputField.percentWidth = 100;
			textInputField.visible = false;
			textInputField.includeInLayout = false;
			textInputField.addEventListener(FlexEvent.ENTER, onTextCommitt);
			this.addElement(textInputField);
			
			// added ok/cancel image buttons
			okButton = new Image();
			okButton.source = okImage;
			okButton.addEventListener(MouseEvent.CLICK, onTextCommitt);
			okButton.visible = false;
			okButton.includeInLayout = false;
			okButton.width = 32;
			this.addElement(okButton);
			
			cancelButton = new Image();
			cancelButton.source = cancelImage;
			cancelButton.addEventListener(MouseEvent.CLICK, onCancel);
			cancelButton.visible = false;
			cancelButton.includeInLayout = false;
			this.addElement(cancelButton);
		}
		
		protected function onTextInputCreated(event:FlexEvent):void
		{
			textInputField.addEventListener(FlexMouseEvent.MOUSE_DOWN_OUTSIDE, onCancel);
		}
		
		protected function onTextCommitt(event:Event):void
		{
			editMode = false;
			text = textInputField.text;
			invalidateProperties();
		}
		protected override function commitProperties():void
		{
			super.commitProperties();
			if (text!=null && text!="")
			{
				label.text = text;
				label.setStyle("fontStyle", "normal");
				label.setStyle("color", 0x0);
				if (textInputField.text!=text)
				{
					textInputField.text = text;
				}
			}
			else
			{
				label.text = prompt;
				label.setStyle("fontStyle", "italic");
				label.setStyle("color", 0x999999);
				textInputField.text = "";
			}
			label.visible = !editMode;
			label.includeInLayout = !editMode;
			textInputField.visible = editMode;
			textInputField.includeInLayout = editMode;
			okButton.visible = editMode;
			okButton.includeInLayout = editMode;
			cancelButton.visible = editMode;
			cancelButton.includeInLayout = editMode;
		}
		
		protected function onCancel(event:Event):void
		{
			editMode = false;
			text = "";
			textInputField.text = "";
			invalidateProperties();
		}
	}
}