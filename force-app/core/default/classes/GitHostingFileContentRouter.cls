global with sharing class GitHostingFileContentRouter {
    
    @AuraEnabled(cacheable=true)
    global static GitFileContentResponseModel getFileContent(String stringifiedRepo, String path) {

        GitFileContentResponseModel responseModel;

        try {

            GitRepoModel repo = (GitRepoModel)JSON.deserialize(stringifiedRepo, GitRepoModel.class);

            Git_Hosting_Service__mdt config = GitHostingConfig.getSpecificGitHost(repo.hostingService);
            GitHostingService service = GitHostingConfig.getServiceInstance(repo.hostingService);

            String endpoint = service.getFileContentEndpoint(repo.ownerPath, repo.path, path, repo.mainBranch);
            Map<String, String> params = service.getFileContentParams();
            Map<String, String> headers = service.getFileContentHeaders();

            HttpResponse res = CalloutManager.sendRequest(config.Named_Credential_Name__c, endpoint, 'GET', params, headers);

            responseModel = res.getStatusCode() == 200 ?
                            service.parseGetFileContentRequest(res) :
                            new GitFileContentResponseModel(null, service.handleError(res));

        } catch (Exception e) {

            System.debug(e.getStackTraceString());
            responseModel = new GitFileContentResponseModel(null, e.getMessage());
        }

        return responseModel;
    }
}
