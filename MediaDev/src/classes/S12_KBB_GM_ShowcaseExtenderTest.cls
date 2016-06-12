@isTest
private class S12_KBB_GM_ShowcaseExtenderTest{
    static testMethod void testConstructorCodeCoverage() {
        S12_KBB_GM_ShowcaseExtender extender = new S12_KBB_GM_ShowcaseExtender(null);
        System.assertNotEquals(null, extender);
    }
}