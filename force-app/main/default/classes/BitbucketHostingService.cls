global with sharing class BitbucketHostingService extends GitHostingService {
    
    global override GitRepoListResponseModel parseGetReposRequest(Integer page, Integer pageSize, HTTPResponse res) {

        RepoListModel model = (RepoListModel)JSON.deserialize(res.getBody(), RepoListModel.class);

        GitRepoModel[] data = new GitRepoModel[]{};

        for (RepoModel repo : model.values) {
            data.add(new GitRepoModel(
                this.serviceName,
                repo.name,
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


    global override GitRepoTreeResponseModel parseGetFileTreeRequest(HTTPResponse res) {
        
        FileListModel models = (FileListModel)JSON.deserialize(res.getBody(), FileListModel.class);

        GitFileModel[] data = new GitFileModel[]{};

        for (FileModel file : models.values) {
            data.add(new GitFileModel(
                file.getName(),
                file.path,
                file.getFileType()
            ));
        }

        return new GitRepoTreeResponseModel(data);
    }


    global override String handleError(HTTPResponse res) {

        ErrorModel model = (ErrorModel)JSON.deserialize(res.getBody(), ErrorModel.class);

        return model.error.message;
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
