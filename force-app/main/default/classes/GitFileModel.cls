global with sharing class GitFileModel {
    
    public enum FileType {FILE, DIRECTORY, OTHER}

    @AuraEnabled
    public String name;
    @AuraEnabled
    public String path;
    @AuraEnabled
    public FileType type;

    public GitFileModel(String name, String path, FileType type) {
        this.name = name;
        this.path = path;
        this.type = type;
    }
}
