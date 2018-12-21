({
    fetchRepos : function(component) {

        var params = {
            'hostingService': component.get('v.hostingService'),
            'isUser': component.get('v.isUser'),
            'domain': component.get('v.owner')
        };

        this.fetchData(component, 'c.getRepositoriesInDomain', params, 'repos');
    }
})
