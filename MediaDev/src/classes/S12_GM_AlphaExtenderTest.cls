@isTest
private class S12_GM_AlphaExtenderTest{
    static testMethod void testConstructorCodeCoverage() {
        S12_GM_AlphaExtender extender = new S12_GM_AlphaExtender(null);
        System.assertNotEquals(null, extender);
    }
}