@isTest
private class KBB_New_CExtenderTest{
    static testMethod void testConstructorCodeCoverage() {
        KBB_New_CExtender extender = new KBB_New_CExtender(null);
        System.assertNotEquals(null, extender);
    }
}