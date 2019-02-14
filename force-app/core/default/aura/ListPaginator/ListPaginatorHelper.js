({
    changePage : function(component) {

        var pageChanged = component.getEvent('pageChanged');
        pageChanged.fire();
    }
})
