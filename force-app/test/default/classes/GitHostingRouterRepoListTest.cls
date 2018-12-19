@isTest
private class GitHostingRouterRepoListTest {
    
    private static void checkSuccessRepoResults(GitRepoListResponseModel res) {

        System.assertEquals(null, res.error);
        System.assertNotEquals(0, res.repos.size());

        GitRepoModel repo = res.repos[0];
        System.assertNotEquals(null, repo.name);
        System.assertNotEquals(null, repo.slug);
        System.assertNotEquals(null, repo.ownerName);
        System.assertNotEquals(null, repo.ownerPath);
        System.assertNotEquals(null, repo.url);
        System.assertNotEquals(null, repo.isPrivate);
    }

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

        GitHostingRouterRepoListTest.checkSuccessRepoResults(res);
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

        GitHostingRouterRepoListTest.checkSuccessRepoResults(res);
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

        GitHostingRouterRepoListTest.checkSuccessRepoResults(res);
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


    @isTest static void testInvalidServiceResponse() {

        GitRepoListResponseModel res;
        Test.startTest();
            res = GitHostingRepoListRouter.getRepositoriesInDomain('Github', true, 'test', 1, 20);
        Test.stopTest();

        System.assertNotEquals(null, res.error);
        System.assertEquals(0, res.repos.size());
    }

}
