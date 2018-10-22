global with sharing class GitHostingRouter {
    
    private static final String ENDPOINT_FORMAT = 'callout:{0}{1}';
    private static final Integer PAGE_SIZE = 20;
    private static Map<String, Git_Hosting_Service__mdt> cachedConfig = new Map<String, Git_Hosting_Service__mdt>();
    
    /**
     * Obtain a list of existing repositories
     * @param  hostingService - Service that hosts the repositories
     * @param  isUser         - determines if the domain is from a user or a team
     * @param  domain         - user or team that owns the repos
     * @param  page           - page of the result set
     */
    @AuraEnabled(cacheable=true)
    global static GitServiceResponseModel getRepositoriesInDomain(String hostingService, Boolean isUser, String domain, Integer page) {

        GitServiceResponseModel responseModel;

        try {

            GitHostingService service = GitHostingRouter.getServiceInstance(hostingService);
            Git_Hosting_Service__mdt config = GitHostingRouter.getGitHostConfig(hostingService);

            String endpoint = String.format(ENDPOINT_FORMAT, new String[]{
                config.Named_Credential_Name__c, 
                String.format(isUser ? config.Get_Repos_Endpoint__c : config.Get_Team_Repos_Endpoint__c, new String[]{domain})
            });

            Map<String, String> params = new Map<String, String>{
                config.Page_Parameter__c => String.valueOf(page),
                config.Page_Size_Parameter__c => String.valueOf(PAGE_SIZE)
            };

            HttpResponse res = CalloutManager.sendRequest(endpoint, 'GET', params, null);

            responseModel = res.getStatusCode() == 200 ?
                            service.parseGetReposRequest(page, PAGE_SIZE, res) :
                            service.handleError(res);

        } catch (Exception e) {

            System.debug(e.getStackTraceString());
            responseModel = new GitServiceResponseModel(e.getMessage());
        }

        return responseModel;
    }

    /**
     * Obtain the hosting service apex instance
     * @param  hostingService - git hosting service name
     */
    private static GitHostingService getServiceInstance(String hostingService) {
        
        Git_Hosting_Service__mdt config = GitHostingRouter.getGitHostConfig(hostingService);

        if (config == null) {
            throw new InvalidServiceException('Hosting service not configured: ' + hostingService);
        }

        Type t = Type.forName(config.Apex_Class__c);
        return (GitHostingService)t.newInstance();
    }


    /**
     * Obtain the configured git hostings
     * @param  hostingService - git hosting service name
     */
    private static Git_Hosting_Service__mdt getGitHostConfig(String hostingService) {

        if (GitHostingRouter.cachedConfig.isEmpty()) {
            
            for (Git_Hosting_Service__mdt config : [SELECT MasterLabel, Apex_Class__c, Get_Repos_Endpoint__c, Get_Team_Repos_Endpoint__c, 
                                                    Named_Credential_Name__c, Page_Parameter__c, Page_Size_Parameter__c 
                                                    FROM Git_Hosting_Service__mdt]) {
                
                GitHostingRouter.cachedConfig.put(config.MasterLabel, config);
            }
        }

        return GitHostingRouter.cachedConfig.get(hostingService);
    }


    private class InvalidServiceException extends Exception {}
}
