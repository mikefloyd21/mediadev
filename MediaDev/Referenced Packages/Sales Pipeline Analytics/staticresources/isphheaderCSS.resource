.top_heading_info
{
    -webkit-box-sizing:border-box;
    -moz-box-sizing:border-box;
    box-sizing:border-box;
    background:none;
    border:none;
    display:block;
    float:left;
    margin-top:20px;
    margin-bottom:20px;
    padding:0;
    padding-top:10px;
    width:100%
}

.top_heading_info h1
{
    font-size:1.7em;
    min-height:33px
}

.top_heading_info #question_answer1
{
    -webkit-border-radius:2px;
    -moz-border-radius:2px;
    border-radius:2px;
    background-color:#FFF;
    color:#333;
    display:inline-block;
    font-size:1.7em;
    font-weight:200;
    margin-bottom:-50px;
    padding:2px 5px
}

.top_heading_info #question_answer2
{
    color:#666;
    display:inline-block;
    font-size:13px;
    font-weight:400;
    margin-bottom:-50px
}

.controls
{
    float:right;
    position:relative
}

.control
{
    height:30px;
    -webkit-transition:all .2s ease;
    -moz-transition:all .2s ease;
    border:2px solid #ccc;
    padding:0 4px
}

.control .image
{
    height:14px;
    width:14px;
    padding:8px 8px 0
}

.control .config_text
{
    position:relative;
    top:-2px;
    padding:0 4px;
    font-size:14px;
    font-weight:700;
    color:#666
}

.control:hover
{
    border:2px solid #00b3e9;
    cursor:pointer
}

.top_heading_info .controls .tooltip
{
    -webkit-transition:all .2s ease;
    -moz-transition:all .2s ease;
    display:block;
    max-width:100%;
    opacity:0;
    position:absolute;
    width:150px;
    z-index:1
}

.top_heading_info .controls .tooltip.tooltip_visible
{
    opacity:.85
}

.top_heading_info .controls .tooltip.tooltip_invisible
{
    display:none
}

.top_heading_info .controls .tooltip:hover
{
    cursor:default
}

.top_heading_info .controls .display_stage_config
{
    display:inline-block;
    margin-left:10px;
    vertical-align:top
}

.top_heading_info .controls #interval_picker
{
    height:34px;
    border:2px solid #ccc;
    padding:0 4px;
    display:inline-block;
    margin-left:10px;
    vertical-align:top;
    position:relative;
    padding:0 4px;
    font-size:14px;
    font-weight:700;
    color:#666
}

.top_heading_info .controls .display_date_picker
{
    display:inline-block;
    margin-left:10px;
    vertical-align:top
}