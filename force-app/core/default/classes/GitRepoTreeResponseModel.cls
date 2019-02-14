global with sharing class GitRepoTreeResponseModel {
    
    @AuraEnabled
    public Integer pageSize;
    @AuraEnabled
    public Integer currentPage;
    @AuraEnabled
    public Boolean hasPrevPage;
    @AuraEnabled
    public Boolean hasNextPage;
    @AuraEnabled
    public GitFileModel[] tree;
    @AuraEnabled
    public String error;

    public GitRepoTreeResponseModel(Integer pageSize, Integer currentPage, Boolean hasNextPage, GitFileModel[] tree) {
        this.pageSize = pageSize;
        this.currentPage = currentPage;
        this.hasPrevPage = this.currentPage > 1;
        this.hasNextPage = hasNextPage;
        this.tree = tree;
    }

    public GitRepoTreeResponseModel(String error) {
        this.error = error;
        this.tree = new GitFileModel[]{};
    }
}
