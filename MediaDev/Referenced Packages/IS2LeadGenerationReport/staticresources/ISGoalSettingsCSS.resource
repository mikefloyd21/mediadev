.modal_background {
	background: gray;
	display: none;
    width: 100%;
    height: 100%;
    position: fixed;
    top: 0;
    left: 0;
    z-index: 1000;
	-khtml-opacity:.50; 
	-moz-opacity:.50; 
	-ms-filter:"alpha(opacity=50)";
	filter:alpha(opacity=50);
	filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0.5);
	opacity:.50; }

#goal_settings_container {
	background: white;
	border: 0px solid #ccc;
	display: none;
	width: 600px;
	height: 300px;
	margin-top: -150px;
	margin-left: -300px;
	position: fixed;
	top: 50%;
	left: 50%;
	z-index: 1001;
    -moz-box-shadow: 0px 0px 40px #000;
	-webkit-box-shadow: 0px 0px 40px #000;
	box-shadow: 0px 0px 40px #000; }
  
    #goal_settings_header {
        background: #00b3e9;
        padding: 15px;
        border-top: 5px solid #0086af; }

        #goal_settings_header h1 {
            clear: left;
            color: #fff;
            display: block;
            float: left;
            font-size: 1.9em;
            letter-spacing: -1.4px;
            margin: 0px;
            padding: 0px; }

    #goal_settings_content {
        padding: 15px;
    }

    .goal_settings_text {
        color: #666;
        display: inline-block;
        font-size: 16px;
        font-weight: normal; }

    .goal_settings_label {
        color: #666;
        display: inline-block;
        font-size: 16px;
        width: 100px;
        font-weight: normal; }

        #goal_input_container {
            background: #fff;
            border-left: 5px solid #fff;
            display: inline-block;
            padding: 25px 15px;
            margin: 0px 15px 8px 15px;
            -webkit-transition: 0.3s all ease-in-out;
            -moz-transition: 0.3s all ease-in-out;
            -o-transition: 0.3s all ease-in-out;
            transition: 0.3s all ease-in-out; }

        #goal_input_container input, #goal_input_container input:focus {
            border: 1px solid #bbbbbb;
            border-radius: 3px;
            -moz-border-radius: 3px;
            -webkit-border-radius: 3px;
            outline: 0;
            padding: 8px 5px 5px 5px;
            color: #424242;
            font-size: 16px;
            font-weight: bold;
            margin-left: 20px; }

      .error_container {
           color: #e96955;
           font-size: 13px;
           font-weight: bold;
           margin-top: -27px;
           display: none; }

    #goal_settings_footer {
        background: #eeeeee;
        padding: 10px;
        position: absolute;
        bottom: 0;
        width: 580px;
        border-top: 2px solid #d4d4d4; }
    
        #set_goal_button input {
            background: #5FBA50;
            background-color: #5FBA50;
            background-image: -webkit-linear-gradient(top, #5FBA50 0%,#50AA41 100%);
            background-image: -ms-linear-gradient(top, #5FBA50 0%,#409F31 100%);
            background-image: linear-gradient(to bottom, #5FBA50 0%,#409F31 100%);
            background-image: -webkit-gradient(linear, 50% 100%, 50% 0%, from(rgba(0, 0, 0, 0.0976563)), to(rgba(255, 255, 255, 0.0976563)));
            background-image: -moz-linear-gradient(top, #5FBA50 0%, #409F31 100%);
            background-position: 91% center;
            background-repeat: no-repeat;
            border: 1px solid rgba(0,0,0,.1);
            border-bottom: 1px solid rgba(0,0,0,.3);
            border-radius: 2px;
            box-shadow: rgba(0, 0, 0, 0.2) 0px 1px 2px 0px;
            -moz-border-radius: 2px;
            -webkit-border-radius: 2px;
            color: #fff;
            display: inline-block;
            float: right;
            font-size: 12px;
            font-weight: bold;
            padding: 4px 3px;
            margin: 0;
            margin-left: 10px;
            margin-top: 7px;
            height: 30px;
            width: 90px;
            text-decoration: none !important;
            text-shadow: 0px 1px 0px rgba(0, 0, 0, .4);
            text-align: center;
            transition: background-color .2s ease-in-out, color .2s ease-in-out;
            -moz-transition: background-color .2s ease-in-out, color .2s ease-in-out;
            -ms-transition: background-color .2s ease-in-out, color .2s ease-in-out;
            -webkit-transition: background-position 0 none;
            -webkit-transition: background-color .2s ease-in-out, color .2s ease-in-out;
            vertical-align: middle; }

        #goal_settings_footer #cancel_button {
            background: #e5e5e5;
            background-color: #e5e5e5;
            background-image: -webkit-linear-gradient(top, #e5e5e5 0%,#dadada 100%);
            background-image: -ms-linear-gradient(top, #e5e5e5 0%,#dadada 100%);
            background-image: linear-gradient(to bottom, #e5e5e5 0%,#dadada 100%);
            background-image: -webkit-gradient(linear, 50% 100%, 50% 0%, from(rgba(0, 0, 0, 0.0976563)), to(rgba(255, 255, 255, 0.0976563)));
            background-image: -moz-linear-gradient(top, #e5e5e5 0%, #dadada 100%);
            background-position: 91% center;
            background-repeat: no-repeat;
            border: 1px solid rgba(0,0,0,.1);
            border-bottom: 1px solid rgba(0,0,0,.2);
            border-radius: 2px;
            box-shadow: rgba(0, 0, 0, 0.2) 0px 1px 2px 0px;
            -moz-border-radius: 2px;
            -webkit-border-radius: 2px;
            color: #8b8b8b;
            cursor:pointer;
            display: inline-block;
            float: right;
            font-size: 12px;
            font-weight: bold;
            padding: 4px 3px;
            margin: 0;
            margin-left: 30px;
            margin-top: 7px;
            height: 30px;
            width: 90px;
            text-decoration: none !important;
            text-align: center;
            transition: background-color .2s ease-in-out, color .2s ease-in-out;
            -moz-transition: background-color .2s ease-in-out, color .2s ease-in-out;
            -ms-transition: background-color .2s ease-in-out, color .2s ease-in-out;
            -webkit-transition: background-position 0 none;
            -webkit-transition: background-color .2s ease-in-out, color .2s ease-in-out;
            vertical-align: middle; }
    