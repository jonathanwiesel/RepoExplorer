global with sharing class BitbucketHostingService extends GitHostingService {
    
    global override String getRepoListEndpoint(Boolean isUser, String domain) {

        String placeholder ='/repositories/{0}';
        
        return String.format(placeholder, new String[]{domain});
    }


    global override Map<String, String> getRepoListParams(Integer page, Integer pageSize) {
        return this.getPaginationParams(page, pageSize);
    }


    global override GitRepoListResponseModel parseGetReposRequest(Integer page, Integer pageSize, HTTPResponse res) {

        RepoListModel model = (RepoListModel)JSON.deserialize(res.getBody(), RepoListModel.class);

        GitRepoModel[] data = new GitRepoModel[]{};

        for (RepoModel repo : model.values) {
            data.add(new GitRepoModel(
                this.serviceName,
                repo.name,
                repo.description,
                repo.slug,
                repo.full_name,
                repo.owner.display_name,
                repo.owner.username,
                repo.is_private,
                repo.links.html.href,
                repo.mainbranch.name
            ));
        }

        return new GitRepoListResponseModel(pageSize, page, model.next != null, data);
    }


    global override String getRepoTreeEndpoint(String ownerPath, String repoPath, String path, String branch) {

        String placeholder = '/repositories/{0}/{1}/src/{2}/{3}';

        return String.format(placeholder, new String[]{
            ownerPath, repoPath, branch, path
        });
    }


    global override Map<String, String> getRepoTreeParams(Integer page, Integer pageSize) {
        return this.getPaginationParams(page, pageSize);
    }


    global override GitRepoTreeResponseModel parseGetFileTreeRequest(Integer page, Integer pageSize, HTTPResponse res) {
        
        FileListModel model = (FileListModel)JSON.deserialize(res.getBody(), FileListModel.class);

        GitFileModel[] data = new GitFileModel[]{};

        for (FileModel file : model.values) {
            data.add(new GitFileModel(
                file.getName(),
                file.path,
                file.getFileType()
            ));
        }

        return new GitRepoTreeResponseModel(pageSize, page, model.next != null, data);
    }


    global override String getFileContentEndpoint(String ownerPath, String repoPath, String path, String branch) {

        String placeholder = '/repositories/{0}/{1}/src/{2}/{3}';

        return String.format(placeholder, new String[]{
            ownerPath, repoPath, branch, path
        });
    }
    

    global override GitFileContentResponseModel parseGetFileContentRequest(HTTPResponse res) {
    
        return new GitFileContentResponseModel(res.getBody(), null);
    }


    global override String handleError(HTTPResponse res) {

        ErrorModel model = (ErrorModel)JSON.deserialize(res.getBody(), ErrorModel.class);

        return model.error.message;
    }


    private Map<String, String> getPaginationParams(Integer page, Integer pageSize) {
        
        return new Map<String, String>{
            'page' => String.valueOf(page),
            'pagelen' => String.valueOf(pageSize)
        };
    }

    /**
     * *******************************
     * Serializing models
     * *******************************
     */

    private virtual class GeneralResponseModel {

        public Integer pagelen;
        public Integer page;
        public Integer size; 
        public String next;
        public String previous;
    }

    private class RepoListModel extends GeneralResponseModel {

        public RepoModel[] values;
    }

    private class RepoModel {
        
        String uuid;
        String name;
        String language;
        String created_on;
        String full_name;
        String slug;
        Boolean is_private;
        String description;
        OwnerModel owner;
        WrapperLinkModel links;
        BrachModel mainbranch;
    }


    private class OwnerModel {

        String username;
        String display_name;
        String uuid;
        WrapperLinkModel links;
    }


    private class WrapperLinkModel {
        LinkModel html;
        LinkModel self;
    }

    private class LinkModel {
        String href;
    }


    private class ErrorModel {

        String type;
        ErrorMessageModel error;
    }

    private class ErrorMessageModel {

        String message;
    }


    private class BrachModel {

        String type;
        String name;
    }


    private class FileListModel extends GeneralResponseModel {

        FileModel[] values;   
    }


    private class FileModel {

        String path;
        String type;

        public String getName() {
            
            String[] pathParts = this.path.split('/');

            return pathParts[pathParts.size() - 1];
        }

        public GitFileModel.FileType getFileType() {

            switch on this.type {

                when 'commit_file' {
                    return GitFileModel.FileType.FILE;
                }

                when 'commit_directory' {
                    return GitFileModel.FileType.DIRECTORY;
                }

                when else {
                    return GitFileModel.FileType.OTHER;
                }
            }
        }
    }
}
