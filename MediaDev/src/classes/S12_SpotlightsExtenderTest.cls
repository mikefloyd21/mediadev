@isTest
private class S12_SpotlightsExtenderTest{
    static testMethod void testConstructorCodeCoverage() {
        S12_SpotlightsExtender extender = new S12_SpotlightsExtender(null);
        System.assertNotEquals(null, extender);
    }
}