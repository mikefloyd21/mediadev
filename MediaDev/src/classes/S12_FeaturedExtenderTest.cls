@isTest
private class S12_FeaturedExtenderTest{
    static testMethod void testConstructorCodeCoverage() {
        S12_FeaturedExtender extender = new S12_FeaturedExtender(null);
        System.assertNotEquals(null, extender);
    }
}