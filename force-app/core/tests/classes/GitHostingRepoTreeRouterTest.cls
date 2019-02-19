@isTest
public class GitHostingRepoTreeRouterTest {

   @TestVisible 
   private static GitRepoModel getRepoModel(String service) {

        return new GitRepoModel(
            service, 
            'RepoExplorer', 
            'Really cool Salesforce LC',
            'repoexplorer', 
            'jonathanwiesel/repoexplorer',
            'Jonathan Wiesel',
            'jonathanwiesel', 
            false, 
            'https://test.com/jonathanwiesel/repoexplorer', 
            'master'
        );
    }

    @TestVisible
    private static void checkSuccessTreeResults(GitRepoTreeResponseModel res) {

        System.assertEquals(null, res.error);
        System.assertNotEquals(0, res.tree.size());

        GitFileModel file = res.tree[0];
        System.assertNotEquals(null, file.name);
        System.assertNotEquals(null, file.path);
        System.assertNotEquals(null, file.type);
    }


    @isTest static void testInvalidServiceResponse() {

        GitRepoTreeResponseModel res;
        Test.startTest();
            res = GitHostingRepoTreeRouter.getFileTree('keyboardcat', 'test', 1, 20);
        Test.stopTest();

        System.assertNotEquals(null, res.error);
        System.assertEquals(0, res.tree.size());
    }
}
