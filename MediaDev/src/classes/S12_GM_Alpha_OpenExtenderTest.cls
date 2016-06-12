@isTest
private class S12_GM_Alpha_OpenExtenderTest{
    static testMethod void testConstructorCodeCoverage() {
        S12_GM_Alpha_OpenExtender extender = new S12_GM_Alpha_OpenExtender(null);
        System.assertNotEquals(null, extender);
    }
}