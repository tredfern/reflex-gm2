


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
	
	if(_control.width >= 0)
		return _control.width;
	
	if(_parent != noone && _parent != undefined) {			
		return _parent.contentWidth - _margin - _padding;
	}
	
	return display_get_gui_width();
}

function reflex_maxHeight(_control, _parent = noone) {
	var _padding = _control.boxModel.padding.top + _control.boxModel.padding.bottom;
	var _margin = _control.boxModel.margin.top + _control.boxModel.margin.bottom;
	
	if(_control.height >= 0)
		return _control.height;
	
	if(_parent != noone) {			
		return _parent.contentHeight - _margin - _padding;
	}
	
	return display_get_gui_height();
}

function reflex_calculateWidth(_control, _parentBox, _contentWidth) {
	if(_control.width >= 0)
		return _control.width;
		
	if _control.display == reflex_display.inline 
		return _contentWidth;
	
	return reflex_maxWidth(_control, _parentBox);
		
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
			var _box = _child.boxModel.getFullArea();
			
			// New Line
			if (_x + _box.getWidth() > _maxWidth) {
				_x = 0;
				_y += _lineHeight;
				_lineHeight = 0;
			}
			_child.x = reflex_align(_child.halign, _x, _maxWidth, _box.getWidth());
			_child.y = reflex_align(_child.valign, _y, reflex_maxHeight(_child, _control.boxModel), _box.getHeight());
			
			_x += _box.getWidth();
			_lineHeight = max(_lineHeight, _box.getHeight());
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

function reflex_align(_alignment, _min, _max, _size) {
	if (_alignment == fa_left || _alignment == fa_top)
		return _min;
	
	if (_alignment == fa_middle || _alignment == fa_center)
		return (_max - _min - _size) / 2;
		
	if (_alignment == fa_right || _alignment == fa_bottom)
		return _max - _size;
	
	return _min;
}
