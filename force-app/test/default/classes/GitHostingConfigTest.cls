@isTest
private class GitHostingConfigTest {
    
    private static final String TEST_SERVICE = 'Github';

    @isTest static void testConfigGetter() {

        Map<String, Git_Hosting_Service__mdt> configsByName;

        Test.startTest();
            configsByName = GitHostingConfig.getGitHosts();
        Test.stopTest();

        System.assert(!configsByName.isEmpty());
    }


    @isTest static void testSpecificConfigGetter() {

        Git_Hosting_Service__mdt config;

        Test.startTest();
            config = GitHostingConfig.getSpecificGitHost(TEST_SERVICE);
        Test.stopTest();

        System.assertNotEquals(null, config);
    }


    @isTest static void testHostingInstance() {

        GitHostingService serviceInstace;

        Test.startTest();
            serviceInstace = GitHostingConfig.getServiceInstance(TEST_SERVICE);
        Test.stopTest();

        System.assertNotEquals(null, serviceInstace);
    }


    @isTest static void testInvalidHostingInstance() {

        GitHostingService serviceInstace;

        Test.startTest();

            try {
                
                serviceInstace = GitHostingConfig.getServiceInstance('New hosting');
                System.assert(false, 'Should not be configured');

            } catch (Exception e) {

                System.assert(e instanceof GitHostingConfig.InvalidServiceException);
            }

        Test.stopTest();
    }


    @isTest static void testLightinigDataSource() {

        GitHostingConfig dataSource = new GitHostingConfig();

        VisualEditor.DataRow defaultService;
        VisualEditor.DynamicPickListRows availableServices;

        Test.startTest();
            defaultService = dataSource.getDefaultValue();
            availableServices = dataSource.getValues();
        Test.stopTest();

        System.assertNotEquals(null, defaultService);
        System.assertNotEquals(0, availableServices.size());
    }
}
