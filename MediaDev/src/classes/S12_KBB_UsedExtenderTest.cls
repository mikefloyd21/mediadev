@isTest
private class S12_KBB_UsedExtenderTest{
    static testMethod void testConstructorCodeCoverage() {
        S12_KBB_UsedExtender extender = new S12_KBB_UsedExtender(null);
        System.assertNotEquals(null, extender);
    }
}