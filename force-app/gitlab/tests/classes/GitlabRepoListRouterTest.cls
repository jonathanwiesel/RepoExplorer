@isTest
private class GitlabRepoListRouterTest {

    @isTest static void testGitlabRepoList() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GitlabReposMockBody');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        
        Test.setMock(HttpCalloutMock.class, mock);

        GitRepoListResponseModel res;
        Test.startTest();
            res = GitHostingRepoListRouter.getRepositoriesInDomain('Gitlab', true, 'test', 1, 20);
        Test.stopTest();

        GitHostingRepoListRouterTest.checkSuccessRepoResults(res);
    }

    @isTest static void testGitlabRepoListError() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GitlabErrorMockBody');
        mock.setStatusCode(404);
        mock.setHeader('Content-Type', 'application/json');
        
        Test.setMock(HttpCalloutMock.class, mock);

        GitRepoListResponseModel res;
        Test.startTest();
            res = GitHostingRepoListRouter.getRepositoriesInDomain('Gitlab', true, 'test', 1, 20);
        Test.stopTest();

        System.assertNotEquals(null, res.error);
        System.assertEquals(0, res.repos.size());
    }

}
