({
    fetchData: function(component, actionName, params, responseListName) {

        var superComp = component.getSuper();

        this.toggleSpinner(superComp);

        var paginator = superComp.find('paginator');

        var action = component.get(actionName);

        params.page = paginator.getCurrentPage();
        params.pageSize = paginator.getPageSize();

        action.setParams(params);
        
        var _this = this;
        action.setCallback(this, function(response) {
            
            _this.toggleSpinner(superComp);
            var state = response.getState();
            
            if (state === 'SUCCESS') {
                
                var res = response.getReturnValue();
                
                if (res.error) {
                    _this.showError(superComp, res.error);
                    return;
                }

                _this.setPaginatorDirection(superComp, res.hasPrevPage, res.hasNextPage);
                superComp.set('v.items', res[responseListName]);

            } else if (state === "ERROR") {

                var errors = response.getError();
                
                if (errors && errors[0] && errors[0].message) {
                    
                    _this.showError(superComp, errors[0].message);

                } else {

                    _this.showError(superComp, 'Unknown error');
                }
            }
        });

        $A.enqueueAction(action);
    },
    
    
    showError: function(component, err) {
        component.find('alertLib').showErrorAlert(err);
    },


    toggleSpinner: function (component) {
        
        var spinner = component.find('loadingSpinner');
        $A.util.toggleClass(spinner, 'slds-hide');

        var working = component.get('v.working');
        component.set('v.working', !working);
    },


    goToFirstPage: function(component) {
        
        var paginator = component.getSuper().find('paginator');
        paginator.resetPage();
    },

    
    setPaginatorDirection: function(component, hasPrev, hasNext) {

        var paginator = component.find('paginator');
        paginator.setValues(hasPrev, hasNext);
    }
})
