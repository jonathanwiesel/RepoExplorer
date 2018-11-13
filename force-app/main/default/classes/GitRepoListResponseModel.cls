global with sharing class GitRepoListResponseModel {
    
    @AuraEnabled
    public Integer pageSize;
    @AuraEnabled
    public Integer currentPage;
    @AuraEnabled
    public Boolean hasPrevPage;
    @AuraEnabled
    public Boolean hasNextPage;
    @AuraEnabled
    public GitRepoModel[] repos;
    @AuraEnabled
    public String error;
    
    public GitRepoListResponseModel(Integer pageSize, Integer currentPage, Boolean hasNextPage, GitRepoModel[] data) {
        this.pageSize = pageSize;
        this.currentPage = currentPage;
        this.hasPrevPage = this.currentPage > 1;
        this.hasNextPage = hasNextPage;
        this.repos = data;
    }

    public GitRepoListResponseModel(String error) {
        this.error = error;
        this.repos = new GitRepoModel[]{};
    }
}
