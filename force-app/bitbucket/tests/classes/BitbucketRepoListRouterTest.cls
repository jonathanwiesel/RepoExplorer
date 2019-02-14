@isTest
private class BitbucketRepoListRouterTest {

    @isTest static void testBitbucketRepoList() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('BitbucketReposMockBody');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        
        Test.setMock(HttpCalloutMock.class, mock);

        GitRepoListResponseModel res;
        Test.startTest();
            res = GitHostingRepoListRouter.getRepositoriesInDomain('Bitbucket', true, 'test', 1, 20);
        Test.stopTest();

        GitHostingRepoListRouterTest.checkSuccessRepoResults(res);
    }

    @isTest static void testBitbucketRepoListError() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('BitbucketErrorMockBody');
        mock.setStatusCode(404);
        mock.setHeader('Content-Type', 'application/json');
        
        Test.setMock(HttpCalloutMock.class, mock);

        GitRepoListResponseModel res;
        Test.startTest();
            res = GitHostingRepoListRouter.getRepositoriesInDomain('Bitbucket', true, 'test', 1, 20);
        Test.stopTest();

        System.assertNotEquals(null, res.error);
        System.assertEquals(0, res.repos.size());
    }

}
