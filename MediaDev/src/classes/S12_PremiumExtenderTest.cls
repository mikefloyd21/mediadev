@isTest
private class S12_PremiumExtenderTest{
    static testMethod void testConstructorCodeCoverage() {
        S12_PremiumExtender extender = new S12_PremiumExtender(null);
        System.assertNotEquals(null, extender);
    }
}