global with sharing class GitHostingRouter {
    
    private static final String ENDPOINT_FORMAT = 'callout:{0}{1}';
    private static Map<String, Git_Hosting_Service__mdt> cachedConfig = new Map<String, Git_Hosting_Service__mdt>();
    
    /**
     * Obtain a list of existing repositories
     * @param  hostingService - Service that hosts the repositories
     * @param  isUser         - determines if the domain is from a user or a team
     * @param  domain         - user or team that owns the repos
     * @param  page           - page of the result set
     */
    @AuraEnabled(cacheable=true)
    global static GitServiceResponseModel getRepositoriesInDomain(String hostingService, Boolean isUser, String domain, Integer page, Integer pageSize) {

        page = Integer.valueOf(page);
        pageSize = Integer.valueOf(pageSize);

        GitServiceResponseModel responseModel;

        try {

            Git_Hosting_Service__mdt config = GitHostingConfig.getSpecificGitHost(hostingService);
            GitHostingService service = GitHostingConfig.getServiceInstance(hostingService);

            String endpoint = GitHostingRouter.getFormattedRepoListEndpoint(config, isUser, domain);
            Map<String, String> params = GitHostingRouter.getPaginationParams(config, page, pageSize);

            HttpResponse res = CalloutManager.sendRequest(endpoint, 'GET', params, null);

            responseModel = res.getStatusCode() == 200 ?
                            service.parseGetReposRequest(page, pageSize, res) :
                            service.handleError(res);

        } catch (Exception e) {

            System.debug(e.getStackTraceString());
            responseModel = new GitServiceResponseModel(e.getMessage());
        }

        return responseModel;
    }

    /**
     * Obtain a formatted repo list endpoint
     * @param  config - git hosting configuration object
     * @param  isUser - determines if the domain is from a user or a team
     * @param  domain - user or team that owns the repos
     */
    private static String getFormattedRepoListEndpoint(Git_Hosting_Service__mdt config, Boolean isUser, String domain) {
        
        return String.format(ENDPOINT_FORMAT, new String[]{
            config.Named_Credential_Name__c, 
            String.format(isUser ? config.Get_Repos_Endpoint__c : config.Get_Team_Repos_Endpoint__c, new String[]{domain})
        });
    }


    /**
     * Obtain additional parameters to send in the request
     * @param  config   - git hosting configuration object
     * @param  page     - page number being requested
     * @param  pageSize - amount of results per page
     */
    private static Map<String, String> getPaginationParams(Git_Hosting_Service__mdt config, Integer page, Integer pageSize) {

        return new Map<String, String>{
            config.Page_Parameter__c => String.valueOf(page),
            config.Page_Size_Parameter__c => String.valueOf(pageSize)
        };
    }
}
