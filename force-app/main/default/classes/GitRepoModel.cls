global with sharing class GitRepoModel {
    
    @AuraEnabled
    public String name;
    @AuraEnabled
    public String slug;
    @AuraEnabled
    public String path;
    @AuraEnabled
    public String owner;
    @AuraEnabled
    public Boolean isPrivate;
    @AuraEnabled
    public String url;
    @AuraEnabled
    public String mainBranch;

    public GitRepoModel(String name, String path, String slug, String owner, Boolean isPrivate, String url, String mainBranch) {
        this.name = name;
        this.path = path;
        this.slug = slug;
        this.owner = owner;
        this.isPrivate = isPrivate;
        this.url = url;
        this.mainBranch = mainBranch;
    }
}
