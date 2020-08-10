@isTest
private class ParkLocatorTest {
    @isTest static void testCallout(){
        Test.setMock(WebServiceMock.class,new ParkServiceMock());
        String countryName = 'India';
        String[] result = ParkLocator.country(countryName);
        System.assertEquals(new String[] {'Anamudi Shola National Park', 'Anshi National Park', 'Bandipur National Park'}, result);
    }
}