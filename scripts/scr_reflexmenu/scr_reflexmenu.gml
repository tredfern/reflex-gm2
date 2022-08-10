///
/// A basic menu implementation
///

function ReflexMenuOption(_props) : ReflexControl("menu_option", _props) constructor {
	addChild(new ReflexText({ text: text, styles: "menu_option_text" }));	
}

function ReflexMenu(_props, _children) : ReflexControl("menu", _props, _children) constructor {
	
	
}