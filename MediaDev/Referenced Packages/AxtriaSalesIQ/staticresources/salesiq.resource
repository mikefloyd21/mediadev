@charset "UTF-8";
/* CSS Document */

.notes{
    height:25px;
    font-weight:bold;
    text-align:right;
    font-size:12px;
    width:105px !important;
    float:left;
    position:relative;
}

.notes-text-box{
    float:left;
    border:1px solid #333;
    width:180px !important;
    height:22px;
    padding-left: 5px;
}

#legend {
    background-color: #ffffff;
  border-radius: 7px;
  height: 106px;
  left: 118px;
  opacity: 0.75;
  position: absolute;
  right: 1px;
  top: 350px;
  width: 181px;
  z-index: 3;
}

#school {
float: left;
margin-left: 3px;
margin-top: 3px;
max-width: 160px;
}

.circle1 {
    border-radius: 50%;
    display: inline-block;  
    
}

#circle3 {
    height: 14px;
    position: relative;
    width: 14px;    
}

.square1 {
    width: 12px !important; 
    height: 12px !important; 
    
}


.diamond1 {
	width: 0;
	height: 0;
	border: 8px solid transparent;
	border-bottom-color: black;
	position: relative;
	top: -8px;
}
.diamond1:after {
	content: '';
	position: absolute;
	left: -8px;
	top: 8px;
	width: 0;
	height: 0;
	border: 8px solid transparent;
	border-top-color: black;
}

.triangle1 {
	width: 0; 
    height: 0; 
	border-left: 8px solid transparent;
	border-right: 8px solid transparent;
	border-bottom: 14px solid black;
}
.container{
    overflow:auto;
    height:250px;
}

.box-main{
    width:100%;
    margin:30px auto;
}

.box-main-popup{
    width:100%;
    margin:-2px auto;
}

.box-popup{
    width:99%;
    margin:0px auto;
    -moz-box-shadow: 0px 0px 10px rgba(0, 0, 0, 1);
    -webkit-box-shadow: 0px 0px 10px rgba(0, 0, 0, 1);
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 1); 
    border-top-left-radius: 10px;
    border-top-right-radius: 10px;            
}

.box-content{
    background-color:#f7f7f7;
    padding:5px;
    border:1px solid #cccccc;
}

.box-content-popup{
    background-color:#fff;
    padding:5px;
    border:1px solid #000;
}

.box-top{
    border-top:3px solid #00335B;
    -moz-border-top:3px solid #00335B;
    -webkit-border-top:3px solid #00335B;
    border-top-left-radius:10px;
    border-top-right-radius:10px;
    -moz-border-top-left-radius:10px;
    -moz-border-top-right-radius:10px;
    -webkit-border-top-left-radius:10px;
    -webkit-border-top-right-radius:10px;
    background-color:#F8F8F8;
    border-left:1px solid #cccccc;
    border-right:1px solid #cccccc;
    color:#000;
    padding:12px 0 0 15px;
    font-weight:600;
    font-size:18px;
    height:30px;
} 

.box-top-popup{
    border-top:3px solid #00335B;
    -moz-border-top:3px solid #00335B;
    -webkit-border-top:3px solid #00335B;
    border-top-left-radius:10px;
    border-top-right-radius:10px;
    -moz-border-top-left-radius:10px;
    -moz-border-top-right-radius:10px;
    -webkit-border-top-left-radius:10px;
    -webkit-border-top-right-radius:10px;
    background-color:#F8F8F8;
    border-left:1px solid #000;
    border-right:1px solid #000;
    color:#000;
    padding:12px 0 0 15px;
    font-weight:600;
    font-size:18px;
    height:30px;
} 

.tablecontent{
    vertical-align:top;
    height:400px;
    background-color:#fff;
    margin-left:250px;
    border:1px solid #989898;
    font-size:12px;
    overflow-y:auto;
}

#map{
    vertical-align:top;
    height:500px;
    background-color:#fff;
    margin-left:250px;
    border:1px solid #989898;
    font-size:12px;
    overflow-y:auto;
}

.box-top-div1{
    width:30%;
    font-weight:600;
    font-size:18px;
    float:left;
    height:25px;
    color:#666 !important;
}

.box-top-div1-popup{
    width:80%;
    font-weight:600;
    font-size:17px;
    float:left;
    height:25px;
    color:#666 !important;
}

.box-top-div2{
    width:10%;
    font-weight:600;
    font-size:14px;
    float:left;
    height:25px;
}

.box-top-div3{
    width:10%;
    font-weight:600;
    font-size:14px;
    float:left;
    height:25px;
}

.box-top-div4{
    width:27%;
    font-weight:600;
    font-size:12px;
    float:left;
    height:25px;
    text-align:right;
}

.box-top-div5{
    width:20%;
    font-size:13px;
    float:right;
    height:25px;
    text-align:right;
    margin-right:3px;
}

.searchbutton1{
    width:80px;
    height:23px;
    font-size:11px !important;
    margin-left:-80px !important;
    border:1px solid #3fa9f5 !important;
    background-color:#55a4da !important;
    z-index:1;
}

.searchtxt1{
    border: 1px solid #3fa9f5;
    border-radius: 5px;
    height: 21px;
    margin-left: 100px;
    padding-top: 0px;
    width: 235px;
}

.button{
   padding:1px 10px !important;
   border:1px solid #3fa9f5 !important;
   font-size:11px !important;
   font-weight:bold !important;
   height:22px !important;
   text-align:right;
}

.tree1{
    width:230px;
    vertical-align:top;
    float:left;
    height:500px;
    background-color:#fff;
    border:1px solid #989898;
    overflow-y:auto;
}

.clear{
    clear:both;
}

th{
    color:#fff !important;
    background-color:#277AA8 !important;
    font-size:11.5px !important;
    line-height:20px;
}

.table_header_tree{
    color:#fff !important;
    background-color:#277AA8 !important;
    font-size:12px !important;
    font-weight:bold;
    line-height:30px !important;
    padding-left:12px;
    -webkit-overflow-scrolling: touch;
}

.table_header_main{
    color:#404041 !important;
    background-color:#d1d2d4 !important;
    font-size:16px !important;
    text-align:center;
    line-height:30px !important;
}

td{
    line-height:20px ;
}

.even { 
    background-color: White !important;
}

.odd {
    background-color: #e6f5fc !important; 
}

.number{
    text-align: left;
}

.text{
    text-align:center;
}

.table{
    border:1px solid ;
    line-height:25px !important;
}

.table-side-header{
    margin-left:20px;
    text-align:left;
    font-weight:bold;
}

.pure-table{
    border-collapse:collapse;
    border-spacing:0;
    empty-cells:show;
    border:1px solid #cbcbcb;
}

.pure-table caption{
    color:#000;
    font:italic 85%/1 arial,sans-serif;
    padding:1em 0;
    text-align:center;
}

.pure-table td,.pure-table th{
    border-left:1px solid #cbcbcb;
    border-width:0 0 0 1px;
    font-size:inherit;
    line-height:20px;
    margin:0;
    overflow:visible;
    padding:.25em .50em
}

.pure-table td:first-child,.pure-table th:first-child{
    border-left-width:0;
}

.pure-table thead{
    background:#e0e0e0;
    color:#000;
    text-align:left;
    vertical-align:bottom;
}

.pure-table td{
    background-color:transparent;
}

.pure-table-odd td{
    background-color:#e6f5fc;
}

.pure-table-striped tr:nth-child(2n-1) td{
    background-color:#f2f2f2;
}

.pure-table-bordered td{
    border-bottom:1px solid #cbcbcb;
}

.pure-table-bordered tbody>tr:last-child td,.pure-table-horizontal tbody>tr:last-child td{
    border-bottom-width:0;
}

.pure-table-horizontal td,.pure-table-horizontal th{
    border-width:0 0 1px;
    border-bottom:1px solid #cbcbcb;
}

.pure-table-horizontal tbody>tr:last-child td{
    border-bottom-width:0;
}

span.dynatree-node a{
        font-size :9pt!important ;
}

.wrapper1 .tooltip {
    color: black;
    display: block;
    left: 92px;
    margin-bottom: 15px; 
    opacity: 0;
    padding: 20px;
    pointer-events: none;
    position: absolute;
    -webkit-transform: translateY(10px);
    -moz-transform: translateY(10px);
    -ms-transform: translateY(10px);
    -o-transform: translateY(10px);
    transform: translateY(10px);
    -webkit-transition: all .25s ease-out;
    -moz-transition: all .25s ease-out;
    -ms-transition: all .25s ease-out;
    -o-transition: all .25s ease-out;
    transition: all .25s ease-out;
    -webkit-box-shadow: 2px 2px 6px rgba(0, 0, 0, 0.28);
    -moz-box-shadow: 2px 2px 6px rgba(0, 0, 0, 0.28);
    -ms-box-shadow: 2px 2px 6px rgba(0, 0, 0, 0.28);
    -o-box-shadow: 2px 2px 6px rgba(0, 0, 0, 0.28);
    box-shadow: 2px 2px 6px rgba(0, 0, 0, 0.28);
}

.link{
    text-decoration:underline;
    color:#0b71be !important;
    font-weight:normal !important;
    padding-right:10px;
}

.datavalue{
    height:300px;
    overflow:auto;
}

.Popup3{
    white-space: nowrap;
    z-index: 0;
    left: 50%;
    top:20%;
    margin-top:-142px;
    position: absolute;
    width: 700px;
    margin-left: -350px;
}

.popup_top_info{
    background-color: #e3e3e3;
    border-bottom: 1px solid #000;
    border-top-left-radius: 10px;
    border-top-right-radius: 10px;
    font-size: 18px;
    height: 34px;
    margin-right: 0;
    margin-top: 0;
    padding: 10px 316px 9px 5px;
}

.popuptaleheader {
    background: none repeat scroll 0 0 #3f99f5;
    border: 1px solid #000;
    color: #fff;
    font-weight: bold;
    text-align: center;
    white-space: nowrap;
}

.popup_message{
    font-size: 14px;
    line-height: 20px;
    padding-left: 3%;
    text-align: left;
    white-space: normal;
}

.popup-td{
    width:90px;
    font-weight:bold;
    color:#5c5d5d;
    text-align:right;
    padding-right:10px;
    height:28px;
}

.popup-textbox{
    width:100px;
    border:1px solid #999;
    height:18px;
}

.popup-button{
    color: white !important;
    margin:5px 5px !important;
    padding:3px 10px !important;
    background: #36647D !important; 
}

.popupBackground{
    background-color:black;
    opacity: 0.20;
    filter: alpha(opacity = 20);
    position: absolute;
    width: 100%;
    height: 100%;
    top: 0;
    left: 0;
    z-index: 0;
}

#navToolbar{
    top:34px !important;
    right:16px !important;
    opacity:1 !important;
}

.checkbox{
    border:1px solid #999;
    margin-right:10px;
}

.custPopup{
    background-color: white;
    border-width: 2px;
    border-style: solid;
    z-index: 9999;
    left: 50%;
    padding:10px;
    position: absolute;
    /* These are the 3 css properties you will need to change so the popup 
    displays in the center of the screen. First set the width. Then set 
    margin-left to negative half of what the width is. You can add 
    the height property for a fixed size pop up if you want.*/
    width: 500px;
    margin-left: -250px;
    top:100px;
}

.popupBackground{
    background-color:black;
    opacity: 0.20;
    filter: alpha(opacity = 20);
    position: absolute;
    width: 100%;
    height: 100%;
    top: 0;
    left: 0;
    z-index: 9998;
}

#color{
    width: 20%;
}

.popup{
    z-index: 9999;
    left: 50%;
    position: absolute;
    width: 500px;
    margin-left: -250px;
    top:50%;
}

.popupBg{
    background-color:black;
    opacity: 0.20;
    filter: alpha(opacity = 70);
    position: absolute;
    width: 100%;
    height: 100%;
    top: 0;
    left: 0;
    z-index: 9998;
}

.circle{
    height: 15px !important;
    width: 15px !important;
    border-radius: 50%;
    display: inline-block;
    margin-top:5px !important;
    //opacity: 0.75;
}

.square{
    height: 15px !important;
    width: 15px !important;
    //border-radius: 50%;
    display: inline-block;
    margin-top:5px !important;
    //opacity: 0.75;
}

th.tablesorter-header{ 
    background-image: {!$Resource.sortcenter}; 
    cursor: pointer; 
    font-weight: bold; 
    background-repeat: no-repeat; 
    background-position: center left; 
    padding-left: 20px; 
    border-right: 1px solid #dad9c7; 
    margin-left: -1px; 
}

th.tablesorter-headerDesc{ 
    background-image: {!$Resource.arrowdown}; 
    background-color: #3399FF; 
}

th.tablesorter-headerAsc { 
    background-image: {!$Resource.arrowup}; 
    background-color: #3399FF; 
}

#main-div{
    width:100%;
    height:100%;
}

.container{
    overflow:auto;
    height:250px;
}

.content-div{
    width:100%;
    height:50%;
}

.impact-div{
    width:50%;
    height:100%;
    float:left;
}

.impacts{
    width:100%;
    height:50%;
}

.impact-table-header{
    width:100%;
    height:25px;
    font-size:1.2em;
    font-weight:bold;
    font-family:arial;
    color:#FFFFFF;
    background-color:#1797C0;
}

.page-block-table{
    overflow:scroll;
}