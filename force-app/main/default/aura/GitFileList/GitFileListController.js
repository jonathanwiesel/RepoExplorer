({  

    handleRepoChange: function(component, event, helper) {
        
        component.set('v.repo', event.getParam('repo'));
        component.set('v.filesPath', '');

        helper.goToFirstPage(component);
        helper.fetchFiles(component);
    },

    handlePathChange: function(component, event, helper) {

        helper.goToFirstPage(component);
        component.set('v.filesPath', event.getParam('selectedPath'));
        helper.fetchFiles(component);
    },

    handlePageChange: function(component, event, helper) {
        helper.fetchFiles(component);
    },
})
