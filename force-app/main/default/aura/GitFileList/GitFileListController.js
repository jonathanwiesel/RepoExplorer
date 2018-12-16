({  

    handleRepoChange: function(component, event, helper) {
        
        component.set('v.hostingService', event.getParam('hostingService'));
        component.set('v.owner', event.getParam('owner'));
        component.set('v.repoPath', event.getParam('path'));
        component.set('v.repoSlug', event.getParam('repoSlug'));
        component.set('v.branch', event.getParam('branch'));
        helper.fetchFiles(component);
    },

    handlePathChange: function(component, event, helper) {

        component.set('v.filesPath', event.getParam('selectedPath'));
        helper.fetchFiles(component);
    }
})
