@isTest
private class BitbucketRepoTreeRouterTest {

    @isTest static void testBitbucketRepoTree() {

        GitRepoModel repo = GitHostingRepoTreeRouterTest.getRepoModel('Bitbucket');

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('BitbucketFileTreeMockBody');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        
        Test.setMock(HttpCalloutMock.class, mock);

        GitRepoTreeResponseModel res;
        Test.startTest();
            res = GitHostingRepoTreeRouter.getFileTree(JSON.serialize(repo), null, 1, 20);
        Test.stopTest();

        GitHostingRepoTreeRouterTest.checkSuccessTreeResults(res);
    }


    @isTest static void testBitbucketRepoTreeError() {

        GitRepoModel repo = GitHostingRepoTreeRouterTest.getRepoModel('Bitbucket');

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('BitbucketErrorMockBody');
        mock.setStatusCode(404);
        mock.setHeader('Content-Type', 'application/json');
        
        Test.setMock(HttpCalloutMock.class, mock);

        GitRepoTreeResponseModel res;
        Test.startTest();
            res = GitHostingRepoTreeRouter.getFileTree(JSON.serialize(repo), null, 1, 20);
        Test.stopTest();

        System.assertNotEquals(null, res.error);
        System.assertEquals(0, res.tree.size());
    }
}
