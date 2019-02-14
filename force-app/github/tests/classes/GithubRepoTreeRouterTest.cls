@isTest
private class GithubRepoTreeRouterTest {

    @isTest static void testGithubRepoTree() {

        GitRepoModel repo = GitHostingRepoTreeRouterTest.getRepoModel('Github');
        
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GithubFileTreeMockBody');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        
        Test.setMock(HttpCalloutMock.class, mock);

        GitRepoTreeResponseModel res;
        Test.startTest();
            res = GitHostingRepoTreeRouter.getFileTree(JSON.serialize(repo), null, 1, 20);
        Test.stopTest();

        GitHostingRepoTreeRouterTest.checkSuccessTreeResults(res);
    }


    @isTest static void testGithubRepoTreeError() {

        GitRepoModel repo = GitHostingRepoTreeRouterTest.getRepoModel('Github');

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GithubErrorMockBody');
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
