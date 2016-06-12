<?xml version="1.0" encoding="UTF-8" ?>
<ComponentDefinition xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="AppComponent_Schema.xsd" version="1.0">
	<Title>ATG TerraSky Components</Title>
	<Description>Auto Trader Group custom components for the TerraSky Visual Editor.</Description>
	<Publisher>C-Level Management, Inc.</Publisher>
	<PackageImage resourceName="C_Level_Logo_50x50" />
	<WebSite>http://www.c-levelmgmt.com</WebSite>
	
	<AppComponents>
		<AppComponent name="OppProdFormHeader">
			<Title>Opp Prod Form Header</Title>
			<!-- <HelpURL>help documentation pdf url</HelpURL> -->
			<Description>Opp Product Form Header</Description>
			<Layout>block</Layout>
			<Height value="272" resizable="false" isVisible="false" />
			<Width value="1024" resizable="false" isVisible="false" />
			<ComponentImage resourceName="C_Level_Logo_50x50" />
			<CanvasImage resourceName="ATG_Common_Header" stretch="Fill" />
			
			<PutablePlaces>
				<Place name="canvas" />
			</PutablePlaces>
			
			<DirectComponent>
				<DirectComponentBody><![CDATA[
<c:OppProdFormHeader record="{!record}" extender="{!extender}" currentAppProperties="{!currentAppProperties}" />
				]]></DirectComponentBody>
			</DirectComponent>
			
			<IncludeScript name="TerraSkyCustom" path="js/atg-opp-prod-common.js" />
			<IncludeStylesheet name="TerraSkyCustom" path="css/atg-opp-prod-common.css" />
			
			<!-- <Properties>
				<String name="formTitle" label="Form Title" defaultValue="Change the Form Title Attribute" isRequired="true" tooltip="This is the form title in the gray box to the right side of the header." />
			</Properties> -->
		</AppComponent>
	</AppComponents>
</ComponentDefinition>