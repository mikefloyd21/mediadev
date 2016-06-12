@charset "UTF-8";
/* CSS Document */

td{ line-height:20px; }
th{	color:#fff !important; background-color:#277AA8 !important; font-size:11.5px !important; line-height:20px;}  /* Common for Table headers     */
.clear{ clear:both; }
.notes{				 /*       Text in front of Text-Box     */
    height:25px;
    font-weight:bold;
    text-align:right;
    font-size:12px;
    width:105px !important;
    float:left;
    position:relative;
}
.notes-text-box{       /*        for Text-Box     */
    float:left;
    border:1px solid #333;
    width:180px !important;
    height:22px;
    padding-left: 5px;
}
.box-main{				 /*        main cell for the pageblock element     */
    width:100%;
    margin:30px auto;
}
.box-content{				/*        main cell for the content     */
    background-color:#f7f7f7;
    padding:5px;
    border:1px solid #cccccc;
}
.box-top{						/*        for the header and other important information (like headers, Search Box, Butons on the top     */
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
.box-top-div1{font-size:18px; float:left; height:25px; color:#666 !important; } /*        Place for header     */
.box-top-div2{ float:left; height:25px;}
.box-top-div3{ float:left; height:25px;}
.box-top-div4{ float:left; height:25px; text-align:right;}
.box-top-div5{ width:20%; float:right; height:25px; text-align:right; margin-right:3px;}/*        Place for Buttons     */

/*        Popup Items Start From here     */

.box-main-popup{
    width:100%;
    margin:-2px auto;
}
.box-content-popup{
    background-color:#fff;
    padding:5px;
    border:1px solid #000;
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
.box-top-div1-popup{
    font-weight:600;
    font-size:17px;
    float:left;
    height:25px;
    color:#666 !important;
}

/*        Popup Items Ends Here     */

.searchbutton1{			/*       For Search Button    */
    width:80px;
    height:23px;
    font-size:11px !important;
    margin-left:-80px !important;
    border:1px solid #666 !important;
    background-color:#55a4da !important;
    z-index:1;
}
.searchtxt1{		/*       For Search Text-Box    */
    border: 1px solid #666;
    border-radius: 3px;
    height: 21px;
    margin-left: 100px;
    padding-top: 0px;
    width: 235px;
}
.tree1{			/*      Tree Structure      */
    width:230px;
    vertical-align:top;
    float:left;
    height:500px;
    background-color:#fff;
    border:1px solid #989898;
    overflow-y:auto;
}
.table_header_tree{		/*      Tree Header Structure      */
    color:#fff !important;
    background-color:#277AA8 !important;
    font-size:12px !important;
    font-weight:bold;
    line-height:30px !important;
    padding-left:12px;
    -webkit-overflow-scrolling: touch;
}
.tablecontent{			/*      For Table pattern      */
    vertical-align:top;
    height:400px;
    background-color:#fff;
    margin-left:250px;
    border:1px solid #989898;
    font-size:12px;
    overflow-y:auto;
}
.table_header_main{			/*      For Table Header      */
    color:#404041 !important;
    background-color:#d1d2d4 !important;
    font-size:16px !important;
    text-align:center;
    line-height:30px !important;
}
.even{ background-color: #FFF !important;}	/*      Even Row Color In Table      */
.odd{background-color: #e6f5fc !important;}  /*      Odd Row Color In Table      */
.popup{top:10%;}  /*      For Popup      */

