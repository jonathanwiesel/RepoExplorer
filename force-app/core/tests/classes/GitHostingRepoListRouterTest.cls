@isTest
public class GitHostingRepoListRouterTest {
    
    @TestVisible private static void checkSuccessRepoResults(GitRepoListResponseModel res) {

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


    @isTest static void testInvalidServiceResponse() {

        GitRepoListResponseModel res;
        Test.startTest();
            res = GitHostingRepoListRouter.getRepositoriesInDomain('Github', true, 'test', 1, 20);
        Test.stopTest();

        System.assertNotEquals(null, res.error);
        System.assertEquals(0, res.repos.size());
    }

}
