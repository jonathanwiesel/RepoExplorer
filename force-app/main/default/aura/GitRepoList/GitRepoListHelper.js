({
    fetchRepos : function(component) {

        this.toggleSpinner(component);

        var paginator = component.find('paginator');

        var getReposAction = component.get('c.getRepositoriesInDomain');
        getReposAction.setParams({
            'hostingService': component.get('v.hostingService'),
            'isUser': component.get('v.isUser'),
            'domain': component.get('v.owner'),
            'page': paginator.getCurrentPage(),
            'pageSize': paginator.getPageSize()
        });
        
        var _this = this;
        getReposAction.setCallback(this, function(response) {
            
            _this.toggleSpinner(component);
            var state = response.getState();
            
            if (state === 'SUCCESS') {
                
                var res = response.getReturnValue();
                
                if (res.error) {
                    _this.showError(component, res.error);
                    return;
                }

                _this.setPaginatorDirection(component, res.hasPrevPage, res.hasNextPage);
                component.set('v.repos', res.repos);

            } else if (state === "ERROR") {

                var errors = response.getError();
                
                if (errors && errors[0] && errors[0].message) {
                    
                    _this.showError(component, errors[0].message);

                } else {

                    _this.showError(component, 'Unknown error');
                }
            }
        });

        $A.enqueueAction(getReposAction);
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


    setPaginatorDirection: function(component, hasPrev, hasNext) {

        var paginator = component.find('paginator');
        paginator.setValues(hasPrev, hasNext);
    }
})
