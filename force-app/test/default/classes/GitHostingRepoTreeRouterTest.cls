@isTest
private class GitHostingRepoTreeRouterTest {
    
    private static void checkSuccessTreeResults(GitRepoTreeResponseModel res) {

        System.assertEquals(null, res.error);
        System.assertNotEquals(0, res.tree.size());

        GitFileModel file = res.tree[0];
        System.assertNotEquals(null, file.name);
        System.assertNotEquals(null, file.path);
        System.assertNotEquals(null, file.type);
    }


    @isTest static void testGithubRepoTree() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GithubFileTreeMockBody');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        
        Test.setMock(HttpCalloutMock.class, mock);

        GitRepoTreeResponseModel res;
        Test.startTest();
            res = GitHostingRepoTreeRouter.getFileTree('Github', 'jonathanwiesel', 'repoexplorer', null, 'master');
        Test.stopTest();

        GitHostingRepoTreeRouterTest.checkSuccessTreeResults(res);
    }


    @isTest static void testGithubRepoTreeError() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GithubErrorMockBody');
        mock.setStatusCode(404);
        mock.setHeader('Content-Type', 'application/json');
        
        Test.setMock(HttpCalloutMock.class, mock);

        GitRepoTreeResponseModel res;
        Test.startTest();
            res = GitHostingRepoTreeRouter.getFileTree('Github', 'jonathanwiesel', 'repoexplorer', null, 'master');
        Test.stopTest();

        System.assertNotEquals(null, res.error);
        System.assertEquals(0, res.tree.size());
    }


    @isTest static void testBitbucketRepoTree() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('BitbucketFileTreeMockBody');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        
        Test.setMock(HttpCalloutMock.class, mock);

        GitRepoTreeResponseModel res;
        Test.startTest();
            res = GitHostingRepoTreeRouter.getFileTree('Bitbucket', 'jonathanwiesel', 'repoexplorer', null, 'master');
        Test.stopTest();

        GitHostingRepoTreeRouterTest.checkSuccessTreeResults(res);
    }


    @isTest static void testBitbucketRepoTreeError() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('BitbucketErrorMockBody');
        mock.setStatusCode(404);
        mock.setHeader('Content-Type', 'application/json');
        
        Test.setMock(HttpCalloutMock.class, mock);

        GitRepoTreeResponseModel res;
        Test.startTest();
            res = GitHostingRepoTreeRouter.getFileTree('Bitbucket', 'jonathanwiesel', 'repoexplorer', null, 'master');
        Test.stopTest();

        System.assertNotEquals(null, res.error);
        System.assertEquals(0, res.tree.size());
    }


    @isTest static void testGitlabRepoTree() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GitlabFileTreeMockBody');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        
        Test.setMock(HttpCalloutMock.class, mock);

        GitRepoTreeResponseModel res;
        Test.startTest();
            res = GitHostingRepoTreeRouter.getFileTree('Gitlab', 'jonathanwiesel', 'repoexplorer', null, 'master');
        Test.stopTest();

        GitHostingRepoTreeRouterTest.checkSuccessTreeResults(res);
    }


    @isTest static void testGitlabRepoTreeError() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GitlabErrorMockBody');
        mock.setStatusCode(404);
        mock.setHeader('Content-Type', 'application/json');
        
        Test.setMock(HttpCalloutMock.class, mock);

        GitRepoTreeResponseModel res;
        Test.startTest();
            res = GitHostingRepoTreeRouter.getFileTree('Gitlab', 'jonathanwiesel', 'repoexplorer', null, 'master');
        Test.stopTest();

        System.assertNotEquals(null, res.error);
        System.assertEquals(0, res.tree.size());
    }
}
