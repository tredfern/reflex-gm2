


function reflex_refreshLayout() {
	for(var i = 0; i < array_length(global.reflex.rootControls); i++) {
		reflex_calculateBoxModels(global.reflex.rootControls[i]);		
	}
	
	for(var i = 0; i < array_length(global.reflex.rootControls); i++) {
		reflex_cacheBoxModels(global.reflex.rootControls[i]);
	}
}


function reflex_maxWidth(_control, _parent = noone) {
	var _padding = _control.boxModel.padding.left + _control.boxModel.padding.right;
	var _margin = _control.boxModel.margin.left + _control.boxModel.margin.right;
	var _border = _control.boxModel.border.left + _control.boxModel.border.right;
	
	//Check for a percentage size
	if(_control.width > 0 && _control.width < 1) {
		return _parent.contentWidth * _control.width - _margin - _padding - _border
	}
	
	//Check for a specific width
	if(_control.width > 1)
		return _control.width;
	
	if(_parent != noone && _parent != undefined) {			
		return _parent.contentWidth - _margin - _padding - _border;
	}
	
	return display_get_gui_width();
}

function reflex_maxHeight(_control, _parent = noone, _availableHeight = -1) {
	var _padding = _control.boxModel.padding.top + _control.boxModel.padding.bottom;
	var _margin = _control.boxModel.margin.top + _control.boxModel.margin.bottom;
	var _border = _control.boxModel.border.top + _control.boxModel.border.bottom;
	
	// Calculate a percentage of parent space
	if(_control.height > 0 && _control.height < 1) {
		return _parent.contentHeight * _control.height - _margin - _padding - _border;
	}
	
	if(_control.height > 1)
		return _control.height;
	
	if(_availableHeight > 0) {
		return _availableHeight;	
	}
	
	if(_parent != noone) {			
		return _parent.contentHeight - _margin - _padding - _border;
	}
	
	return display_get_gui_height();
}

function reflex_calculateWidth(_control, _parentBox, _contentWidth) {
	// Check if we always use the content size
	if(_control.display == reflex_display.content)
		return _contentWidth;
		
	if(_control.width >= 0) {
		if (_control.width < 1) {
			// Calculate a percentage
			return _parentBox.contentWidth * _control.width;
		} 
		return _control.width;
	}
	
	if _control.display == reflex_display.inline 
		return _contentWidth;
	
	return reflex_maxWidth(_control, _parentBox);
		
}

function reflex_calculateHeight(_control, _parentBox, _contentHeight) {
	// Check if we always use the content size
	if(_control.display == reflex_display.content)
		return _contentHeight;
		
	if(_control.height >=0) {
		if (_control.height > 0 && _control.height < 1) {
			// Calculate a percentage
			return _parentBox.contentHeight * _control.height;
		} 
		return _control.height;
	}
	
	return _contentHeight;
}

function reflex_calculateBoxModels(_control, _parent = noone, _availableHeight = -1) {
	_control.boxModel = new ReflexBoxModel(_control, _parent);
	
	if(variable_struct_exists(_control, "onLayout")) {
		_control.onLayout(
			_control.boxModel, 
			reflex_maxWidth(_control, _parent), 
			reflex_maxHeight(_control, _parent, _availableHeight)
		);	
	}
	
	if(is_array(_control.children) && array_length(_control.children) > 0) {
		
		//Calculate Size based on child
		_control.boxModel.setContentSize(
			reflex_maxWidth(_control, _parent),
			reflex_maxHeight(_control, _parent, _availableHeight)
		);
	
		var _contentWidth = 0;
		var _contentHeight = 0;
	
		var _contentArea = _control.boxModel.getContentRect();
		var _x = 0;
		var _y = 0;
		var _lineHeight = 0;
		var _maxWidth = _contentArea.getWidth();
		var _maxHeight = _contentArea.getHeight();
		
		for(var i = 0; i < array_length(_control.children); i++) {
			
			//Skip current iteration
			if(!_control.isVisible) {
				show_debug_message("Control not visible");
				continue;
			}
			
			var _child = _control.children[i];
			reflex_calculateBoxModels(_child, _control.boxModel, _maxHeight - _y);
			var _box = _child.boxModel.getFullArea();
			
			// New Content won't fit, new line...
			if (_x + _box.getWidth() > _maxWidth) {
				_x = 0;
				_y += _lineHeight;
				_lineHeight = 0;
			}
			_child.x = reflex_align(_child.halign, _x, _maxWidth, _box.getWidth());
			_child.y = reflex_align(_child.valign, _y, _maxHeight, _box.getHeight());
			
			_x = _child.x + _box.getWidth();
			_lineHeight = max(_lineHeight, _box.getHeight());
			_contentWidth = max(_contentWidth, _x);
			_contentHeight = max(_contentHeight, _y + _lineHeight);
			
			// This content will force a new line anyway, calculate that into the next row
			if (_x == _maxWidth) {
				_x = 0;
				_y += _lineHeight;
				_lineHeight = 0;
			}
		}
		
		_control.boxModel.setContentSize(
			reflex_calculateWidth(_control, _parent, _contentWidth),
			reflex_calculateHeight(_control, _parent, _contentHeight)
		);
		
	} else {
		_control.boxModel.setContentSize(
			reflex_calculateWidth(_control, _parent, _control.boxModel.contentWidth),
			reflex_calculateHeight(_control, _parent, _control.boxModel.contentHeight)
		);
	}
	
}

function reflex_cacheBoxModels(_control) {
	if(variable_struct_empty(_control, "boxModel"))
		return;
		
	_control.boxModel.calculateAreas();
	if(is_array(_control.children) && array_length(_control.children) > 0) {
		for(var i = 0; i < array_length(_control.children); i++) {
			reflex_cacheBoxModels(_control.children[i]);
		}
	}
}

function reflex_align(_alignment, _min, _max, _size) {
	if (_alignment == fa_left || _alignment == fa_top)
		return _min;
	
	if (_alignment == fa_middle || _alignment == fa_center)
		return (_max - _min - _size) / 2;
		
	if (_alignment == fa_right || _alignment == fa_bottom)
		return _max - _size;
	
	return _min;
}

function reflex_isPercentage(_value) {
	return _value > 0 && _value < 1;	
}