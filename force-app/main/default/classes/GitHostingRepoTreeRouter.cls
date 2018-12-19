global with sharing class GitHostingRepoTreeRouter {
    
    @AuraEnabled(cacheable=true)
    global static GitRepoTreeResponseModel getFileTree(String stringifiedRepo, String path) {

        if (path == null) {
            path = '';
        }

        GitRepoTreeResponseModel responseModel;

        try {

            GitRepoModel repo = (GitRepoModel)JSON.deserialize(stringifiedRepo, GitRepoModel.class);

            Git_Hosting_Service__mdt config = GitHostingConfig.getSpecificGitHost(repo.hostingService);
            GitHostingService service = GitHostingConfig.getServiceInstance(repo.hostingService);

            String endpoint = GitHostingRepoTreeRouter.getFormattedRepoTreeEndpoint(config, repo.owner, repo.path, path, repo.mainBranch);

            HttpResponse res = CalloutManager.sendRequest(endpoint, 'GET', null, null);

            responseModel = res.getStatusCode() == 200 ?
                            service.parseGetFileTreeRequest(res) :
                            new GitRepoTreeResponseModel(service.handleError(res));

        } catch (Exception e) {

            System.debug(e.getStackTraceString());
            responseModel = new GitRepoTreeResponseModel(e.getMessage());
        }

        responseModel.tree.sort();

        return responseModel;
    }


    private static String getFormattedRepoTreeEndpoint(Git_Hosting_Service__mdt config, String ownerName, String repoSlug, String path, String branch) {

        return CalloutManager.getFormattedEndpoint(
            config.Named_Credential_Name__c, 
            String.format(config.Get_File_Tree_Endpoint__c, new String[]{ownerName, repoSlug, path, branch})
        );
    }
}
