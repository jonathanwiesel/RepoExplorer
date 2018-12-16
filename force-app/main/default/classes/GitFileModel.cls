global with sharing class GitFileModel implements Comparable {
    
    public enum FileType {OTHER, DIRECTORY, FILE}

    @AuraEnabled
    public String name;
    @AuraEnabled
    public String path;
    @AuraEnabled
    public String type;
    public FileType fType;

    public GitFileModel(String name, String path, FileType fType) {
        this.name = name;
        this.path = path;
        this.fType = fType;
        this.type = fType.name();
    }

    global Integer compareTo(Object compareTo) {
        
        GitFileModel compareToFile = (GitFileModel)compareTo;

        if (this.fType != compareToFile.fType) {
            
            if (this.fType.ordinal() > compareToFile.fType.ordinal()) return 1;
            else return -1;
        
        } else {

            return this.name.compareTo(compareToFile.name);
        }
    }
}
