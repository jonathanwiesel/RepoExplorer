@isTest
private class GitlabRepoTreeRouterTest {

    @isTest static void testGitlabRepoTree() {

        GitRepoModel repo = GitHostingRepoTreeRouterTest.getRepoModel('Gitlab');

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GitlabFileTreeMockBody');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        
        Test.setMock(HttpCalloutMock.class, mock);

        GitRepoTreeResponseModel res;
        Test.startTest();
            res = GitHostingRepoTreeRouter.getFileTree(JSON.serialize(repo), null, 1, 20);
        Test.stopTest();

        GitHostingRepoTreeRouterTest.checkSuccessTreeResults(res);
    }


    @isTest static void testGitlabRepoTreeError() {

        GitRepoModel repo = GitHostingRepoTreeRouterTest.getRepoModel('Gitlab');

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GitlabErrorMockBody');
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
