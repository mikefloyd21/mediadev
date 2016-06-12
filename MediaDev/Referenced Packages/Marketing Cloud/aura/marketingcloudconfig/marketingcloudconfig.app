<aura:application controller="LightningMarketingCloudConfigControl" access="GLOBAL">  
    <ltng:require scripts="/resource/et4ae5__jQuery,/resource/et4ae5__uxds/js/bootstrap.js" styles="/resource/et4ae5__uxds/css/bootstrap.min.css"/>
    
    <!-- Handlers -->
    <aura:handler name="init" value="{!this}" action="{!c.doInit}"/>
    <aura:handler event="et4ae5:StartWizzard" action="{!c.runWizzard}" /> 
    <aura:handler event="et4ae5:SkipWizzard" action="{!c.skipWizzard}" />
    <aura:handler event="et4ae5:ThrowErrorMessage" action="{!c.throwErrorMessage}" />
    <aura:handler event="aura:waiting" action="{!c.showSpinner}"/>
    <aura:handler event="aura:doneWaiting" action="{!c.hideSpinner}"/>
    
    <!--Markup -->
    <center><div class="mainSpinner" ><ui:spinner aura:id="mainSpinner"/></div></center>
    <div class="pull-right" style="padding:20px;">
	    <a href="/setup/forcecomHomepage.apexp?setupid=ForceCom">
	        <span class="glyphicon glyphicon-arrow-left" aria-hidden="true"></span>
	        {!$Label.et4ae5.backToSetup}
	    </a>
	     &nbsp;|&nbsp; 
	    <a target="_blank" href="https://help.exacttarget.com/v5_marketing_cloud_connector_home">
	    	{!$Label.et4ae5.hlpTrain}
	   	</a>
   	</div>
    <div class="container">
        <div aura:id="errorMessage"></div>  	 	
        <div aura:id="divSetup" class="hide">
            <et4ae5:Setup />
        </div>        
        <div aura:id="divAutomation" class="hide" >
            <et4ae5:Automation /> 
        </div>
        <div aura:id="divManual" class="hide">
            <et4ae5:Manual />
        </div>
    </div>
</aura:application>