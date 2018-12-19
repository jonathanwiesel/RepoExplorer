({
    showFilesFromRepo: function(component) {
        
        var repo = component.get('v.repo');

        var showFiles = $A.get('e.c:GitRepoSelected');
        showFiles.setParams({
            'repo': repo
        });
        showFiles.fire();
    }
})