({
    doInit: function(component, event, helper) {
        helper.fetchRepos(component);
    },

    nextPage: function(component, event, helper) {

        var page = component.get('v.page');
        component.set('v.page', page + 1);
        helper.fetchRepos(component);
    },

    previousPage: function(component, event, helper) {

        var page = component.get('v.page');
        component.set('v.page', page - 1);
        helper.fetchRepos(component);
    },
})
