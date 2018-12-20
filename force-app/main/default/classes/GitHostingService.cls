global abstract with sharing class GitHostingService {
    
    public String serviceName;

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
