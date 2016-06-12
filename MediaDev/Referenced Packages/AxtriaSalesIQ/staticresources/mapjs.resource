var $j = jQuery.noConflict();
$j(function(){
    console.log("js tree started"); 
    //jsString.icon ='http://jstree.com/tree-icon.png';
    
    $j('#tree').jstree({
        "core" : {
            "theme" : {
                "variant" : "small"
            },
            "data" : jsString,
            "animation" : 800
        },
        "checkbox" : {
            "keep_selected_style" : false,
            'check_callback' : true
        },
        contextmenu: {
            select_node : false,
            items: function($node){
                return {
                    createItem : {
                        "label" : "Change Color",
                        "action" : function() {  
                            console.log("Context");
                            console.log($node.id); 
                            current_icon = $node.id; 
                            document.getElementById("color").color.showPicker();
                        },
                        "id" : "colorcontext",
                    }
                };
            }
        },
        "types" : {
            "default" : {
                "icon" : ''
            }
        },
        "plugins" : ["no-checkbox", "contextmenu","types"]
    });

    //$j('#tree').jstree('select_node', '00Eo0000000dW4VEAU');
    $j('#tree').jstree('select_node', '{!roleId}');
    loadAccounts('{!roleId}');

    window.changeColorValue = function(){
        console.log(current_icon);
        console.log("New Color value");
        var new_color = (document.getElementById("color").value);
        r= parseInt((new_color).substring(0,2),16);
        g= parseInt((new_color).substring(2,4),16);
        b= parseInt((new_color).substring(4,6),16);
        updateColorChanges(current_icon,r,g,b);
        $j('#tree').jstree('select_node', current_icon);
        loadAccounts(current_icon);
        $j("#tree").jstree(true).deselect_all();
        $j('#tree').jstree(true).refresh();
        document.getElementById("color").color.hidePicker();
       /* console.log(document.getElementById("color").value);
        console.log(r);
        console.log(g);
        console.log(b);
        style = document.createElement('style');
        style.type = 'text/css';
        style.innerHTML = '._' + (current_icon.split(" _",2))[1] + '{background: rgb(' + r + ',' +  g + ',' + b + ') !important;}';
        document.getElementsByTagName('head')[0].appendChild(style);
        $j('#tree').jstree(true).settings.core.data.children[2].children[0].children[0].children[5].icon = current_icon;
        $j("#tree").jstree(true).deselect_all();
        $j('#tree').jstree(true).refresh();
         document.getElementById("color").color.hidePicker();*/
    }

    var clickedNode = '';
    $j('#tree').bind("select_node.jstree", function(e, data){
        //console.log(data.node.text);
        if( (data.node.text.split(" ",3))[1] !="Territory"){
            $j('#tree').jstree('close_node', currentnode);
        }

        //$j('#tree').jstree('close_node', currentnode);
        map.removeAllLayers();
        map.addLayer(basemap);
        map.addLayer(Querylayer);
        map.addLayer(layer);
        map.reorderLayer(layer,2);
        concatAccount='';
        loadAccounts(data.node.id);
        clickedNode = data.node.id;
        console.log('---Node Id----');
        console.log(clickedNode);
    });
});

$j('#tree').bind("hover_node.jstree", function(e, data){
    // console.log("Data : " + data.node.data.toSource());
    // var extents_hover = extent1;
    console.log("Inside Hover Node");
    var highlightSymbol = new SimpleFillSymbol(
        SimpleFillSymbol.STYLE_SOLID, 
        new SimpleLineSymbol(
            SimpleLineSymbol.STYLE_SOLID, 
            new Color([20,20,20]), 3
        ), 
        new Color([125,125,125,0.35])
    );

    if(typeof extent1 != "undefined"){
        console.log("in_hover");
        var graphic = new Graphic(extent1, highlightSymbol);
        //console.log("graphic : " + graphic.toSource());
        map.graphics.clear();
        map.graphics.add(graphic);
    };
    //var nodeId = jQuery.data(data.rslt.obj[0], "jstree").id;               
});