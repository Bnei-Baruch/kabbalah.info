function blockElementAlignClean(type, value) {
    switch (type) {
        case "get_from_editor":  //not used but good to keep
            //console.info("Value HTML string: ",value);
            //value = value.replace(/align=(['"])(\w+)(['"])/,"style=$1text-align: $2;$3");
            break;

        case "insert_to_editor": //not used but good to keep
            //console.info("Value HTML string: ",value);
            //value = value.replace(/align=(['"])(\w+)(['"])/,"style=$1text-align: $2;$3");
            // Do custom cleanup code here
            break;

        case "get_from_editor_dom": //convert into inline styles
            // console.info("Value DOM Element ",value);
            // Do custom cleanup code here
            var paragraphs = $A(value.getElementsByTagName('p'));
            var divs = $A(value.getElementsByTagName('div'));
            paragraphs.each(function (paragraph) {
                if(paragraph.align) {
                    paragraph.style.textAlign = paragraph.align;
                    paragraph.align = '';
                }
            });
            divs.each(function (div) {
                if(div.align) {
                    div.style.textAlign = div.align;
                    div.align = '';
                }
            });
            break;

        case "insert_to_editor_dom": //convert back into align, to allow for changes to be made though the text align buttons
            // console.info("Value DOM Element: ",value);
            // Do custom cleanup code here
            var paragraphs = $A(value.getElementsByTagName('p'));
            var divs = $A(value.getElementsByTagName('div'));
            paragraphs.each(function (paragraph) {
                if(paragraph.style.textAlign) {
                    paragraph.align = paragraph.style.textAlign;
                    paragraph.style.textAlign = '';
                }
            });
            divs.each(function (div) {
                if(div.style.textAlign) {
                    div.align = div.style.textAlign;
                    div.style.textAlign = '';
                }
            });
            break;
    }
    return value;
}
