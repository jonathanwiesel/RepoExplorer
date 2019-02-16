global with sharing class GitHostingRepoListRouter {
        
    /**
     * Obtain a list of existing repositories
     * @param  hostingService - Service that hosts the repositories
     * @param  isUser         - determines if the domain is from a user or a team
     * @param  domain         - user or team that owns the repos
     * @param  page           - page of the result set
     */
    @AuraEnabled(cacheable=true)
    global static GitRepoListResponseModel getRepositoriesInDomain(String hostingService, Boolean isUser, String domain, Integer page, Integer pageSize) {

        page = Integer.valueOf(page);
        pageSize = Integer.valueOf(pageSize);

        GitRepoListResponseModel responseModel;

        try {

            Git_Hosting_Service__mdt config = GitHostingConfig.getSpecificGitHost(hostingService);
            GitHostingService service = GitHostingConfig.getServiceInstance(hostingService);

            String endpoint = service.getRepoListEndpoint(isUser, domain);
            Map<String, String> params = service.getRepoListParams(page, pageSize);
            Map<String, String> headers = service.getRepoListHeaders();

            HttpResponse res = CalloutManager.sendRequest(config.Named_Credential_Name__c, endpoint, 'GET', params, headers);

            responseModel = res.getStatusCode() == 200 ?
                            service.parseGetReposRequest(page, pageSize, res) :
                            new GitRepoListResponseModel(service.handleError(res));

        } catch (Exception e) {

            System.debug(e.getStackTraceString());
            responseModel = new GitRepoListResponseModel(e.getMessage());
        }

        return responseModel;
    }
}
