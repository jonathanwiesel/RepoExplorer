({
    changePath : function(component) {

        var dirSelected = component.getEvent('dirSelected');
        dirSelected.setParams({'selectedPath' : component.get('v.pathObj').fullPath});
        dirSelected.fire();
    }
})
