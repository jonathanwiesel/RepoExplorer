global with sharing class GitHostingConfig extends VisualEditor.DynamicPickList {
    
    private static Map<String, Git_Hosting_Service__mdt> cachedConfig = new Map<String, Git_Hosting_Service__mdt>();

    /**
     * ***********************************
     * INHERTIED IMPLEMENTATION
     * ***********************************
     */

    global override VisualEditor.DataRow getDefaultValue(){
        
        Git_Hosting_Service__mdt config = GitHostingConfig.getGitHosts().values()[0];

        return new VisualEditor.DataRow(config.MasterLabel, config.MasterLabel);
    }

    global override VisualEditor.DynamicPickListRows getValues() {

        VisualEditor.DynamicPickListRows configuredHosts = new VisualEditor.DynamicPickListRows();

        for (String gitHostName : GitHostingConfig.getGitHosts().keySet()) {
            configuredHosts.addRow(new VisualEditor.DataRow(gitHostName, gitHostName));
        }

        return configuredHosts;
    }

    /**
     * ***********************************
     * STATIC IMPLEMENTATION
     * ***********************************
     */

    /**
     * Obtain the configured git hostings
     */
    global static Map<String, Git_Hosting_Service__mdt> getGitHosts() {

        if (GitHostingConfig.cachedConfig.isEmpty()) {
            
            for (Git_Hosting_Service__mdt config : [SELECT MasterLabel, Apex_Class__c, Get_Repos_Endpoint__c, Get_Team_Repos_Endpoint__c,
                                                    Get_File_Tree_Endpoint__c, 
                                                    Named_Credential_Name__c, Page_Parameter__c, Page_Size_Parameter__c 
                                                    FROM Git_Hosting_Service__mdt]) {
                
                GitHostingConfig.cachedConfig.put(config.MasterLabel, config);
            }
        }

        return GitHostingConfig.cachedConfig;
    }


    /**
     * Obtain git hosting config for a specific service
     * @param  hostingService - git hosting service name
     */
    global static Git_Hosting_Service__mdt getSpecificGitHost(String hostingService) {
        return GitHostingConfig.getGitHosts().get(hostingService);
    }


    /**
     * Obtain the hosting service apex instance
     * @param  hostingService - git hosting service name
     */
    global static GitHostingService getServiceInstance(String hostingService) {
        
        Git_Hosting_Service__mdt hostingConfig = GitHostingConfig.getSpecificGitHost(hostingService);

        if (hostingConfig == null) {
            throw new InvalidServiceException('Hosting service not configured: ' + hostingService);
        }

        Type t = Type.forName(hostingConfig.Apex_Class__c);
        return (GitHostingService)t.newInstance();
    }


    public class InvalidServiceException extends Exception {}
}
