@isTest
private class S12_KBB_Highlights_pageExtenderTest{
    static testMethod void testConstructorCodeCoverage() {
        S12_KBB_Highlights_pageExtender extender = new S12_KBB_Highlights_pageExtender(null);
        System.assertNotEquals(null, extender);
    }
}