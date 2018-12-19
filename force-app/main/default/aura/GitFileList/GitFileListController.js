({  

    handleRepoChange: function(component, event, helper) {
        
        component.set('v.repo', event.getParam('repo'));
        component.set('v.filesPath', '');

        helper.fetchFiles(component);
    },

    handlePathChange: function(component, event, helper) {

        component.set('v.filesPath', event.getParam('selectedPath'));
        helper.fetchFiles(component);
    }
})
