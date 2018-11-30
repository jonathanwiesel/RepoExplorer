global with sharing class GitRepoTreeResponseModel {
    
    @AuraEnabled
    public GitFileModel[] tree;
    @AuraEnabled
    public String error;

    public GitRepoTreeResponseModel(GitFileModel[] tree) {
        this.tree = tree;
    }

    public GitRepoTreeResponseModel(String error) {
        this.error = error;
        this.tree = new GitFileModel[]{};
    }
}
