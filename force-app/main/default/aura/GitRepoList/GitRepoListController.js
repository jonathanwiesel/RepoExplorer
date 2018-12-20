({
    doInit: function(component, event, helper) {
        helper.fetchRepos(component);
    },

    handlePageChange: function(component, event, helper) {
        helper.fetchRepos(component);
    },
})
