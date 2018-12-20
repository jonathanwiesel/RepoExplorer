({
    nextPage: function(component, event, helper) {

        var page = component.get('v.page');
        component.set('v.page', page + 1);
        helper.changePage(component);
    },

    previousPage: function(component, event, helper) {

        var page = component.get('v.page');
        component.set('v.page', page - 1);
        helper.changePage(component);
    },


    getCurrentPage: function(component, event, helper) {
        return component.get('v.page');
    },


    getPageSize: function(component, event, helper) {
        return component.get('v.size');
    },

    resetPage: function(component, event, helper) {
        component.set('v.page', 1);
    },

    setValues: function(component, event, helper) {
        
        var params = event.getParam('arguments');
        component.set('v.hasNext', params.hasN);
        component.set('v.hasPrevious', params.hasP);
    }
})
