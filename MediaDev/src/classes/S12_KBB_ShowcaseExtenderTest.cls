@isTest
private class S12_KBB_ShowcaseExtenderTest{
    static testMethod void testConstructorCodeCoverage() {
        S12_KBB_ShowcaseExtender extender = new S12_KBB_ShowcaseExtender(null);
        System.assertNotEquals(null, extender);
    }
}