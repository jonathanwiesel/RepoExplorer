global with sharing class GitFileContentResponseModel {
    
    @AuraEnabled
    public String raw;
    @AuraEnabled
    public String error;

    public GitFileContentResponseModel(String data, String error) {
        this.raw = data;
        this.error = error;
    }
}
