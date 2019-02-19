global abstract with sharing class GitHostingService {
    
    public String serviceName;

    /**
     * Obtain endpoint to list available repos
     * @param  isUser - whether the domain to obtain repos is an user or a team
     * @param  domain - name of the user or team
     */
    global abstract String getRepoListEndpoint(Boolean isUser, String domain);

    /**
     * Obtain additional parameters to include in the request to obtain in list of repositories
     * @param  page     - current page of the list
     * @param  pageSize - amount of repos per page
     */
    global abstract Map<String, String> getRepoListParams(Integer page, Integer pageSize);

    /**
     * Obtan additional headers to include in the request to obtain in list of repositories
     */
    global virtual Map<String, String> getRepoListHeaders() {
        return null;
    }

    /**
     * Parse a success repository fetching request response
     * @param  page     - page asked for
     * @param  pageSize - page size configured
     * @param  res      - response object
     */
    global abstract GitRepoListResponseModel parseGetReposRequest(Integer page, Integer pageSize, HTTPResponse res);

    /**
     * Obtin endpoint to list available files in a repository path
     * @param  ownerPath - owner's path
     * @param  repoPath  - repository path
     * @param  path      - file path in which the files are included
     * @param  branch    - branch to obtain files from
     */
    global abstract String getRepoTreeEndpoint(String ownerPath, String repoPath, String path, String branch);

    /**
     * Obtain additional parameters to include in the request to obtain in list of files
     * @param  page     - current page of the list
     * @param  pageSize - amount of repos per page
     */
    global abstract Map<String, String> getRepoTreeParams(Integer page, Integer pageSize);

    /**
     * Obtan additional headers to include in the request to obtain in list of repositories
     */
    global virtual Map<String, String> getRepoTreeHeaders() {
        return null;
    }

    /**
     * Parse a success file tree fetching request response
     * @param  page     - page asked for
     * @param  pageSize - page size configured
     * @param  res - esponse object
     */
    global abstract GitRepoTreeResponseModel parseGetFileTreeRequest(Integer page, Integer pageSize, HTTPResponse res);

    /**
     * Obtin endpoint to get content for the specified file
     * @param  ownerPath - owner's path
     * @param  repoPath  - repository path
     * @param  path      - file path in which the file is included
     * @param  branch    - branch to obtain files from
     */
    global abstract String getFileContentEndpoint(String ownerPath, String repoPath, String path, String branch);

    /**
     * Obtain additional parameters to include in the request to obtain in file content
     */
    global virtual Map<String, String> getFileContentParams() {
        return null;
    }

    /**
     * Obtan additional headers to include in the request to obtain in file content
     */
    global virtual Map<String, String> getFileContentHeaders() {
        return null;
    }

    /**
     * Parse a success file content request response
     * @param  res      - response object
     */
    global abstract GitFileContentResponseModel parseGetFileContentRequest(HTTPResponse res);

    /**
     * Handle errors with the API
     * @param  res - response object
     */
    global abstract String handleError(HttpResponse res);
}
