@isTest
private class S12_KBB_Used_CExtenderTest{
    static testMethod void testConstructorCodeCoverage() {
        S12_KBB_Used_CExtender extender = new S12_KBB_Used_CExtender(null);
        System.assertNotEquals(null, extender);
    }
}