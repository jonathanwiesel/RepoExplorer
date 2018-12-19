global with sharing class GitRepoModel {
    
    @AuraEnabled
    public String hostingService;
    @AuraEnabled
    public String name;
    @AuraEnabled
    public String slug;
    @AuraEnabled
    public String path;
    @AuraEnabled
    public String ownerName;
    @AuraEnabled
    public String ownerPath;
    @AuraEnabled
    public Boolean isPrivate;
    @AuraEnabled
    public String url;
    @AuraEnabled
    public String mainBranch;

    public GitRepoModel(String hostingService, String name, String path, String slug, String ownerName, String ownerPath, Boolean isPrivate, String url, String mainBranch) {
        this.hostingService = hostingService;
        this.name = name;
        this.path = path;
        this.slug = slug;
        this.ownerName = ownerName;
        this.ownerPath = ownerPath;
        this.isPrivate = isPrivate;
        this.url = url;
        this.mainBranch = mainBranch;
    }
}
