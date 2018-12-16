({
    showFilesFromRepo: function(component) {
        
        var repo = component.get('v.repo');

        var showFiles = $A.get('e.c:GitRepoSelected');
        showFiles.setParams({
            'hostingService': component.get('v.service'),
            'owner': repo.owner,
            'path': repo.path,
            'repoSlug': repo.slug,
            'branch': repo.mainBranch 
        });
        showFiles.fire();
    }
})