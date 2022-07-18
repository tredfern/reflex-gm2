


function reflex_refreshLayout() {
	for(var i = 0; i < array_length(global.reflex.rootControls); i++) {
		reflex_calculateBoxModels(global.reflex.rootControls[i]);		
	}
	
	for(var i = 0; i < array_length(global.reflex.rootControls); i++) {
		reflex_cacheBoxModels(global.reflex.rootControls[i]);
	}
}


function reflex_maxWidth(_control, _parentBox = noone) {
	var _padding = _control.boxModel.padding.left + _control.boxModel.padding.right;
	var _margin = _control.boxModel.margin.left + _control.boxModel.margin.right;
	
	if(_control.width >= 0)
		return _control.width;
	
	if(_parentBox != noone) {			
		return _parentBox.boxModel.contentWidth - _margin - _padding;
	}
	
	return display_get_gui_width();
}

function reflex_calculateWidth(_control, _parentBox, _contentWidth) {
	if(_control.width >= 0)
		return _control.width;
		
	return _contentWidth;
		
}

function reflex_calculateHeight(_control, _parentBox, _contentHeight) {
	if(_control.height >=0)
		return _control.height;
		
	return _contentHeight;
}

function reflex_calculateBoxModels(_control, _parent = noone) {
	_control.boxModel = new ReflexBoxModel(_control, _parent);
	
	
	if(is_array(_control.children) && array_length(_control.children) > 0) {
		//Calculate Size based on child
		_control.boxModel.setContentSize(
			reflex_maxWidth(_control, _parent),
			reflex_calculateHeight(_control, _parent, 0)
		);
	
		var _contentWidth = 0;
		var _contentHeight = 0;
	
		var _contentArea = _control.boxModel.getContentRect();
		var _x = 0;
		var _y = 0;
		var _lineHeight = 0;
		var _maxWidth = _contentArea.getWidth();
		
		for(var i = 0; i < array_length(_control.children); i++) {
			var _child = _control.children[i];
			reflex_calculateBoxModels(_child, _control.boxModel);
			var _box = _child.boxModel.getControlRect();
			
			// New Line
			if (_x + _box.getWidth() > _maxWidth) {
				_x = 0;
				_y += _lineHeight;
				_lineHeight = 0;
			}
			_child.x = _x;
			_child.y = _y;
			
			_x += _box.getWidth();
			_lineHeight = max(_lineHeight, _child.height);
			_contentWidth = max(_contentWidth, _x);
			_contentHeight = max(_contentHeight, _y + _lineHeight);
		}
		
		_control.boxModel.setContentSize(
			reflex_calculateWidth(_control, _parent, _contentWidth),
			reflex_calculateHeight(_control, _parent, _contentHeight)
		);
		
	} else {
		//Calculate width by default
		_control.boxModel.setContentSize(
			reflex_calculateWidth(_control, _parent, 0),
			reflex_calculateHeight(_control, _parent, 0)
		);
	}
	
}

function reflex_cacheBoxModels(_control) {
	_control.boxModel.calculateAreas();
	if(is_array(_control.children) && array_length(_control.children) > 0) {
		for(var i = 0; i < array_length(_control.children); i++) {
			reflex_cacheBoxModels(_control.children[i]);
		}
	}
}
