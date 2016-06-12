@isTest
private class S12_Premium_CoreExtenderTest{
    static testMethod void testConstructorCodeCoverage() {
        S12_Premium_CoreExtender extender = new S12_Premium_CoreExtender(null);
        System.assertNotEquals(null, extender);
    }
}