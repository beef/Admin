var teButtons = TextileEditor.buttons;

/*
  Link button.
*/
link_button = TextileEditor.prepareButton(new TextileEditorButton('ed_link','link.png','"',   '":', 'l', 'Link'));
link_button.onclick = function() {
  this.standard = false;
  if (!this.textile_editor.checkOpenTags(this)) {
    this.tagEnd = '":' + prompt("Add your link", "");
  }
  this.textile_editor.insertTag(this);
  return false;  
};
// Preview button
// preview_button = TextileEditor.prepareButton(new TextileEditorButton('ed_preview','preview.png',null,null,null,'Preview'));
// preview_button.onclick = function() {
// 
//   var myField = this.textile_editor.canvas;
//   var preview_id = myField.id + '-preview';
//   var preview_div = $(preview_id);
//   if (preview_div) {
//     Effect.BlindUp(preview_div, {afterFinish:function() {
//       myField.style.overflow = 'auto';
//       preview_div.remove();
//     }});
//   } else {
//     
//     html = '<div id="'+preview_id+'" class="preview-area">';
//     html += this.textile_editor.preview_text();
//     html += '</div>';
// 
//     $(myField.parentNode).insert(html);
//     preview_div = $(preview_id);
//     
//     preview_div.setStyle({
//       position: 'absolute'
//     });
//     
//     // Clone textarea's position
//     preview_div.clonePosition(myField);
//     // Fix top if textarea scrolled
//     preview_div.style.top = $(myField).offsetTop + 'px';
//     
//     Effect.BlindDown(preview_div);
//          
//     myField.style.overflow = 'hidden';   
//     
//   }
//   return false;  
// };


teButtons.push(new TextileEditorButton('ed_strong',			'bold.png',          '*',   '*',  'b', 'Bold','s'));
teButtons.push(new TextileEditorButton('ed_emphasis',		'italic.png',        '_',   '_',  'i', 'Italicize','s'));
teButtons.push(new TextileEditorButton('ed_underline',	'underline.png',     '+',   '+',  'u', 'Underline','s'));
teButtons.push(new TextileEditorButton('ed_strike',     'strikethrough.png', '-',   '-',  's', 'Strikethrough','s'));
teButtons.push(link_button);
teButtons.push(new TextileEditorButton('ed_ol',					'list_numbers.png',  '# ', '\n', ',', 'Numbered List'));
teButtons.push(new TextileEditorButton('ed_ul',					'list_bullets.png',  '* ', '\n', '.', 'Bulleted List'));
teButtons.push(new TextileEditorButton('ed_p',					'paragraph.png',     'p',   '\n', 'p', 'Paragraph'));
// teButtons.push(new TextileEditorButton('ed_h1',          'h1.png',            'h1',  '\n', '1', 'Header 1'));  
//teButtons.push(new TextileEditorButton('ed_h2',					'h2.png',            'h2',  '\n', '2', 'Header 2'));
//teButtons.push(new TextileEditorButton('ed_h3',					'h3.png',            'h3',  '\n', '3', 'Header 3'));
teButtons.push(new TextileEditorButton('ed_h4',					'h4.png',            'h4',  '\n', '4', 'Header 4'));
//teButtons.push(new TextileEditorButton('ed_block',   		'blockquote.png',    'bq',  '\n', 'q', 'Blockquote'));
//teButtons.push(new TextileEditorButton('ed_outdent', 		'outdent.png',       ')',   '\n', ']', 'Outdent'));
//teButtons.push(new TextileEditorButton('ed_indent',  		'indent.png',        '(',   '\n', '[', 'Indent'));
//teButtons.push(new TextileEditorButton('ed_justifyl',		'left.png',          '<',   '\n', 'l', 'Left Justify'));
//teButtons.push(new TextileEditorButton('ed_justifyc',		'center.png',        '=',   '\n', 'e', 'Center Text'));
//teButtons.push(new TextileEditorButton('ed_justifyr',		'right.png',         '>',   '\n', 'r', 'Right Justify'));
//teButtons.push(new TextileEditorButton('ed_justify', 		'justify.png',       '<>',  '\n', 'j', 'Justify'));
//teButtons.push(preview_button);

// teButtons.push(new TextileEditorButton('ed_code','code','@','@','c','Code'));

// Add image. insertAtCursor function in apllcation.js
addImage = function(imageurl,size) {
  alt = alt.replace("(","").replace(")","");
  insertAtCursor(TextileEditor.canvas, '\n\n!'+imageurl+'('+alt+')!\n\n');
};

addLinkedImage = function(imageurl,alt) {
  alt = alt.replace("(","").replace(")","");
  insertAtCursor(TextileEditor.canvas, '\n\n!'+imageurl+'('+alt+')!:'+imageurl+'\n\n');
};

addLink = function(text, url) {
  insertAtCursor(TextileEditor.canvas, '"'+ text +'":'+ url + ' ');
};

addAsset = function(asset_id, size) {
  if (size && size != 'fullsize') {
    size = '|'+size;
  } else {
    size = ''
  }
  insertAtCursor(TextileEditor.canvas, '[asset('+asset_id+size+')]');
};

// Iittialise textile editor
document.observe('dom:loaded',function(){
  $$('textarea.editor').each(function(ta){
    // alert(ta.id);
    TextileEditor.initialize(ta.id);
  });
});