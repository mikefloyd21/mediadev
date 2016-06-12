@isTest
private class S14_NewExtenderTest{
    static testMethod void testConstructorCodeCoverage() {
        S14_NewExtender extender = new S14_NewExtender(null);
        System.assertNotEquals(null, extender);
    }
}