			class Drag: ExileAbstractAction
			{
				title = "Drag";
				condition = "(player distance ExileClientInteractionObject < 5 and !(alive ExileClientInteractionObject))";
				action = "_this spawn H8_DragAction";
			};	

