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


    private static GitRepoModel getGihubRepoModel() {

        return new GitRepoModel(
            'Github', 
            'RepoExplorer', 
            'repoexplorer', 
            'jonathanwiesel/repoexplorer', 
            'jonathanwiesel', 
            false, 
            'https://github.com/jonathanwiesel/repoexplorer', 
            'master'
        );
    }

    private static GitRepoModel getBitbucketRepoModel() {

        return new GitRepoModel(
            'Bitbucket', 
            'RepoExplorer', 
            'repoexplorer', 
            'jonathanwiesel/repoexplorer', 
            'jonathanwiesel', 
            false, 
            'https://bitbucket.com/jonathanwiesel/repoexplorer', 
            'master'
        );
    }

    private static GitRepoModel getGitlabRepoModel() {

        return new GitRepoModel(
            'Gitlab', 
            'RepoExplorer', 
            'repoexplorer', 
            'jonathanwiesel/repoexplorer', 
            'jonathanwiesel', 
            false, 
            'https://gitlab.com/jonathanwiesel/repoexplorer', 
            'master'
        );
    }

    @isTest static void testGithubRepoTree() {

        GitRepoModel repo = GitHostingRepoTreeRouterTest.getGihubRepoModel();
        
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GithubFileTreeMockBody');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        
        Test.setMock(HttpCalloutMock.class, mock);

        GitRepoTreeResponseModel res;
        Test.startTest();
            res = GitHostingRepoTreeRouter.getFileTree(JSON.serialize(repo), null);
        Test.stopTest();

        GitHostingRepoTreeRouterTest.checkSuccessTreeResults(res);
    }


    @isTest static void testGithubRepoTreeError() {

        GitRepoModel repo = GitHostingRepoTreeRouterTest.getGihubRepoModel();

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GithubErrorMockBody');
        mock.setStatusCode(404);
        mock.setHeader('Content-Type', 'application/json');
        
        Test.setMock(HttpCalloutMock.class, mock);

        GitRepoTreeResponseModel res;
        Test.startTest();
            res = GitHostingRepoTreeRouter.getFileTree(JSON.serialize(repo), null);
        Test.stopTest();

        System.assertNotEquals(null, res.error);
        System.assertEquals(0, res.tree.size());
    }


    @isTest static void testBitbucketRepoTree() {

        GitRepoModel repo = GitHostingRepoTreeRouterTest.getBitbucketRepoModel();

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('BitbucketFileTreeMockBody');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        
        Test.setMock(HttpCalloutMock.class, mock);

        GitRepoTreeResponseModel res;
        Test.startTest();
            res = GitHostingRepoTreeRouter.getFileTree(JSON.serialize(repo), null);
        Test.stopTest();

        GitHostingRepoTreeRouterTest.checkSuccessTreeResults(res);
    }


    @isTest static void testBitbucketRepoTreeError() {

        GitRepoModel repo = GitHostingRepoTreeRouterTest.getBitbucketRepoModel();

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('BitbucketErrorMockBody');
        mock.setStatusCode(404);
        mock.setHeader('Content-Type', 'application/json');
        
        Test.setMock(HttpCalloutMock.class, mock);

        GitRepoTreeResponseModel res;
        Test.startTest();
            res = GitHostingRepoTreeRouter.getFileTree(JSON.serialize(repo), null);
        Test.stopTest();

        System.assertNotEquals(null, res.error);
        System.assertEquals(0, res.tree.size());
    }


    @isTest static void testGitlabRepoTree() {

        GitRepoModel repo = GitHostingRepoTreeRouterTest.getGitlabRepoModel();

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GitlabFileTreeMockBody');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        
        Test.setMock(HttpCalloutMock.class, mock);

        GitRepoTreeResponseModel res;
        Test.startTest();
            res = GitHostingRepoTreeRouter.getFileTree(JSON.serialize(repo), null);
        Test.stopTest();

        GitHostingRepoTreeRouterTest.checkSuccessTreeResults(res);
    }


    @isTest static void testGitlabRepoTreeError() {

        GitRepoModel repo = GitHostingRepoTreeRouterTest.getGitlabRepoModel();

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GitlabErrorMockBody');
        mock.setStatusCode(404);
        mock.setHeader('Content-Type', 'application/json');
        
        Test.setMock(HttpCalloutMock.class, mock);

        GitRepoTreeResponseModel res;
        Test.startTest();
            res = GitHostingRepoTreeRouter.getFileTree(JSON.serialize(repo), null);
        Test.stopTest();

        System.assertNotEquals(null, res.error);
        System.assertEquals(0, res.tree.size());
    }
}
