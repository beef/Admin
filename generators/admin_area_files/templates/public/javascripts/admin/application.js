// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
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
    return encodeURIComponent(token);
  },

  authenticity_token:function() {
    return AJ.encode_authenticity_token(AUTH_TOKEN);
  },

  authenticity_token_query_parameter_for_page:function() {
    return 'authenticity_token=' + authenticity_token;
  },

  ajax_request:function(url) {
    new Ajax.Request(url, {asynchronous:true, evalScripts:true, parameters:AJ.authenticity_token_query_parameter_for_page()});
  }
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

function getAssetIDs() 
{
  if ($('asset-list') != undefined)
  {
    var assets = new Array();
    var count = 0;    
    
    $$('#asset-list li').each(function(li) 
    {
      asset_id = li.id.split('-').last();
      assets[count] = asset_id;
      count++;
    });
    
    return assets;
  }
  
  return [];
}
