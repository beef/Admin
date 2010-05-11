document.observe("dom:loaded", function(){
  tinyMCE.init({
    theme : "advanced",
    mode : "specific_textareas",
    editor_selector : "editor",
    strict_loading_mode : 1,
    convert_urls : false,
    plugins : "safari,inlinepopups,paste",
    //"safari,pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras",
    // Theme options
    theme_advanced_blockformats : "p,h2,h3,h4",
    theme_advanced_buttons1 :  "undo,redo,|,bold,italic,underline,strikethrough,|,formatselect,|,bullist,numlist,|,link,unlink,|,indent,outdent,|,justifyleft,justifycenter,justifyright,justifyfull,|,code",
    theme_advanced_buttons2 : "",
    theme_advanced_buttons3 : "",
    theme_advanced_buttons4 : "",
    theme_advanced_path : false,
    theme_advanced_toolbar_location : "top",
    theme_advanced_toolbar_align : "left",
    theme_advanced_statusbar_location : "bottom",
    theme_advanced_resizing : true,
    
    // Paste
    paste_auto_cleanup_on_paste : true,
    paste_remove_styles: true,
    
    // Drop lists for link/image/media/template dialogs
    external_link_list_url : false,
    remove_redundant_brs : false,
    onchange_callback : "saveEditorToElement"
  });
});

saveEditorToElement = function(inst){
  inst.save();
};

/*
  This can be expanded as clients report issues with characters not being cufon-ed
  The main reason for this conversion is that alot of fonts we use are not full fonts,
  they do not have extended unicode range (missing Latin A or B most of the time, and forget
  about cyrillic, greek/coptic and russian!)
*/
tinyMCEcleanup = function(type, value){
  // add more event types here for more cleanup points
  //    get_from_editor is trigger on html editor open and form submit
  if(['get_from_editor'].indexOf(type) == -1) return value;
  patterns =     ["(\u2018|\u2019|&(r|l)squo;)","(\u201c|\u201d|&(r|l)dquo;)"];
  replacements = ["&apos;",     '&quot;'];
  
  $A(patterns).each(function(p, index){
    r = replacements[index];
    re=new RegExp(p,'ig');
    value = value.replace(re,r);
  });

  return value;
}

// Add image. insertAtCursor function in apllcation.js
addImage = function(imageurl,alt) {
  tinyMCE.execInstanceCommand(tinyMCE.activeEditor.id,"mceInsertContent",false, '<img src="' + imageurl + '" alt="' + alt + '" />');
};

addLinkedImage = function(imageurl,alt) {
   tinyMCE.execInstanceCommand(tinyMCE.activeEditor.id,"mceInsertContent",false, '<a href="' + imageurl + '"><img src="' + imageurl + '" alt="' + alt + '" /></a>');
};

addLink = function(text, url) {
  tinyMCE.execInstanceCommand(tinyMCE.activeEditor.id,"mceInsertContent",false,'<a href="' + url + '">' + text + '</a>');
};

addAsset = function(asset_id, size) {
  if(size && size=='small')
    size = 'thumb';
  
  new Ajax.Request('/admin/assets/' + asset_id + '.json', { method:'get',
                                                  asynchronous:true,
                                                  onSuccess: function(response){
                                                    asset = response.responseJSON[Object.keys(response.responseJSON)[0]];
                                                    filename = asset.public_filename;
                                                    
                                                    if(/^image\//.test(asset.content_type)){
                                                      for(var i=0,j=asset.sizes.length;i < j;i++){
                                                        if(asset.sizes[i][0] == size)
                                                          filename = asset.sizes[i][1];
                                                      }
                                                      addImage(filename, asset.description);
                                                    }else{
                                                      addLink(asset.description, filename);
                                                    }
                                                  }
                                                });

};
