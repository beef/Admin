// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function getAssetIDs() 
{
  if ($('asset-list') != undefined)
  {
    var assets = new Array();
    var count = 0;    
    
    $$('#asset-list li').each(function(li) 
    {
      asset_id = li.id.split(':')[1];
      assets[count] = asset_id;
      count++;
    });
    
    return assets;
  }
  
  return [];
}

var generatePassword = function() {
	new Ajax.Request('/admin/users/generate_password', { method: 'get',
                                              asynchronous:true, 
                                              evalScripts:true});
};

var updateStrength = function(pw) {
	var strength = getStrength(pw);
	var width = (100/32)*strength;
	new Effect.Morph('psStrength', {style:'width:'+width+'px', duration:'0.4'}); 
};
			
var getStrength = function(passwd) {
	intScore = 0;
	if (passwd.match(/[a-z]/)) // [verified] at least one lower case letter
			{
			intScore = (intScore+1);
			} if (passwd.match(/[A-Z]/)) // [verified] at least one upper case letter
			{
			intScore = (intScore+5);
			} // NUMBERS
			if (passwd.match(/\d+/)) // [verified] at least one number
			{
			intScore = (intScore+5);
			} if (passwd.match(/(\d.*\d.*\d)/)) // [verified] at least three numbers
			{
			intScore = (intScore+5);
			} // SPECIAL CHAR
			if (passwd.match(/[!,@#$%^&*?_~]/)) // [verified] at least one special character
			{
			intScore = (intScore+5);
			} if (passwd.match(/([!,@#$%^&*?_~].*[!,@#$%^&*?_~])/)) // [verified] at least two special characters
			{
			intScore = (intScore+5);
			} // COMBOS
			if (passwd.match(/[a-z]/) && passwd.match(/[A-Z]/)) // [verified] both upper and lower case
			{
			intScore = (intScore+2);
			} if (passwd.match(/\d/) && passwd.match(/\D/)) // [verified] both letters and numbers
			{
			intScore = (intScore+2);
			} // [Verified] Upper Letters, Lower Letters, numbers and special characters
			if (passwd.match(/[a-z]/) && passwd.match(/[A-Z]/) && passwd.match(/\d/) && passwd.match(/[!,@#$%^&*?_~]/))
			{
			intScore = (intScore+2);
			}
			return intScore;
};


toggle_published_at = function(state) {
  $$("#published_at select").each(function(item) {
    if (state) {
      item.enable();
    } else {
      item.disable();
    } 
  });
};

toggle_published_to = function(state) {
  $$("#published_to select").each(function(item) {
    if (state) {
      item.enable();
    } else {
      item.disable();
    } 
  });
};

insertAtCursor = function(myField, myValue) {
  //IE support
  if (document.selection) {
    myField.focus();
    sel = document.selection.createRange();
    sel.text = myValue;
  }
  //MOZILLA/NETSCAPE support
  else if (myField.selectionStart || myField.selectionStart == '0') {
    var startPos = myField.selectionStart;
    var endPos = myField.selectionEnd;
    myField.value = myField.value.substring(0, startPos)
                  + myValue
                  + myField.value.substring(endPos, myField.value.length);
  } else {
    myField.value += myValue;
  }
};

// get and encode the form authenticity token new in Rails 2.0
// http://www.saynotomilk.com/archives/33
var AJ = {
  encode_authenticity_token:function(token) {
    return encodeURIComponent($(token).value);
  },

  authenticity_token:function() {
    return AJ.encode_authenticity_token($$('input[name="authenticity_token"]')[0]);
  },

  authenticity_token_query_parameter_for_page:function() {
    return 'authenticity_token=' + authenticity_token;
  },

  ajax_request:function(url) {
    new Ajax.Request(url, {asynchronous:true, evalScripts:true, parameters:AJ.authenticity_token_query_parameter_for_page()});
  }
};

var AssetBrowser = Class.create({
  initialize: function(grouping, folder) {
    AssetBrowser.current_grouping = grouping;
    AssetBrowser.dl = $('asset-browser');
    AssetBrowser.setContentNodeForm('content-node-form');
    AssetBrowser.dts = AssetBrowser.dl.select('dt');
    AssetBrowser.open_folder = folder;
        
    AssetBrowser.dts.each(function(dt) {
      dt.dd = dt.next('dd');
      if (dt.dd) {
        dt.dd.hide();
        dt.onclick = function() {
          AssetBrowser.closeInfo();
          this.dd.toggle();         
          if (AssetBrowser.current_content != this.dd) {
            if (AssetBrowser.current_content != null && AssetBrowser.current_content.visible()) {
              AssetBrowser.current_content.toggle();
            }
            AssetBrowser.current_content = this.dd;
          }
        };
        new Renameable(dt, 0.7);
      }
    });
    AssetBrowser.openContent();
  }
});

Object.extend(AssetBrowser, {
 
  openContent: function() {
    type = this.open_folder;
    if (type) {
      dt = this.dl.down('#'+type);
      if (dt) { dt.onclick(); }      
    }
  },

  openInfo: function(id, anchor) {
     
    this.closeInfo();
    list = $(anchor).up('ul');
    list.hide();
    list.insert({after: '<div id="asset-info"></div>'});
    this.current_list = list;
    this.current_info = list.next();

    new Ajax.Request('/admin/assets/' + id, { method: 'get',
                                              asynchronous:true, 
                                              evalScripts:true } );
  },
  
  closeInfo: function() {
    if (this.current_list) {
      this.current_list.show();
      this.current_info.remove();
    }
    this.current_list = null;
    this.current_info = null;
  },
  
  assetAction: function(asset) {
    $('asset-upload-form').reset();
    if (this.contentNodeForm) {
      this.addAssetToContentNode(asset);
    } else {
      this.destroyAsset(asset);
    }
  },
  
  destroyAsset: function(asset) {
    if (confirm('Are you sure you wish to delete the asset \'' + asset.filename + ' \'?')) {
      new Ajax.Request('/admin/assets/'+ asset.id, { method: 'delete',
                                                     asynchronous:true, 
                                                     evalScripts:true,
                                                     parameters: { content_type: asset.content_type, authenticity_token: AJ.authenticity_token() } } );
      
      asset_li = $('browser-asset:' + asset.id);
      asset_list = asset_li.up('ul');
      asset_li.remove();
      if (asset_list.empty()) {
        asset_list.up('dd').previous().remove();
        asset_list.up('dd').remove();
      }
      if (this.contentNodeForm) {
        this.removeAssetFromContentNode(asset.id);
      }  
      
    }
  },
  

  
  // Fire once a asset has been uploaded
  uploadedAsset: function(asset) {
    type = Object.keys(asset).first();
    $('asset-upload-form').reset();
    if (this.contentNodeForm) {
      this.addAssetToContentNode(asset[type]);
    }
    if (asset[type]) {
      switch (this.current_grouping){
        case 'by_content_type':
        this.open_folder = asset[type].content_type.replace(/\W+/,'-');
        break;
        case 'by_category':
        this.open_folder = asset[type].category;
        break;
      }
    }
  },
  
  reload: function(grouping) {
    if (grouping) {
      this.current_grouping = grouping;
    }
    new Ajax.Request('/admin/assets/'+this.current_grouping, { method: 'get',
                                        asynchronous:true, 
                                        evalScripts:true,
                                        parameters: { for_content: this.contentNodeForm != null,
                                                      folder: this.open_folder },
                                        onSuccess: init_asset_category_auto_complete } );
    
  },
  
  setContentNodeForm: function(id) {
    this.contentNodeForm = $(id);
    if (this.contentNodeForm) {
      this.contentNodeForm.model_name = this.contentNodeForm.className.split('_').slice(1,this.contentNodeForm.className.split('_').length).join('_');
      this.setUpAssetList();
      this.contentNodeForm.onsubmit = function() {
        $$('#asset-list li').each(function(li) {
          asset_id = li.id.split(':')[1];
          this.insert('<input type="hidden" name="' + this.model_name + '[asset_ids][]" id="asset_id:' + asset_id + '" value="' + asset_id + '" />');
        }, this);
        return true;
      };
    } 
  },
  
  setUpAssetList: function() {
    this.assetList = $('asset-list');
    if (this.assetList) {
      Sortable.create(this.assetList);
    }
    this.contentNodeForm.assetList = this.assetList;
  },

  addAssetToContentNode: function(asset) {
    if (!this.assetList) {
    $('attach-asset-list').insert({top:'<h2 class="drop-down open">' + this.contentNodeForm.model_name + ' Files</h2><ul class="asset-list" id="asset-list"></ul>'});
      this.setUpAssetList();
    }

    this.assetList.show();
    if (!$('asset:' + asset.id)) {
      
	  if(/image/.test(asset.content_type)){
	  	li = new Element('li', { 'class': asset.content_type.replace('/','-'), id: 'asset:' + asset.id }).update('<img alt=\"' + asset.filename + '\" src=\"' + asset.sizes.find(function(size){ return size[0] == 'square'; })[1] + '\" />');
	  } else {
	  	li = new Element('li', { 'class': asset.content_type.replace('/','-'), id: 'asset:' + asset.id }).update(asset.filename + ' ' + asset.description);
    }

	  filename = new Element('h4').update(asset.filename);
	  div = new Element('div');
      h4 = new Element('h4').update("Insert Image");
      view_info = new Element('a').update('View Info<br/>');
	  
	  view_info.onclick = function() {
		 AssetBrowser.openInfo(asset.id, li);
         return false;
       };

      insert_image_large = new Element('a').update('Large | ');
	  insert_image_medium = new Element('a').update('Medium | ');
	  insert_image_small = new Element('a').update('Small');
	  
	  insert_image_large.onclick = function() {
		 addAsset(asset.id, 'large' );
         return false;
       };
      insert_image_medium.onclick = function() {
		 addAsset(asset.id, 'medium' );
         return false;
       };
	  insert_image_small.onclick = function() {
		 addAsset(asset.id, 'thumb' );
         return false;
       };
	
      insert_document = new Element('a').update(' | Insert');
	  
	  var theForm = this.contentNodeForm;
	
      	deleter = new Element('a').update('Detach');
      	deleter.onclick = function() {
      		AssetBrowser.removeAssetFromContentNode(asset.id);
      		return false;
		};
	  
	  div.insert(filename);
	  div.insert(view_info);
      div.insert(deleter);

	  li.insert(div);
      
      if(/image/.test(asset.content_type)){
	    //setup for images
	    	
    		div.insert(h4);
    		div.insert(insert_image_large);
			div.insert(insert_image_medium);
    		div.insert(insert_image_small); 

      }else{
      //setup for documents
         insert_document.onclick = function() {
           addAsset(asset.id);
           return false;
         };
         div.insert(insert_document);
      }

      this.assetList.insert(li);    
      this.setUpAssetList();
    }
  },

  removeAssetFromContentNode: function(asset_id) {
    $('asset:' + asset_id).remove();
  },
  
  rootUrl: function(url){
    if(!url)
      url = window.location.href;
    
    var matches = url.match(/^(?:http:\/\/)?[^\/]+/);
    if(matches.length <1){
      return url;
    }else{
      return matches[0];
    }
  }

});


showImageSizes = function(id, sizes, anchor){
  if($('image-sizes-outer')){
    //hide image size div
    hideImageSizes();
  }else{
    //hide image size div
    hideImageSizes();
    //set up the parent for an absolute positioned floater
    $('asset-list').up('div').setStyle({position:'relative'});
    var apos = $(anchor).positionedOffset(); //position of the link
    var appos = $(anchor).up('li').positionedOffset(); //position of it's parent (as we know the anchor is inside a static element)
    var per_icon = 20; //square icons 16px by 16px with a 2 2 2 2px pad
    $('asset-list').insert({after:'<div id="image-sizes-outer" style="overflow:hidden;background:transparent url(/images/admin/images-pointer.png) no-repeat center right;width:21px;padding:0 5px 0 0;position:absolute;left:'+ Math.round(apos[0]+appos[0]-per_icon-10) +'px;top:'+ ((apos[1]+appos[1]+(anchor.getHeight()/2)) - ((per_icon+4) * ((sizes.length+1)/2))) +'px;"><div id="image-sizes" style="background-color:#b2bd3e;border:1px solid #333;border-right:none;padding:2px;"></div></div>'});
    //alert('left:'+ Math.round(apos[0]+appos[0]-per_icon-2) +'px;top: (('+(apos[1]+appos[1])+'+('+anchor.getHeight()+'/2)) - ('+(per_icon)+'*('+image_number+'/2))) px;');
  
    //for each type show an image
    $A(sizes).each(function(size,index){
      content = new Element('a', { 'class': 'image-size size-'+ size[0], 'title': size[0] }).update(size[0]);
      content.onclick = function() {
        addAsset(id, size[0] );
        hideImageSizes();
        return false;
      };
      $('image-sizes').insert(content);
    });

    //this is a cancel button
    $('image-sizes').insert('<a style="float:none;" class="image-size editor_cancel" href="#" title="Cancel" onclick="hideImageSizes();return false;">Cancel</a>');
  }
};
hideImageSizes = function(){
  var container = $('image-sizes-outer');
  if(container)
    container.remove();
};

// Load SWFU
var swfu;
Event.observe(window, 'load', function() {
  if ($('asset-browser')) {
    form = $('asset-upload-form');
    form.insert({after: '<div id="flash-button"></div>'});
    js_path =  form.action.split('?').join('.js?');
    swfu = new SWFUpload({
      // Create the custom swfupload_photos_path in the routes.rb file
      // Session name must match with environment.rb 
      upload_url : js_path,
      flash_url : '/flash/swfupload.swf',
      file_post_name: 'asset[uploaded_data]', 

      file_size_limit : '5 MB',
      file_upload_limit : 0,

      file_queue_error_handler : UploadHandler.fileQueueError,
      file_dialog_complete_handler : UploadHandler.fileDialogComplete,
      upload_progress_handler : UploadHandler.uploadProgress,
      upload_start_handler: UploadHandler.uploadStart,
      upload_error_handler : UploadHandler.uploadError,
      upload_success_handler : UploadHandler.uploadSuccess,
      upload_complete_handler : UploadHandler.uploadComplete,
      custom_settings : { 
        upload_form : 'asset-upload-form'
      },
      
      button_placeholder_id: 'flash-button',
      button_height: 19,
      button_width: 157,
      button_image_url: '/images/admin/file-uploads.png',
      button_action : SWFUpload.BUTTON_ACTION.SELECT_FILES,
      button_disable : false,
      button_window_mode : SWFUpload.WINDOW_MODE.TRANSPARENT,

      debug: false

    }); 
    if (swfu) {
      form.onsubmit = function(){return false;};
      $('upload-elements').remove();
    }
  }

});



var check_asset_description = function(){
  if($F('asset_description') == ''){
    if(!confirm("This image will be uploaded without a description.\n\nClick cancel to enter a description first.")){
      return false;
    }
  }
  swfu.selectFiles();
};

init_asset_category_auto_complete = function() {
  asset_category_field = $('asset_category');
  if (asset_category_field) {
    new Ajax.Request('/admin/assets/categories', { 
      method: 'get',
      onSuccess : function(response) {
        new Autocompleter.Local('asset_category', 'asset_category_complete', response.responseJSON );
      }
    });
  }
};
document.observe('dom:loaded', init_asset_category_auto_complete);

init_edit_asset_form = function() {
  $$('form.edit_asset').first().onsubmit = function(e) {
    this.request({
      onComplete: function() {AssetBrowser.reload();}
    });
    
    return false;
  };
};

init_featuring = function() {
  $$('a.feature').each(function(link) {
    link.onclick = function() {
      new Ajax.Request(this.href, { 
        method: 'get',
        onSuccess : function(response) {
          // If no rjs response
          if (response.responseText.blank()) {
            link.toggleClassName('featured');
          }
        }
      });
      return false;
    };
  });
};
document.observe('dom:loaded', init_featuring);

init_tabs = function() {
  sub_headings = $$("#sub-content h2");
  if (sub_headings.length > 1) {
    sub_headings.each(function(item) {
      item.addClassName('drop-down');
      if(!item.next().hasClassName("default")) {
        item.next().hide();
      } else {
        item.addClassName('open');
      }
      item.onclick = function() {
        this.toggleClassName('open');
        this.next().toggle();
        return false;
      };
      item.onmouseover = function() { this.addClassName('sfhover'); };
      item.onmouseout = function() { this.removeClassName('sfhover'); };
    });    
  }
};
document.observe("dom:loaded", init_tabs);

init_flash_messages = function() {
  
  $$('div.flash').each(function(flash){
    if (!flash.init) {
      flash.blindUp({ 
        delay: 5,
        afterFinish:function(effect) { effect.element.remove(); }
      });
      flash.onclick = function() {
        this.remove();
      }; 
    }
  });
};
document.observe("dom:loaded", init_flash_messages);

var Holdable = Class.create({
  initialize: function(elem, seconds, firer) {
    this.elem = elem;
    this.seconds = seconds;
    if (firer) {
      this.firer = firer; 
    }
    
    this.elem.observe('mousedown', this.starter.bindAsEventListener(this));
    this.elem.observe('mouseup', this.clearTimeout.bindAsEventListener(this));
  },
  
  starter: function() {
    this.clear_id = this.firer.delay(this.seconds, this.elem);
  },
  
  firer: function(elem) {
    alert('NO FIRER!');
  },
  
  clearTimeout: function() {
    window.clearTimeout(this.clear_id);
  }
});

var Renameable = Class.create(Holdable, {
  firer: function(elem) {
    this.text_input = new Element('input', { href: 'text', value: elem.innerHTML }); 
    elem.update(this.text_input);
    this.text_input.focus();
    this.text_input.observe('blur', function() {
      this.replace(this.value);
    });
    this.text_input.observe('change', function() {
      asset_id = elem.id.split(':').last();
      new Ajax.Request('/admin/assets/' + asset_id + '/rename_category' , {
        parameters: { name: this.value  }
      });
    });
  } 
});
