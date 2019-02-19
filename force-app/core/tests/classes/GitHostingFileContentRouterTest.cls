@isTest
private class GitHostingFileContentRouterTest {
    
    @isTest static void testInvalidServiceResponse() {

        GitFileContentResponseModel res;
        Test.startTest();
            res = GitHostingFileContentRouter.getFileContent('keyboardcat', 'test');
        Test.stopTest();

        System.assertNotEquals(null, res.error);
        System.assertEquals(null, res.raw);
    }
}
