// Jonathan Hersh - jhersh@salesforce.com
// November 13, 2008
// modified by Lynn Grande to improve code structure for Story B-21802 1/22/2016
// This will attach the email attachment on email to case to the actual case object
trigger emailAttachmentReassigner on Attachment (before insert) {
	for( Attachment a : trigger.new ) 
    {
        // Make sure there is a parent object
		if( a.parentid != null )
        {	
			String s = string.valueof( a.parentid );
			// Check the parent ID - if it's 02s, this is for an email message	
			// Then set parent of attachment to parent of email which should be case	
			if( s.substring( 0, 3 ) == '02s' )
				a.parentid = [select parentID from EmailMessage where id = :a.parentid].parentID;
        }	
	}
}