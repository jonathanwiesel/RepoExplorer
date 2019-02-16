global with sharing class GitHostingRepoTreeRouter {
    
    @AuraEnabled(cacheable=true)
    global static GitRepoTreeResponseModel getFileTree(String stringifiedRepo, String path, Integer page, Integer pageSize) {

        page = Integer.valueOf(page);
        pageSize = Integer.valueOf(pageSize);

        if (path == null) {
            path = '';
        }

        GitRepoTreeResponseModel responseModel;

        try {

            GitRepoModel repo = (GitRepoModel)JSON.deserialize(stringifiedRepo, GitRepoModel.class);

            Git_Hosting_Service__mdt config = GitHostingConfig.getSpecificGitHost(repo.hostingService);
            GitHostingService service = GitHostingConfig.getServiceInstance(repo.hostingService);

            String endpoint = service.getRepoTreeEndpoint(repo.ownerPath, repo.path, path, repo.mainBranch);
            Map<String, String> params = service.getRepoTreeParams(page, pageSize);
            Map<String, String> headers = service.getRepoTreeHeaders();

            HttpResponse res = CalloutManager.sendRequest(config.Named_Credential_Name__c, endpoint, 'GET', params, headers);

            responseModel = res.getStatusCode() == 200 ?
                            service.parseGetFileTreeRequest(page, pageSize, res) :
                            new GitRepoTreeResponseModel(service.handleError(res));

        } catch (Exception e) {

            System.debug(e.getStackTraceString());
            responseModel = new GitRepoTreeResponseModel(e.getMessage());
        }

        responseModel.tree.sort();

        return responseModel;
    }
}
