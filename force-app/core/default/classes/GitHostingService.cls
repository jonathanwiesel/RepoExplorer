global abstract with sharing class GitHostingService {
    
    public String serviceName;

    global abstract String getRepoListEndpoint(Boolean isUser, String domain);

    global abstract Map<String, String> getRepoListParams(Integer page, Integer pageSize);

    global abstract Map<String, String> getRepoListHeaders();

    global abstract String getRepoTreeEndpoint(String ownerPath, String repoPath, String path, String branch);

    global abstract Map<String, String> getRepoTreeParams(Integer page, Integer pageSize);

    global abstract Map<String, String> getRepoTreeHeaders();

    /**
     * Parse a success repository fetching request response
     * @param  page     - page asked for
     * @param  pageSize - page size configured
     * @param  res      - response object
     */
    global abstract GitRepoListResponseModel parseGetReposRequest(Integer page, Integer pageSize, HTTPResponse res);

    /**
     * Parse a success file tree fetching request response
     * @param  page     - page asked for
     * @param  pageSize - page size configured
     * @param  res - esponse object
     */
    global abstract GitRepoTreeResponseModel parseGetFileTreeRequest(Integer page, Integer pageSize, HTTPResponse res);

    /**
     * Handle errors with the API
     * @param  res - response object
     */
    global abstract String handleError(HttpResponse res);
}
