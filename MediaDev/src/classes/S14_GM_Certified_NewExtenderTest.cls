@isTest
private class S14_GM_Certified_NewExtenderTest{
    static testMethod void testConstructorCodeCoverage() {
        S14_GM_Certified_NewExtender extender = new S14_GM_Certified_NewExtender(null);
        System.assertNotEquals(null, extender);
    }
}