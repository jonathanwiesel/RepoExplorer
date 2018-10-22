global with sharing class GitServiceResponseModel {
    
    @AuraEnabled
    public Integer pageSize;
    @AuraEnabled
    public Integer currentPage;
    @AuraEnabled
    public Boolean hasPrevPage;
    @AuraEnabled
    public Boolean hasNextPage;
    @AuraEnabled
    public Object[] data;
    @AuraEnabled
    public String error;
    
    public GitServiceResponseModel(Integer pageSize, Integer currentPage, Boolean hasNextPage, Object[] data) {
        this.pageSize = pageSize;
        this.currentPage = currentPage;
        this.hasPrevPage = this.currentPage > 1;
        this.hasNextPage = hasNextPage;
        this.data = data;
    }

    public GitServiceResponseModel(String error) {
        this.error = error;
    }
}
