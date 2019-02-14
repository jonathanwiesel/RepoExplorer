@isTest
private class GithubRepoListRouterTest {

    @isTest static void testGithubRepoList() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GithubReposMockBody');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        
        Test.setMock(HttpCalloutMock.class, mock);

        GitRepoListResponseModel res;
        Test.startTest();
            res = GitHostingRepoListRouter.getRepositoriesInDomain('Github', true, 'test', 1, 20);
        Test.stopTest();

        GitHostingRepoListRouterTest.checkSuccessRepoResults(res);
    }


    @isTest static void testGithubRepoListError() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GithubErrorMockBody');
        mock.setStatusCode(404);
        mock.setHeader('Content-Type', 'application/json');
        
        Test.setMock(HttpCalloutMock.class, mock);

        GitRepoListResponseModel res;
        Test.startTest();
            res = GitHostingRepoListRouter.getRepositoriesInDomain('Github', true, 'test', 1, 20);
        Test.stopTest();

        System.assertNotEquals(null, res.error);
        System.assertEquals(0, res.repos.size());
    }
}
