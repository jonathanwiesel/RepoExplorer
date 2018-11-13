global with sharing class BitbucketHostingService extends GitHostingService {
    
    global override GitRepoListResponseModel parseGetReposRequest(Integer page, Integer pageSize, HTTPResponse res) {

        RepoListModel model = (RepoListModel)JSON.deserialize(res.getBody(), RepoListModel.class);

        GitRepoModel[] data = new GitRepoModel[]{};

        for (RepoModel repo : model.values) {
            data.add(new GitRepoModel(
                repo.name,
                repo.full_name,
                repo.owner.display_name,
                repo.is_private,
                repo.links.html.href
            ));
        }

        return new GitRepoListResponseModel(pageSize, page, model.next != null, data);
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
        Boolean is_private;
        String description;
        OwnerModel owner;
        WrapperLinkModel links;
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
}
