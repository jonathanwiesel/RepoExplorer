global with sharing class GitlabHostingService extends GitHostingService {
    
    private static final String LINKS_HEADER_NAME = 'Link';
    private static final String NEXT_PAGE_LINK_IDENTIFIER = 'rel="next"';
    private static final String PUBLIC_VISIBILITY = 'public';

    global override String getRepoListEndpoint(Boolean isUser, String domain) {

        String placeholder = isUser ?
                            '/users/{0}/projects' :
                            '/groups/{0}/projects';
        
        return String.format(placeholder, new String[]{domain});
    }


    global override Map<String, String> getRepoListParams(Integer page, Integer pageSize) {
        return this.getPaginationParams(page, pageSize);
    }


    global override GitRepoListResponseModel parseGetReposRequest(Integer page, Integer pageSize, HTTPResponse res) {

        RepoModel[] models = (RepoModel[])JSON.deserialize(res.getBody(), RepoModel[].class);

        GitRepoModel[] data = new GitRepoModel[]{};

        for (RepoModel repo : models) {
            data.add(new GitRepoModel(
                this.serviceName,
                repo.name,
                repo.description,
                repo.path,
                repo.path_with_namespace,
                repo.owner != null ? repo.owner.name : repo.namespace.name,
                repo.owner != null ? repo.owner.username : repo.namespace.path,
                repo.visibility != PUBLIC_VISIBILITY,
                repo.web_url,
                repo.default_branch
            ));
        }

        String links = res.getHeader(LINKS_HEADER_NAME);
        Boolean hasNextPage = String.isNotBlank(links) && links.contains(NEXT_PAGE_LINK_IDENTIFIER);

        return new GitRepoListResponseModel(pageSize, page, hasNextPage, data);
    }


    global override String getRepoTreeEndpoint(String ownerPath, String repoPath, String path, String branch) {

        String placeholder = '/projects/{0}%2F{1}/repository/tree?path={2}&ref={3}';

        return String.format(placeholder, new String[]{
            ownerPath, repoPath, path, branch
        });
    }


    global override Map<String, String> getRepoTreeParams(Integer page, Integer pageSize) {
        return this.getPaginationParams(page, pageSize);
    }


    global override GitRepoTreeResponseModel parseGetFileTreeRequest(Integer page, Integer pageSize, HTTPResponse res) {
        
        FileModel[] models = (FileModel[])JSON.deserialize(res.getBody(), FileModel[].class);

        GitFileModel[] data = new GitFileModel[]{};

        for (FileModel file : models) {
            data.add(new GitFileModel(
                file.name,
                file.path,
                file.getFileType()
            ));
        }
        
        String links = res.getHeader(LINKS_HEADER_NAME);
        Boolean hasNextPage = String.isNotBlank(links) && links.contains(NEXT_PAGE_LINK_IDENTIFIER);

        return new GitRepoTreeResponseModel(pageSize, page, hasNextPage, data);
    }


    global override String handleError(HTTPResponse res) {

        ErrorModel model = (ErrorModel)JSON.deserialize(res.getBody(), ErrorModel.class);

        return String.isNotBlank(model.message) ? model.message : model.error;
    }


    private Map<String, String> getPaginationParams(Integer page, Integer pageSize) {
        
        return new Map<String, String>{
            'page' => String.valueOf(page),
            'per_page' => String.valueOf(pageSize)
        };
    }

    /**
     * *******************************
     * Serializing models
     * *******************************
     */

    private class RepoModel {

        String id;
        String visibility;
        String name;
        String path;
        String path_with_namespace;
        String web_url;
        String description;
        OwnerModel owner;
        NamespaceModel namespace;
        String default_branch;
    }


    private class OwnerModel {

        String id;
        String name;
        String username;
        String web_url;
    }

    
    private class NamespaceModel {

        String id;
        String name;
        String path;
    }


    private class ErrorModel {

        String error;
        String message;
    }


    private class FileModel {

        String id;
        String name;
        String type;
        String path;
    
        public GitFileModel.FileType getFileType() {

            switch on this.type {

                when 'blob' {
                    return GitFileModel.FileType.FILE;
                }

                when 'tree' {
                    return GitFileModel.FileType.DIRECTORY;
                }

                when else {
                    return GitFileModel.FileType.OTHER;
                }
            }
        }
    }
}
